/**
    Actualizacion de Registros de Clientes
    Autor: Luis Espinoza
    04/FEB/2020
**/
public class MJModificarClienteAPI {
    
    public static integer contadorCreaciones;	
   	public static integer contadorActualizaciones;
    public static Map<Id,String> registroErroresCreacion;
    public static Map<Id,String> registroErroresActualizacion;    
    
    public static void updateSEUSAccount(set<Id> accountIdSet){
		System.debug('CLIENTE: Ingresa al metodo MJModificarClienteAPI');
        String errores = '';
		//se prepara la solicitud al ws
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LABEL.SEUSWSActualizarCliente);
        req.setMethod('POST');
        req.setTimeout(120000);
        
		If(registroErroresActualizacion == null){
        	registroErroresActualizacion = new Map<Id,String>(); 
		}
		//objeto log para registrar los errores
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeConsumo , ClassName__c='MJModificarClienteAPI', success__c=false);
		Message__c message = new Message__c();
		
        //Lista para manejo de errores y reeenvio
        Set<Id> clientesConError = new Set<ID>();
        If(contadorActualizaciones == null){
            contadorActualizaciones = 0;
		}
        contadorActualizaciones ++;
        
        //se Instancia la clase para Obtener el Token
        MJAuthenticationAPI.Authentication auth = MJAuthenticationAPI.getAccessToken(LABEL.SEUSWSUser, LABEL.SEUSWSPassword, LABEL.SEUSWSToken);
                
		req.setHeader('Authorization','Bearer '+auth.token);
		req.setHeader('Content-Type', 'application/json');
				
		//Se consultan los registros de cliente que se mandar a actualizar
		list<Account> accountList = [Select Id , ParentId, RecordTypeId,  RecordType.DeveloperName , Identificacion__c , IdCliente__c , AccountNumber, AccountSource, BillingState, BillingCity , BillingCountry , BillingLatitude , BillingLongitude , BillingStreet , Industry ,
		OwnerId , Ownership , Phone , Rating , ShippingState , ShippingCity , ShippingCountry , ShippingLatitude , ShippingLongitude , ShippingStreet , Type , AnioInicio__c , PersonBirthdate , PersonDepartment , PersonDoNotCall , PersonEmail , FirstName , MiddleName , PersonHomePhone , LastName , PersonMobilePhone , 
		Empresa__c , TipodeEnvioDocumentacion__c , 	TipodeIdentificacion__c , CuentasconSaldo__c , CuentasalDia__c , Sexo__c , Estado_civil__C , Ocupacion__C
		From Account Where Id IN: accountIdSet];
            
		if(accountList.size()>0){
			String body = null;
			for(Account a: accountList)
			{
				
				try{
					Cliente model = new Cliente(a);
					//body = JSON.serialize(model);
					body = JSON.serialize(model);
					body = body.replace('_x' , '__c');
					system.debug('CLIENTE: El Body es:' +body);
					req.setBody(body);
					HttpResponse res = http.send(req);
					system.debug('CLIENTE: La Respuesta es: '+res.getBody());
					a.SEUSWSUpdateErrorMessage__c='OK';
					WSResponse response = parseResponse(res.getBody());
					system.debug(response);
					logRequest.success__c=response.success;
					String mensaje = (response.messageLog!=null)?response.messageLog:response.message;
					logRequest.message__c='CLIENTE: '+a.IdCliente__c+': '+mensaje;
					a.SEUSWSSuccess__c = response.success!=true?false:true;
					
					if(response.success==false)
					{
						clientesConError.add(a.id);
						If(registroErroresActualizacion.containsKey(a.id)){
							registroErroresActualizacion.put(a.id, registroErroresActualizacion.get(a.id) +'\n' + contadorActualizaciones + '. MJModificarClienteAPI: '+response.message);
						}else{
							registroErroresActualizacion.put(a.id,contadorActualizaciones + '. MJModificarClienteAPI: '+response.message);
						}
						//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
						If(contadorActualizaciones == 3){
							a.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(a.id);
						}
					}
				}catch(Exception ex){
					System.debug('CLIENTE: Causa: '+ex.getCause() + ' Mensaje: '+ ex.getMessage());                    	
					clientesConError.add(a.id);
					If(registroErroresActualizacion.containsKey(a.id)){
						registroErroresActualizacion.put(a.id, registroErroresActualizacion.get(a.id) +'\n' + contadorActualizaciones + '. MJModificarClienteAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}else{
						registroErroresActualizacion.put(a.id,contadorActualizaciones + '. MJModificarClienteAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}
					
					//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
					If(contadorActualizaciones == 3){
						a.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(a.id);
						a.SEUSWSSuccess__c=false;
					}
					errores =+ 'CLIENTE: Error actualizando cliente  ' + a.IdCliente__c + ' ---Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage() + '\n';
				}				
			}
			//Notificar al Usuario, solo el resultado de la primer llamada
			if(contadorActualizaciones==1){
				system.debug('Se le alerta al usuario...');
				message = new Message__c(User__c=UserInfo.getUserId() ,  Date__c = system.now() , Title__c = 'Cliente' , Message__c = logRequest.message__c);				
			}
			
			//realizar 3 intentos para actualizar registros
			If(clientesConError.size() != 0 && contadorActualizaciones <= 2){
				System.debug('CLIENTE: Re-intento '+contadorActualizaciones);
				//esperar x milisegundos para siguiente llamada:
				Integer tiempoEspera = Integer.ValueOf(LABEL.SEUSWSReCallTime);
				Util.wait(tiempoEspera);				
				updateSEUSAccount(clientesConError);
			}
			
			If(errores != '' && errores != null && contadorActualizaciones == 3){
				MJEmailManager.sendError(errores);
				logRequest.message__c=errores;
			}
			
			TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
			update accountList;
			TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
				  
			Insert logRequest;
		}
		
		//si el token necesita crearse/actualizarse
		If(auth.needsUpdate == true){
			auth.upsertToken();
		}
		
		//insert message;
    }

    public class Cliente{
        
		public String Identificacion {get;set;} 
		public String IdCliente {get;set;} 
		public String AccountNumber {get;set;} 
		public String AccountSource {get;set;} 
		public String BillingState {get;set;} 
		public String BillingCity {get;set;} 
		public String BillingCountry {get;set;} 
		public Double BillingLatitude {get;set;} 
		public Double BillingLongitude {get;set;} 
		public String BillingStreet {get;set;} 
		public String Industry {get;set;} 
		public Integer OwnerId {get;set;} 
		public Integer Ownership {get;set;} 
		public String Phone {get;set;} 
		public String Name {get;set;} 
		public String Rating {get;set;} 
		public String RecordTypeId {get;set;} 
		public String ShippingState {get;set;} 
		public String ShippingCity {get;set;} 
		public String ShippingCountry {get;set;} 
		public Double ShippingLatitude {get;set;} 
		public Double ShippingLongitude {get;set;} 
		public String ShippingStreet {get;set;} 
		public String Type {get;set;}
		public String YearStarted {get;set;} 
		public String Birthdate {get;set;} 
		public String Department {get;set;} 
		public String DoNotCallboolean {get;set;} 
		public String Email {get;set;} 
		public String FirstName {get;set;} 
		public String MiddleName {get;set;} 
		public String HomePhone {get;set;} 
		public String LastName {get;set;} 
		public String MobilePhone {get;set;} 
		public String Identificacion_x {get;set;} 
		public String IdCliente_x {get;set;} 
		public String Empresa_x {get;set;} 
		public String Tipo_envio_documentacion_x {get;set;} 
		public String tipo_de_identificacion_x {get;set;} 
		public String Cuentas_con_saldo_x {get;set;} 
		public String Cuentas_al_dia_x {get;set;} 
		public String Sexo_x {get;set;} 
		public String Estado_civil_x {get;set;} 
		public String Ocupacion_x {get;set;} 
		public String c_pai {get;set;} 
		public String BillingBar {get;set;} 
		public String ShippingBar {get;set;}  
		
        public Cliente(Account a){
            Identificacion  =   a.Identificacion__c;
            IdCliente       =   a.IdCliente__c;
            AccountNumber   =   a.AccountNumber;
            AccountSource   =   a.AccountSource;
            BillingState    =   a.BillingState;
            BillingCity     =   a.BillingCity;
            BillingCountry  =   a.BillingCountry;
            BillingLatitude =   a.BillingLatitude;
            BillingLongitude= 	a.BillingLongitude;
            BillingStreet	=	a.BillingStreet;
			Industry		=	a.Industry;
			OwnerId			=	0;//a.OwnerId;
			Ownership		=	0;//a.Ownership;
			Phone			=	a.Phone;
			Name			=	a.FirstName+' '+a.MiddleName+' '+a.LastName;//a.Name;
			Rating			=	a.Rating;
			RecordTypeId	=	a.RecordTypeId;
			ShippingState	=	a.ShippingState;
			ShippingCity	=	a.ShippingCity;
			ShippingCountry	=	a.ShippingCountry;
			ShippingLatitude=	a.ShippingLatitude;
			ShippingLongitude=	a.ShippingLongitude;
			ShippingStreet	=	a.ShippingStreet;
			Type			=	a.Type;
			YearStarted		=	a.AnioInicio__c;
			Birthdate		=	Util.convertDatetoString(a.PersonBirthdate); //SE DEBE FORMATEAR LA FECHA a  MM-DD-YYY
			Department		=	a.PersonDepartment;
			DoNotCallboolean=	String.Valueof(a.PersonDoNotCall);
			Email			=	a.PersonEmail;
			FirstName		=	a.FirstName;
			MiddleName		=	a.MiddleName;
			HomePhone		=	a.PersonHomePhone;
			LastName		=	a.LastName;
			MobilePhone		=	a.PersonMobilePhone;
            Identificacion_x  =   a.Identificacion__c;
            IdCliente_x       =   a.IdCliente__c;			
			Empresa_x		=	a.Empresa__c;
			Tipo_envio_documentacion_x	=	a.TipodeEnvioDocumentacion__c;
			tipo_de_identificacion_x	=	a.TipodeIdentificacion__c;
			Cuentas_con_saldo_x		=	String.ValueOf(a.CuentasconSaldo__c);
			Cuentas_al_dia_x			=	String.ValueOf(a.CuentasalDia__c);
			Sexo_x					=	a.Sexo__c;
			Estado_civil_x			=	a.Estado_civil__C;
			Ocupacion_x				=	a.Ocupacion__C;	
			c_pai				= '';
			BillingBar			= '';
			ShippingBar			= '';
        }
    }
    
    public class WSResponse{
        public boolean success {get; set;}
        public string message {get; set;}
		public string messageLog {get; set;}
    }    

    
    public static WSResponse parseResponse(String json) {
       return (WSResponse) System.JSON.deserialize(json, WSResponse.class);
    }
}