/**
    Creacion de Registro de Cobro a Domicilio
    Autor: Luis Espinoza
    10/FEB/2020
**/
public class MJCrearCobroDomicilioAPI {
    
    public static integer contadorCreaciones;
    public static Map<Id,String> registroErroresCreacion;    
    
    public static void createSEUSCobroDomicilio(set<Id> CobrosDomicilioIdSet){
		System.debug('COBRO A DOMICILIO: Ingresa al metodo MJCrearCobroDomicilioAPI');
        String errores = '';
		//se prepara la solicitud al ws
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LABEL.SEUSWSCrearCobroDomicilio);
        req.setMethod('POST');
        req.setTimeout(120000);
        
		If(registroErroresCreacion == null){
        	registroErroresCreacion = new Map<Id,String>(); 
		}
		//objeto log para registrar los errores
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeConsumo , ClassName__c='MJCrearCobroDomicilioAPI', success__c=false);
		
        //Lista para manejo de errores y reeenvio
        Set<Id> CobrosDomicilioConError = new Set<ID>();
        If(contadorCreaciones == null){
            contadorCreaciones = 0;
		}
        contadorCreaciones ++;
        
        //se Instancia la clase para Obtener el Token
        MJAuthenticationAPI.Authentication auth = MJAuthenticationAPI.getAccessToken(LABEL.SEUSWSUser, LABEL.SEUSWSPassword, LABEL.SEUSWSToken);
                
		req.setHeader('Authorization','Bearer '+auth.token);
		req.setHeader('Content-Type', 'application/json');
				
		//Se consultan los registros de CobrosDomicilio que se mandar a actualizar
		list<Cobro_a_domicilio__c> CobrosDomicilioList = [Select Name , Empresa__c, IdVisitacobro__c, Numero_caso__c, Numero_caso__r.Pais__c, Numero_caso__r.Provincia__c,
		Numero_caso__r.Ciudad__c, Numero_caso__r.Calle__c, Dia__c, Monto_a_pagar__c, Jornada__c, Comentarios_del_cliente__c,Numero_cartera__r.Name,Numero_cartera__r.IdCartera__c,
		Numero_cliente__r.Identificacion__c, Numero_cliente__r.IdCliente__c, Numero_caso__r.CaseNumber
		From Cobro_a_domicilio__c Where Id IN: CobrosDomicilioIdSet];
            
		if(CobrosDomicilioList.size()>0){
			String body = null;
			for(Cobro_a_domicilio__c c: CobrosDomicilioList)
			{
				
				try{
					CobroDomicilio model = new CobroDomicilio(c);
					body = JSON.serialize(model);
					body = body.replace('_x' , '__c');
					system.debug('COBRO A DOMICILIO: El Body es:' +body);
					req.setBody(body);
					HttpResponse res = http.send(req);
					system.debug('COBRO A DOMICILIO: La Respuesta es: '+res.getBody());
					c.SEUSWSUpdateErrorMessage__c='OK';
					WSResponse response = parseResponse(res.getBody());
					system.debug(response);
					logRequest.success__c=response.success;
					String mensaje = (response.messageLog!=null)?response.messageLog:response.message;
					logRequest.message__c='COBRO A DOMICILIO: '+c.IdVisitaCobro__c+': '+mensaje;
					c.SEUSWSSuccess__c = response.success!=true?false:true;
					
					if(response.success==false)
					{
						CobrosDomicilioConError.add(c.id);
						If(registroErroresCreacion.containsKey(c.id)){
							registroErroresCreacion.put(c.id, registroErroresCreacion.get(c.id) +'\n' + contadorCreaciones + '. MJCrearCobroDomicilioAPI: '+response.message);
						}else{
							registroErroresCreacion.put(c.id,contadorCreaciones + '. MJCrearCobroDomicilioAPI: '+response.message);
						}
						//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
						If(contadorCreaciones == 3){
							c.SEUSWSUpdateErrorMessage__c = registroErroresCreacion.get(c.id);
						}
					}
				}catch(Exception ex){
					System.debug('COBRO A DOMICILIO: Causa: '+ex.getCause() + ' Mensaje: '+ ex.getMessage());                    	
					CobrosDomicilioConError.add(c.id);
					If(registroErroresCreacion.containsKey(c.id)){
						registroErroresCreacion.put(c.id, registroErroresCreacion.get(c.id) +'\n' + contadorCreaciones + '. MJCrearCobroDomicilioAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}else{
						registroErroresCreacion.put(c.id,contadorCreaciones + '. MJCrearCobroDomicilioAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}
					
					//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
					If(contadorCreaciones == 3){
						c.SEUSWSUpdateErrorMessage__c = registroErroresCreacion.get(c.id);
						c.SEUSWSSuccess__c=false;
					}
					errores =+ 'COBRO A DOMICILIO: Error creando CobrosDomicilio  ' + c.IdVisitacobro__c + ' ---Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage() + '\n';
				}				
			}			
			//realizar 3 intentos para actualizar registros
			If(CobrosDomicilioConError.size() != 0 && contadorCreaciones <= 2){
				System.debug('COBRO A DOMICILIO: Re-intento '+contadorCreaciones);
				//esperar x milisegundos para siguiente llamada:
				Integer tiempoEspera = Integer.ValueOf(LABEL.SEUSWSReCallTime);
				Util.wait(tiempoEspera);					
				createSEUSCobroDomicilio(CobrosDomicilioConError);
			}
			
			If(errores != '' && errores != null && contadorCreaciones == 3){
				MJEmailManager.sendError(errores);
				logRequest.message__c=errores;
			}
			
			TriggerHandler.ByPass(LABEL.TriggerHandlerCobrosDomicilio);
			update CobrosDomicilioList;
			TriggerHandler.ClearByPass(LABEL.TriggerHandlerCobrosDomicilio);
				  
			Insert logRequest;
		}
		
		//si el token necesita crearse/actualizarse
		If(auth.needsUpdate == true){
			auth.upsertToken();
		}			
    }

    public class CobroDomicilio{
		public String Name;
		public String RecorTypeId;
		public String IdVisitaCobro_x;
		public String Direccion_visita_x;
		public String DIa_x;
		public Integer Monto_a_pagar_x;
		public String Jornada_x;
		public String Comentarios_cliente_x;
		public Integer Numero_cartera_x;
		public String IdCartera_x;
		public String Numero_cliente_x;
		public String IdCliente_x;
		public Integer Numero_caso_x;
		
        public CobroDomicilio(Cobro_a_domicilio__c c){
			Name					=	c.Name;
			RecorTypeId				=	'N/A';
			IdVisitaCobro_x			=	c.IdVisitacobro__c;//Empresa+agencia+tipocuenta+cuenta+cliente+fecha
			//obtener la direccion
			if(c.Numero_caso__c!=null){
				Direccion_visita_x	=	c.Numero_caso__r.Pais__c+' '+c.Numero_caso__r.Provincia__c+' '+c.Numero_caso__r.Ciudad__c+' '+c.Numero_caso__r.Calle__c;
			}
			DIa_x					=	Util.convertDatetoString(c.Dia__c);
			Monto_a_pagar_x			=	Integer.ValueOf(c.Monto_a_pagar__c);
			Jornada_x				=	c.Jornada__c;
			Comentarios_cliente_x	=	(c.Comentarios_del_cliente__c!=null)?c.Comentarios_del_cliente__c:' ';
			Numero_cartera_x		=	Integer.ValueOf(c.Numero_cartera__r.Name);
			IdCartera_x				=	c.Numero_cartera__r.IdCartera__c;
			Numero_cliente_x		=	c.Numero_cliente__r.Identificacion__c;
			IdCliente_x				=	c.Numero_cliente__r.IdCliente__c;
			Numero_caso_x			=	Integer.ValueOf(c.Numero_caso__r.CaseNumber);
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