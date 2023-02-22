/**
    Creacion de Registro de Compromiso de Pago
    Autor: Luis Espinoza
    11/FEB/2020
**/
public class MJCrearCompromisoPagoAPI {
    
    public static integer contadorCreaciones;
    public static Map<Id,String> registroErroresCreacion;    
    
    public static void createSEUSCompromisoPago(set<Id> CompromisosPagoIdSet){
		System.debug('CASE COMPROMISO PAGO: Ingresa al metodo MJCrearCompromisoPagoAPI');
        String errores = '';
		//se prepara la solicitud al ws
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LABEL.SEUSWSCrearCompromisoPago);
        req.setMethod('POST');
        req.setTimeout(120000);
        
		If(registroErroresCreacion == null){
        	registroErroresCreacion = new Map<Id,String>(); 
		}
		//objeto log para registrar los errores
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeConsumo , ClassName__c='MJCrearCompromisoPagoAPI', success__c=false);
		
        //Lista para manejo de errores y reeenvio
        Set<Id> CompromisosPagoConError = new Set<ID>();
        If(contadorCreaciones == null){
            contadorCreaciones = 0;
		}
        contadorCreaciones ++;
        
        //se Instancia la clase para Obtener el Token
        MJAuthenticationAPI.Authentication auth = MJAuthenticationAPI.getAccessToken(LABEL.SEUSWSUser, LABEL.SEUSWSPassword, LABEL.SEUSWSToken);
                
		req.setHeader('Authorization','Bearer '+auth.token);
		req.setHeader('Content-Type', 'application/json');
				
		//Se consultan los registros de CompromisosPago que se mandar a actualizar
		list<Case> CompromisosPagoList = [Select Description, Id , CaseNumber , Account.Empresa__c, IdCartera__c , Comments , Fecha_de_pago__c, Monto_a_pagar__c, Valor_de_pago__c
		From Case Where Id IN: CompromisosPagoIdSet];
            
		if(CompromisosPagoList.size()>0){
			String body = null;
			for(Case c: CompromisosPagoList)
			{
				
				try{
					CompromisoPago model = new CompromisoPago(c);
					//body = JSON.serialize(model);
					body = JSON.serialize(model);
					body = body.replace('_x' , '__c');
					system.debug('CASE COMPROMISO PAGO: El Body es:' +body);
					req.setBody(body);
					HttpResponse res = http.send(req);
					system.debug('CASE COMPROMISO PAGO: La Respuesta es: '+res.getBody());
					c.SEUSWSUpdateErrorMessage__c='OK';
					WSResponse response = parseResponse(res.getBody());
					system.debug(response);
					logRequest.success__c=response.success;
					String mensaje = (response.messageLog!=null)?response.messageLog:response.message;
					logRequest.message__c='CASE COMPROMISO PAGO: IdCartera '+c.IdCartera__c+' . NumeroCaso: '+c.CaseNumber+': '+mensaje;
					c.SEUSWSSuccess__c = response.success!=true?false:true;
					
					if(response.success==false)
					{
						CompromisosPagoConError.add(c.id);
						If(registroErroresCreacion.containsKey(c.id)){
							registroErroresCreacion.put(c.id, registroErroresCreacion.get(c.id) +'\n' + contadorCreaciones + '. MJCrearCompromisoPagoAPI: '+response.message);
						}else{
							registroErroresCreacion.put(c.id,contadorCreaciones + '. MJCrearCompromisoPagoAPI: '+response.message);
						}
						//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
						If(contadorCreaciones == 3){
							c.SEUSWSUpdateErrorMessage__c = registroErroresCreacion.get(c.id);
						}
					}
				}catch(Exception ex){
					System.debug('CASE COMPROMISO PAGO: Causa: '+ex.getCause() + ' Mensaje: '+ ex.getMessage());                    	
					CompromisosPagoConError.add(c.id);
					If(registroErroresCreacion.containsKey(c.id)){
						registroErroresCreacion.put(c.id, registroErroresCreacion.get(c.id) +'\n' + contadorCreaciones + '. MJCrearCompromisoPagoAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}else{
						registroErroresCreacion.put(c.id,contadorCreaciones + '. MJCrearCompromisoPagoAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}
					
					//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
					If(contadorCreaciones == 3){
						c.SEUSWSUpdateErrorMessage__c = registroErroresCreacion.get(c.id);
						c.SEUSWSSuccess__c=false;
					}
					errores =+ 'CASE COMPROMISO PAGO: Error creando CompromisosPago. Case ' + c.Id + ' ---Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage() + '\n';
				}				
			}			
			//realizar 3 intentos para actualizar registros
			If(CompromisosPagoConError.size() != 0 && contadorCreaciones <= 2){
				System.debug('CASE COMPROMISO PAGO: Re-intento '+contadorCreaciones);
				//esperar x milisegundos para siguiente llamada:
				Integer tiempoEspera = Integer.ValueOf(LABEL.SEUSWSReCallTime);
				Util.wait(tiempoEspera);
				system.debug('Hora : ' + DateTime.now());
				createSEUSCompromisoPago(CompromisosPagoConError);
			}
			
			If(errores != '' && errores != null && contadorCreaciones == 3){
				MJEmailManager.sendError(errores);
				logRequest.message__c=errores;
			}
			
			TriggerHandler.ByPass(LABEL.TriggerHandlerCase);
			update CompromisosPagoList;
			TriggerHandler.ClearByPass(LABEL.TriggerHandlerCase);
				  
			Insert logRequest;
		}
		
		//si el token necesita crearse/actualizarse
		If(auth.needsUpdate == true){
			auth.upsertToken();
		}		
    }

    public class CompromisoPago{
		//public String c_emp;
		//public String api_key;
		public String IdCartera_x;
		public String observacion;
		public String Dia_x;
		public String Monto_a_pagar_x;
		
        public CompromisoPago(Case c){
			//c_emp			=	c.Account.Empresa__c;
			//api_key			=	LABEL.SEUSWSApiKeyCompromisoPago;
			IdCartera_x		=	c.IdCartera__c;
			observacion		=	c.Description==null ? ' ' : c.Description;
			Dia_x			=	Util.convertDatetoString(c.Fecha_de_pago__c); //MM-DD-YYYY
			Monto_a_pagar_x	=	String.valueOf(c.Valor_de_pago__c);
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