/*
    Creacion y actualizacion de Registros de Agencias
    Autor: Luis Espinoza
    02/oct/2019
*/
@RestResource(urlMapping='/agenciasapi/*')
global with sharing class AgenciasAPI {
    
    //https://  /services/apexrest/AgenciasAPI
    @HttpPost
    //global static void upsertAgencias(){
    global static String upsertAgencias(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        AgenciasUpsert agenciasResult = (AgenciasUpsert) System.JSON.deserialize(body, AgenciasUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(agenciasResult.agenciasList==null || agenciasResult.agenciasList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
              RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));
              RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Agencias>agenciasArray=agenciasResult.agenciasList;
                List<Agencia__c>agenciasPorInsertar=new List<Agencia__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdAgenciaField = Agencia__c.Fields.IdAgencia__c;
                //Este mapa es para identificar el registro de Agencia en los resultados
                Map<String , Agencias>mapAgencias=new Map<String , Agencias>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorAgencias=0;
                Integer contadorErrores=0;
            try{
                for(Agencias r: agenciasArray){
                    System.debug('Agencia ' + r);
					//validacion de valores requeridos
					If(r.NombreAgencia!=null && r.NombreAgencia!='' && r.IdAgencia!=null && r.IdAgencia!='' && r.CodigoAgencia!=null 
						&& r.CodigoAgencia!='' && r.Empresa!=null && r.Empresa!=''){
						Agencia__c a =  new Agencia__c();
						a.Name                  =   r.NombreAgencia;
						a.Nombre_comercial__c   =   r.NombreComercial;
						a.IdAgencia__c          =   r.IdAgencia;
						a.Empresa__c            =   r.Empresa;
						a.Codigo_de_agencia__c  =   r.CodigoAgencia;
						agenciasPorInsertar.add(a);
						mapAgencias.put('a('+contadorAgencias+')' ,r);
						contadorAgencias++;
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IDAgencia : ('+r.IdAgencia+'). ';
						If(r.NombreAgencia==null || r.NombreAgencia==''){msg+='NombreAgencia, ';}
						If(r.Empresa==null || r.Empresa==''){msg+='Empresa, ';}
						If(r.IdAgencia==null || r.IdAgencia==''){msg+='IdAgencia, ';}
						If(r.CodigoAgencia==null || r.CodigoAgencia==''){msg+='CodigoAgencia, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='AgenciasAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Agencias a Insertar o Actualizar ' + agenciasPorInsertar);

                if(!agenciasPorInsertar.isEmpty()){
                    Database.UpsertResult[] agenciasPorInsertaResult = database.upsert(agenciasPorInsertar,IdAgenciaField ,false);
                    if(!agenciasPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + agenciasPorInsertaResult.size());
                        for(Integer i=0;i<agenciasPorInsertaResult.size();i++){
                            Database.UpsertResult sr = agenciasPorInsertaResult[i];
                            Agencias a=mapAgencias.get('a('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                a.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IDAgencia : ('+a.IdAgencia+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                a.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message, ClassName__c='AgenciasAPI' );
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
                RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));                 
              
            }Catch(Exception ex){
                response.message = 'Error interno: ' + ex.getMessage() + ' linea: ' + ex.getLineNumber();
                response.success = false;
				response.statusCode = Util.statusCode500;
                RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));
                RestContext.response.statusCode = Util.statusCode500;
                //Aqui registrar en el objeto Log
            }
        }
        agenciasResult.result=response;  
		logRequest.ClassName__c='AgenciasAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+agenciasResult.agenciasList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(agenciasResult);
    }
    
    global class AgenciasUpsert{
        global list<Agencias>agenciasList{get;set;}     
        global Response result{get; set;}
    }
    
    global class Response{
        global boolean success {get; set;}
        global string message {get; set;}
        global integer statusCode {get; set;}
        
        global Response(){
            success=true;
            message=null;
        }
    }
    global class Agencias{
        global String NombreAgencia {get;set;}        
        global string NombreComercial{get;set;}
        global string IdAgencia{get;set;}
        global string Empresa{get;set;}
        global string CodigoAgencia{get;set;}        
        global Response result{get;set;}
    }
        
    /**
        {
            "agenciasList":[
                {
                "NombreAgencia":"Tienda Barranquilla",
                "NombreComercial":"Muebles Jamar S.A Sucursal Barranquilla-test",
                "IdAgencia": "JA001",
                "Empresa": "JA",
                "CodigoAgencia": "001"
                },
                {
                "NombreAgencia":"Tienda Bogota",
                "NombreComercial":"Muebles Jamar S.A Sucursal Bogota-test2",
                "IdAgencia": "JA002",
                "Empresa": "JAN",
                "CodigoAgencia": "002"
                },
                {
                "NombreAgencia":"Tienda Cali",
                "NombreComercial":"Muebles Jamar S.A Sucursal Cali-test3",
                "IdAgencia": "JA003",
                "Empresa": "JA",
                "CodigoAgencia": "003"
                }                                         
            ]
        }   
    **/     
    
}