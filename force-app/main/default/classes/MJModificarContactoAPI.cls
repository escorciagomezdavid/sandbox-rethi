/**
    Actualizacion de Registros de Contactos
    Autor: Luis Espinoza
    07/FEB/2020
**/
public class MJModificarContactoAPI {
    
    public static integer contadorCreaciones;	
   	public static integer contadorActualizaciones;
    public static Map<Id,String> registroErroresCreacion;
    public static Map<Id,String> registroErroresActualizacion;    
    
    public static void updateSEUSContact(set<Id> contactIdSet){
		System.debug('CONTACTO: Ingresa al metodo MJModificarContactoAPI');
        String errores = '';
		//se prepara la solicitud al ws
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LABEL.SEUSWSActualizarContacto);
        req.setMethod('POST');
        req.setTimeout(120000);
        
		If(registroErroresActualizacion == null){
        	registroErroresActualizacion = new Map<Id,String>(); 
		}
		//objeto log para registrar los errores
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeConsumo , ClassName__c='MJModificarContactoAPI', success__c=false);
		
        //Lista para manejo de errores y reeenvio
        Set<Id> contactosConError = new Set<ID>();
        If(contadorActualizaciones == null){
            contadorActualizaciones = 0;
		}
        contadorActualizaciones ++;
        
        //se Instancia la clase para Obtener el Token
        MJAuthenticationAPI.Authentication auth = MJAuthenticationAPI.getAccessToken(LABEL.SEUSWSUser, LABEL.SEUSWSPassword, LABEL.SEUSWSToken);
                
		req.setHeader('Authorization','Bearer '+auth.token);
		req.setHeader('Content-Type', 'application/json');
				
		//Se consultan los registros de Contacto que se mandar a actualizar
		list<Contact> ContactList = [Select AccountId , Birthdate , Description , DoNotCall , Email , Fax , FirstName , MiddleName, HasOptedOutOfEmail , HasOptedOutOfFax, HomePhone,  
		LastName, MailingCity , MailingCountry , MailingLatitude , MailingLongitude , MailingStreet , LeadSource , MobilePhone , Name , OtherCity ,  OtherCountry , OtherLatitude , OtherLongitude , 
		OtherStreet , OtherPhone , OwnerId , Phone , Title, Tipo_de_miembro__c , Tipo_de_referencia__c , Tipo_de_relacion__c , Tipo_de_identificacion__c , Identificacion__c,Empresa__c,IdContacto__c,Sexo__c,Estado_civil__c,Ocupacion__c
		From Contact Where Id IN: contactIdSet];
            
		if(ContactList.size()>0){
			String body = null;
			for(Contact c: ContactList)
			{
				
				try{
					Contacto model = new Contacto(c);
					//body = JSON.serialize(model);
					body = JSON.serialize(model);
					body = body.replace('_x' , '__c');
					system.debug('CONTACTO: El Body es:' +body);
					req.setBody(body);
					HttpResponse res = http.send(req);
					system.debug('CONTACTO: La Respuesta es: '+res.getBody());
					c.SEUSWSUpdateErrorMessage__c='OK';
					WSResponse response = parseResponse(res.getBody());
					system.debug(response);
					logRequest.success__c=response.success;
					String mensaje = (response.messageLog!=null)?response.messageLog:response.message;
					logRequest.message__c='CONTACTO: '+c.IdContacto__c+': '+mensaje;
					c.SEUSWSSuccess__c = response.success!=true?false:true;
					
					if(response.success==false)
					{
						contactosConError.add(c.id);
						If(registroErroresActualizacion.containsKey(c.id)){
							registroErroresActualizacion.put(c.id, registroErroresActualizacion.get(c.id) +'\n' + contadorActualizaciones + '. MJModificarContactoAPI: '+response.message);
						}else{
							registroErroresActualizacion.put(c.id,contadorActualizaciones + '. MJModificarContactoAPI: '+response.message);
						}
						//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
						If(contadorActualizaciones == 3){
							c.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(c.id);
						}
					}
				}catch(Exception ex){
					System.debug('CONTACTO: Causa: '+ex.getCause() + ' Mensaje: '+ ex.getMessage());                    	
					contactosConError.add(c.id);
					If(registroErroresActualizacion.containsKey(c.id)){
						registroErroresActualizacion.put(c.id, registroErroresActualizacion.get(c.id) +'\n' + contadorActualizaciones + '. MJModificarContactoAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}else{
						registroErroresActualizacion.put(c.id,contadorActualizaciones + '. MJModificarContactoAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}
					
					//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
					If(contadorActualizaciones == 3){
						c.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(c.id);
						c.SEUSWSSuccess__c=false;
					}
					errores =+ 'CONTACTO: Error actualizando Contacto  ' + c.IdContacto__c + ' ---Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage() + '\n';
				}				
			}			
			//realizar 3 intentos para actualizar registros
			If(contactosConError.size() != 0 && contadorActualizaciones <= 2){
				System.debug('CONTACTO: Re-intento '+contadorActualizaciones);
				//esperar x milisegundos para siguiente llamada:
				Integer tiempoEspera = Integer.ValueOf(LABEL.SEUSWSReCallTime);
				Util.wait(tiempoEspera);						
				updateSEUSContact(contactosConError);
			}
			
			If(errores != '' && errores != null && contadorActualizaciones == 3){
				MJEmailManager.sendError(errores);
				logRequest.message__c=errores;
			}
			
			TriggerHandler.ByPass(LABEL.TriggerHandlerContact);
			update ContactList;
			TriggerHandler.ClearByPass(LABEL.TriggerHandlerContact);
				  
			Insert logRequest;
		}  
		
		//si el token necesita crearse/actualizarse
		If(auth.needsUpdate == true){
			auth.upsertToken();
		}		
    }

    public class Contacto{
		public String AccountId;
		public String Birthdate;
		public String Description;
		public Boolean DoNotCall;
		public String Email;
		public String Fax;
		public String FirstName;
		public String MiddleName;
		public Boolean HasOptedOutOfEmail;
		public Boolean HasOptedOutOfFax;
		public String HomePhone;
		public String LastName;
		public String MailingCity;
		public String MailingCountry;
		public Double MailingLatitude;
		public Double MailingLongitude;
		public String MailingStreet;
		public String LeadSource;
		public String MobilePhone;
		public String Name;
		public String OtherCity;
		public String OtherCountry;
		public Double OtherLatitude;
		public Double OtherLongitude;
		public String OtherStreet;
		public String OtherPhone;
		public String OwnerId;
		public String Phone;
		public String Title;
		public String Tipo_de_miembro_x;
		public String Tipo_de_referencia_x;
		public String Tipo_relacion_x;
		public String tipo_de_identificacion_x;
		public String Identificacion_x;
		public String Empresa_x;
		public String IdContacto_x;
		public String Sexo_x;
		public String Estado_civil_x;
		public String Ocupacion_x;
		
        public Contacto(Contact c){
            //AccountId		=	c.AccountId; //lookup
			Birthdate		=	Util.convertDatetoString(c.Birthdate);
			Description		=	c.Description;
			DoNotCall		=	c.DoNotCall;
			Email			=	c.Email;
			Fax				=	c.Fax;
			FirstName		=	c.FirstName;
			MiddleName		=	c.MiddleName;
			HasOptedOutOfEmail	=	c.HasOptedOutOfEmail;
			HasOptedOutOfFax	=	c.HasOptedOutOfFax;
			HomePhone			=	c.HomePhone;
			LastName			=	c.LastName;
			MailingCity			=	c.MailingCity;
			MailingCountry		=	c.MailingCountry;
			MailingLatitude		=	c.MailingLatitude;
			MailingLongitude	=	c.MailingLongitude;
			MailingStreet		=	c.MailingStreet;
			LeadSource			=	c.LeadSource;
			MobilePhone			=	c.MobilePhone;
			Name				=	c.FirstName+' '+c.MiddleName+' '+c.LastName;//c.Name;
			OtherCity			=	c.OtherCity;
			OtherCountry		=	c.OtherCountry;
			OtherLatitude		=	c.OtherLatitude;
			OtherLongitude		=	c.OtherLongitude;
			OtherStreet			=	c.OtherStreet;
			OtherPhone			=	c.OtherPhone;
			OwnerId				=	c.OwnerId;
			Phone				=	c.Phone;
			Title				=	c.Title;
			Tipo_de_miembro_x	=	c.Tipo_de_miembro__c;
			Tipo_de_referencia_x=	c.Tipo_de_referencia__c;
			Tipo_relacion_x		=	c.Tipo_de_relacion__c;
			tipo_de_identificacion_x	=	c.Tipo_de_identificacion__c;
			Identificacion_x	=	c.Identificacion__c;
			Empresa_x			=	c.Empresa__c;
			IdContacto_x		=	c.IdContacto__c;
			Sexo_x				=	c.Sexo__c;
			Estado_civil_x		=	c.Estado_civil__c;
			Ocupacion_x			=	c.Ocupacion__c;
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