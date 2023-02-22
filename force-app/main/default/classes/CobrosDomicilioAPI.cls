/*
    Creacion y actualizacion de Registros de Cobros a Domicilio
    Autor: Luis Espinoza
    11/nov/2019
*/
@RestResource(urlMapping='/CobrosDomicilioAPI/*')
global with sharing class CobrosDomicilioAPI {
    
    //https://  /services/apexrest/CobrosDomicilioAPI
    @HttpPost
    //global static void upsertCobrosDomicilio(){
    global static String upsertCobrosDomicilio(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        CobrosDomicilioUpsert CobrosDomicilioResult = (CobrosDomicilioUpsert) System.JSON.deserialize(body, CobrosDomicilioUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(CobrosDomicilioResult.CobrosDomicilioList==null || CobrosDomicilioResult.CobrosDomicilioList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<CobrosDomicilio>CobrosDomicilioArray=CobrosDomicilioResult.CobrosDomicilioList;
                List<Cobro_a_domicilio__c>CobrosDomicilioPorInsertar=new List<Cobro_a_domicilio__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdCobrosDomicilioField = Cobro_a_domicilio__c.Fields.IdVisitacobro__c;
                //Este mapa es para identificar el registro de CobroDomicilio en los resultados
                Map<String , CobrosDomicilio>mapCobrosDomicilio=new Map<String , CobrosDomicilio>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorCobrosDomicilio=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IdCliente, IdCarteras que vengan en los elementos
				List<String>ClientesKeySet=new List<String>();
				List<String>CarterasKeySet=new List<String>();
				
				//Llenamos los depositos con cada elemento de CobroDomicilio
				for(CobrosDomicilio r: CobrosDomicilioArray){
					If(r.IdCliente!=null){ClientesKeySet.add(r.IdCliente);}
					If(r.IdCartera!=null){CarterasKeySet.add(r.IdCartera);}
				}
				//Preparamos un mapa de los registros de Cliente relacionados a las CobrosDomicilio
				Map<String , Account>MapClientes=new Map<String, Account>();
				For(Account a : [Select ID , Name, IdCliente__c from Account Where IdCliente__c IN : ClientesKeySet LIMIT 5000]){
					MapClientes.put(a.IdCliente__c , a);
				}
				
				//Preparamos un mapa de los registros de Carteras relacionados a las CobrosDomicilio
				Map<String , Cartera__c>MapCarteras=new Map<String, Cartera__c>();
				For(Cartera__c a : [Select ID , Name, IdCartera__c from Cartera__c Where IdCartera__c IN : CarterasKeySet LIMIT 5000]){
					MapCarteras.put(a.IdCartera__c , a);
				}
                for(CobrosDomicilio r: CobrosDomicilioArray){
                    System.debug('CobroDomicilio : ' + r);
					//validacion de valores requeridos
					If(r.IdCliente!=null && r.IdCliente!='' && r.IdVisitacobro!=null && r.IdVisitacobro!='' && r.IdCartera!=null && r.IdCartera!='' ){
							//validar que el IdCartera exista en la Base
							If(MapClientes.containsKey(r.IdCliente)){
								Cobro_a_domicilio__c c =  new Cobro_a_domicilio__c();
								c.IdVisitacobro__c		= r.IdVisitacobro;
								c.Dia__c				= r.Dia;
								c.Monto_a_pagar__c		= r.MontoPagar;
								c.Jornada__c			= r.Jornada;
								c.Status__c				= r.Estado;
								c.Comentarios_del_cliente__c	= r.ComentariosCliente;
								c.IdCliente__c			= r.IdCliente;
								If(MapClientes.containsKey(r.IdCliente)){
									c.Numero_cliente__c 	= MapClientes.get(r.IdCliente).ID;
								}
								c.IdCartera__c			= r.IdCartera;
								If(MapCarteras.containsKey(r.IdCartera)){
									c.Numero_cartera__c 	= MapCarteras.get(r.IdCartera).ID;
								}
								c.APIUpsert__c 			= 	true;								
								CobrosDomicilioPorInsertar.add(c);
								mapCobrosDomicilio.put('c('+contadorCobrosDomicilio+')' ,r);
								contadorCobrosDomicilio++;
							}else{
								//Numero de Cliente NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdVisitacobro : ('+r.IdVisitacobro+'). El numero de Cliente ('+r.IdCartera+') no existe en la Base de datos.';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CobrosDomicilioAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdVisitacobro : ('+r.IdVisitacobro+'). ';
						If(r.IdVisitacobro==null || r.IdVisitacobro==''){msg+='IdVisitacobro, ';}
						If(r.IdCliente==null || r.IdCliente==''){msg+='IdCliente, ';}
						If(r.IdCartera==null || r.IdCartera==''){msg+='IdCartera, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CobrosDomicilioAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('CobrosDomicilio a Insertar o Actualizar ' + CobrosDomicilioPorInsertar);

                if(!CobrosDomicilioPorInsertar.isEmpty()){
                    Database.UpsertResult[] CobrosDomicilioPorInsertaResult = database.upsert(CobrosDomicilioPorInsertar,IdCobrosDomicilioField ,false);
                    if(!CobrosDomicilioPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + CobrosDomicilioPorInsertaResult.size());
                        for(Integer i=0;i<CobrosDomicilioPorInsertaResult.size();i++){
                            Database.UpsertResult sr = CobrosDomicilioPorInsertaResult[i];
                            CobrosDomicilio f=mapCobrosDomicilio.get('c('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                f.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdVisitacobro : ('+f.IdVisitacobro+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                f.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='CobrosDomicilioAPI');
                                logsInsert.add(logError);
                            }
                        }
                    }               
                }
                response.message = 'Request successfully processed';
                if(contadorErrores > 0){
                    response.success = false;
                    response.message = 'Request processed with '+contadorErrores+' errors';
                }
                system.debug(JSON.serialize(response));
                response.statusCode = Util.statusCode200;
                RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));                 
              
            }Catch(Exception ex){
                response.message = 'Error interno: ' + ex.getMessage() + ' linea: ' + ex.getLineNumber();
                response.success = false;
				response.statusCode = Util.statusCode500;
                RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));
                RestContext.response.statusCode = Util.statusCode500;
            }
        }
        CobrosDomicilioResult.result=response;
		logRequest.ClassName__c='CobrosDomicilioAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+CobrosDomicilioResult.CobrosDomicilioList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(CobrosDomicilioResult);
    }
    
    global class CobrosDomicilioUpsert{
        global list<CobrosDomicilio>CobrosDomicilioList{get;set;}     
        global Response result{get; set;}
    }
    
    global class Response{
        global boolean success {get; set;}
        global String message {get; set;}
        global integer statusCode {get; set;}
        
        global Response(){
            success=true;
            message=null;
        }
    }
    global class CobrosDomicilio{
		global String IdVisitacobro{get;set;}
		global Date Dia{get;set;}
		global Double MontoPagar{get;set;}		
        global String Jornada{get;set;}
		global String Estado{get;set;}//Abierto , Cerrado , Re-servicio
		global String ComentariosCliente{get;set;}		
		global String IdCartera{get;set;}		
		global String IdCliente{get;set;}	
        global Response result{get;set;}
    }
        
    /**
        {
            "CobrosDomicilioList":[
                {
                "IdVisitacobro":"JAJA001JA101255963JA001180689004T20191111",
				"Dia": "2019-11-11",
                "MontoPagar": 250.00,
				"Jornada": "",				
				"ComentariosCliente": "El cliente informa que no realizara ningun pago adicional",
                "IdCartera": "JAJA003TJ102895745",
				"IdCliente": "JA001180689004T"           
                },
                {
                "IdVisitacobro":"JAJA001JA101255963JA001180689004T20190805",
				"Dia": "2019-08-05",
                "MontoPagar": 189.00,
				"Jornada": "",				
				"ComentariosCliente": "Cliente no encontrado en su casa",
                "IdCartera": "JAJA003TJ102895745",
				"IdCliente": "JA001180689004T"           
                }							
            ]
        }	
    **/     
    
}