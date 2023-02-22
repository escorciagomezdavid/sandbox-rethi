/**
    Actualizacion de Registros de Cartera
    Autor: Luis Espinoza
    10/FEB/2020
**/
public class MJModificarCarteraAPI {
    
    public static integer contadorCreaciones;	
   	public static integer contadorActualizaciones;
    public static Map<Id,String> registroErroresCreacion;
    public static Map<Id,String> registroErroresActualizacion;    
    
    public static void updateSEUSCartera(set<Id> CarteraIdSet){
		System.debug('CARTERA: Ingresa al metodo MJModificarCarteraAPI');
        String errores = '';
		//se prepara la solicitud al ws
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LABEL.SEUSWSActualizarCartera);
        req.setMethod('POST');
        req.setTimeout(120000);
        
		If(registroErroresActualizacion == null){
        	registroErroresActualizacion = new Map<Id,String>(); 
		}
		//objeto log para registrar los errores
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeConsumo , ClassName__c='MJModificarCarteraAPI', success__c=false);
		
        //Lista para manejo de errores y reeenvio
        Set<Id> CarterasConError = new Set<ID>();
        If(contadorActualizaciones == null){
            contadorActualizaciones = 0;
		}
        contadorActualizaciones ++;
        
        //se Instancia la clase para Obtener el Token
        MJAuthenticationAPI.Authentication auth = MJAuthenticationAPI.getAccessToken(LABEL.SEUSWSUser, LABEL.SEUSWSPassword, LABEL.SEUSWSToken);
                
		req.setHeader('Authorization','Bearer '+auth.token);
		req.setHeader('Content-Type', 'application/json');
				
		//Se consultan los registros de Cartera que se mandar a actualizar
		list<Cartera__c> CarteraList = [Select IdCartera__c, Tipo_de_cuenta__c, Name, IdAgencia__c, IdCliente__c, Tipo_credito__c, Fecha_de_emision__c, Estado_de_la_cuenta__c, Estado_del_Envio_de_Extracto__c,
		EstadodelEnvioCertificadoalDia__c, Estado_del_envio_Declaracion__c, Estado_del_Envio_Paz_y_Salvo__c, URL_documento__c, Fecha_ultimo_pago__c, Monto_de_credito__c, Monto_disponible__c, Valor_cuota__c,
		Saldo_pendiente__c, Saldo_vencido__c, Total_intereses__c, Total_seguro__c, Cuotas_vencidas__c, Dia_de_corte__c, Tramo__c, Fecha_vencimiento__c, Total_dias_vencidos__c, ultimo_cambio_vencimiento__c
		From Cartera__c Where Id IN: CarteraIdSet];
            
		if(CarteraList.size()>0){
			String body = null;
			for(Cartera__c c: CarteraList)
			{
				
				try{
					Cartera model = new Cartera(c);
					//body = JSON.serialize(model);
					body = JSON.serialize(model);
					body = body.replace('_x' , '__c');
					system.debug('CARTERA: El Body es:' +body);
					req.setBody(body);
					HttpResponse res = http.send(req);
					system.debug('CARTERA: La Respuesta es: '+res.getBody());
					c.SEUSWSUpdateErrorMessage__c='OK';
					WSResponse response = parseResponse(res.getBody());
					system.debug(response);
					logRequest.success__c=response.success;
					String mensaje = (response.messageLog!=null)?response.messageLog:response.message;
					logRequest.message__c='CARTERA: '+c.IdCartera__c+': '+mensaje;
					c.SEUSWSSuccess__c = response.success!=true?false:true;
					
					if(response.success==false)
					{
						CarterasConError.add(c.id);
						If(registroErroresActualizacion.containsKey(c.id)){
							registroErroresActualizacion.put(c.id, registroErroresActualizacion.get(c.id) +'\n' + contadorActualizaciones + '. MJModificarCarteraAPI: '+response.message);
						}else{
							registroErroresActualizacion.put(c.id,contadorActualizaciones + '. MJModificarCarteraAPI: '+response.message);
						}
						//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
						If(contadorActualizaciones == 3){
							c.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(c.id);
						}
					}
				}catch(Exception ex){
					System.debug('CARTERA: Causa: '+ex.getCause() + ' Mensaje: '+ ex.getMessage());                    	
					CarterasConError.add(c.id);
					If(registroErroresActualizacion.containsKey(c.id)){
						registroErroresActualizacion.put(c.id, registroErroresActualizacion.get(c.id) +'\n' + contadorActualizaciones + '. MJModificarCarteraAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}else{
						registroErroresActualizacion.put(c.id,contadorActualizaciones + '. MJModificarCarteraAPI InternalError: Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage());
					}
					
					//Si llega al ultimo de los 3 intentos, registra los errores para cada intento.
					If(contadorActualizaciones == 3){
						c.SEUSWSUpdateErrorMessage__c = registroErroresActualizacion.get(c.id);
						c.SEUSWSSuccess__c=false;
					}
					errores =+ 'CARTERA: Error actualizando Cartera  ' + c.IdCartera__c + ' ---Linea: ' + ex.getLineNumber() + ' causa: ' + ex.getCause() + ' Error Exception: '+ex.getMessage() + '\n';
				}				
			}			
			//realizar 3 intentos para actualizar registros
			If(CarterasConError.size() != 0 && contadorActualizaciones <= 2){
				System.debug('CARTERA: Re-intento '+contadorActualizaciones);
				//esperar x milisegundos para siguiente llamada:
				Integer tiempoEspera = Integer.ValueOf(LABEL.SEUSWSReCallTime);
				Util.wait(tiempoEspera);						
				updateSEUSCartera(CarterasConError);
			}
			
			If(errores != '' && errores != null && contadorActualizaciones == 3){
				MJEmailManager.sendError(errores);
				logRequest.message__c=errores;
			}
			
			TriggerHandler.ByPass(LABEL.TriggerHandlerCartera);
			update CarteraList;
			TriggerHandler.ClearByPass(LABEL.TriggerHandlerCartera);
				  
			Insert logRequest;
		}
		
		//si el token necesita crearse/actualizarse
		If(auth.needsUpdate == true){
			auth.upsertToken();
		}			
    }

    public class Cartera{
		public String IdCartera_x;
		public String Tipo_cuenta_x;
		public String numero_cuenta;
		public String Agencia_x;
		public String IdAgencia_x;
		public String AccountId_x;
		public String IdCliente_x;
		public String Tipo_credito_x;
		public String Fecha_de_emision_x;
		public String Estado_de_la_cuenta_x;
		public String Estado_envio_extracto_x;
		public String Estado_envio_certificado_al_dia_x;
		public String Estado_envio_Declaracion_x;
		public String Estado_envio_paz_salvo_x;
		public String Url_documento_x;
		public String Fecha_ultimo_pago_x;
		public String Monto_de_credito_x;
		public String Monto_disponible_x;
		public String Valor_cuota_x;
		public String Saldo_pendiente_x;
		public String Saldo_vencido_x;
		public String Gastos_de_cobro_x;
		public String Total_intereses_x;
		public String Total_seguro_x;
		public String Cuotas_vencidas_x;
		public String Dia_de_corte_x;
		public String Tramo_x;
		public String Fecha_vencimiento_x;
		public String Total_dias_vencidos_x;
		public String ultimo_cambio_vencimiento_x;
		
        public Cartera(Cartera__c c){
			IdCartera_x		=	c.IdCartera__c;
			Tipo_cuenta_x	=	c.Tipo_de_cuenta__c;
			numero_cuenta	=	c.Name;
			//Agencia_x		=	c.Agencia__c; //Lookup
			IdAgencia_x		=	c.IdAgencia__c;
			//AccountId_x	=	c.AccountId__c; //Lookup
			IdCliente_x		=	c.IdCliente__c;
			Tipo_credito_x	=	c.Tipo_credito__c;
			Fecha_de_emision_x	=	Util.convertDatetoString(c.Fecha_de_emision__c);
			Estado_de_la_cuenta_x	=	c.Estado_de_la_cuenta__c;
			Estado_envio_extracto_x	=	c.Estado_del_Envio_de_Extracto__c;
			Estado_envio_certificado_al_dia_x	=	c.EstadodelEnvioCertificadoalDia__c;
			Estado_envio_Declaracion_x	=	c.Estado_del_envio_Declaracion__c;
			Estado_envio_paz_salvo_x	=	c.Estado_del_Envio_Paz_y_Salvo__c;
			Url_documento_x	=	c.URL_documento__c;
			Fecha_ultimo_pago_x	=	Util.convertDatetoString(c.Fecha_ultimo_pago__c);
			Monto_de_credito_x	=	String.ValueOf(c.Monto_de_credito__c);
			Monto_disponible_x	=	String.ValueOf(c.Monto_disponible__c);
			Valor_cuota_x		=	String.ValueOf(c.Valor_cuota__c);
			Saldo_pendiente_x	=	String.ValueOf(c.Saldo_pendiente__c);
			Saldo_vencido_x		=	String.ValueOf(c.Saldo_vencido__c);
			Total_intereses_x	=	String.ValueOf(c.Total_intereses__c);
			Total_seguro_x		=	String.ValueOf(c.Total_seguro__c);
			Cuotas_vencidas_x	=	String.ValueOf(c.Cuotas_vencidas__c);
			Dia_de_corte_x		=	String.ValueOf(c.Dia_de_corte__c);
			Tramo_x				=	c.Tramo__c;
			Fecha_vencimiento_x	=	Util.convertDatetoString(c.Fecha_vencimiento__c);
			Total_dias_vencidos_x	=	String.ValueOf(c.Total_dias_vencidos__c);
			ultimo_cambio_vencimiento_x	=	Util.convertDatetoString(c.ultimo_cambio_vencimiento__c);
			//Gastos_de_cobro__c //no hay campo			
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