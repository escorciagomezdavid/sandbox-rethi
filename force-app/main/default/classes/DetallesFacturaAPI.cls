/*
    Creacion y actualizacion de Registros de DetallesFactura
    Autor: Luis Espinoza
    17/oct/2019
*/
@RestResource(urlMapping='/DetallesFacturaAPI/*')
global with sharing class DetallesFacturaAPI {
    
    //https://  /services/apexrest/DetallesFacturaAPI
    @HttpPost
    //global static void upsertDetallesFactura(){
    global static String upsertDetallesFactura(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        DetallesFacturaUpsert DetallesFacturaResult = (DetallesFacturaUpsert) System.JSON.deserialize(body, DetallesFacturaUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(DetallesFacturaResult.DetallesFacturaList==null || DetallesFacturaResult.DetallesFacturaList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<DetallesFactura>DetallesFacturaArray=DetallesFacturaResult.DetallesFacturaList;
                List<Detalle_factura__c>DetallesFacturaPorInsertar=new List<Detalle_factura__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdDetalleFacturaField = Detalle_factura__c.Fields.IdDetalle__c;
                //Este mapa es para identificar el registro de Factura en los resultados
                Map<String , DetallesFactura>mapDetallesFactura=new Map<String , DetallesFactura>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorDetallesFactura=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IDFactura, IDProductos que vengan en los elementos
				List<String>FacturasKeySet=new List<String>();
				List<String>ProductosKeySet=new List<String>();
				
				//Llenamos los depositos con cada elemento de Detalle Factura
				for(DetallesFactura r: DetallesFacturaArray){
					If(r.IdFactura!=null){FacturasKeySet.add(r.IdFactura);}
					If(r.IdProducto!=null){ProductosKeySet.add(r.IdProducto);}
				}
				//Preparamos un mapa de los registros de Factura relacionados a las DetallesFactura
				Map<String , Factura__c>MapFacturas=new Map<String, Factura__c>();
				For(Factura__c a : [Select ID , Name, IdFactura__c from Factura__c Where IdFactura__c IN : FacturasKeySet LIMIT 5000]){
					MapFacturas.put(a.IdFactura__c , a);
				}				
				
				//Preparamos un mapa de los registros de Productos relacionados a las DetallesFactura
				Map<String , Product2>MapProductos=new Map<String, Product2>();
				For(Product2 a : [Select ID , Name, IdProducto__c from Product2 Where IdProducto__c IN : ProductosKeySet LIMIT 5000]){
					MapProductos.put(a.IdProducto__c , a);
				}				
                for(DetallesFactura r: DetallesFacturaArray){
                    System.debug('Detalle Factura : ' + r);
					//validacion de valores requeridos
					If(r.IdFactura!=null && r.IdFactura!='' && r.IdDetalle!=null && r.IdDetalle!='' && r.CodigoDetalleFactura!=null && r.CodigoDetalleFactura!='' 
						&& r.IdProducto!=null && r.IdProducto!='' ){
							//validar que el IdFactura exista en la Base
							If(MapFacturas.containsKey(r.IdFactura)){
								Detalle_factura__c d =  new Detalle_factura__c();
								d.Name 		= r.CodigoDetalleFactura;
								d.IdDetalle__c	= r.IdDetalle;
								d.IdFactura__c			= r.IdFactura;
								d.Numero_factura__c 	= MapFacturas.get(r.IdFactura).ID;
								d.Cantidad__c			= r.Cantidad;
								d.IdProducto__c			= r.IdProducto;
								If(MapProductos.containsKey(r.IdProducto)){
									d.Numero_producto__c 	= MapProductos.get(r.IdProducto).ID;
								}
																
								DetallesFacturaPorInsertar.add(d);
								mapDetallesFactura.put('f('+contadorDetallesFactura+')' ,r);
								contadorDetallesFactura++;
							}else{
								//Numero de Factura NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdDetalleFactura : ('+r.IdDetalle+'). El numero de Factura ('+r.IdFactura+') no existe en la Base de datos.';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='DetallesFacturaAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdDetalle : ('+r.IdDetalle+'). ';
						If(r.IdDetalle==null || r.IdDetalle==''){msg+='IdDetalle, ';}
						If(r.IdFactura==null || r.IdFactura==''){msg+='IdFactura, ';}
						If(r.CodigoDetalleFactura==null || r.CodigoDetalleFactura==''){msg+='CodigoDetalleFactura, ';}
						If(r.IdProducto==null || r.IdProducto==''){msg+='IdProducto, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='DetallesFacturaAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('DetallesFactura a Insertar o Actualizar ' + DetallesFacturaPorInsertar);

                if(!DetallesFacturaPorInsertar.isEmpty()){
                    Database.UpsertResult[] DetallesFacturaPorInsertaResult = database.upsert(DetallesFacturaPorInsertar,IdDetalleFacturaField ,false);
                    if(!DetallesFacturaPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + DetallesFacturaPorInsertaResult.size());
                        for(Integer i=0;i<DetallesFacturaPorInsertaResult.size();i++){
                            Database.UpsertResult sr = DetallesFacturaPorInsertaResult[i];
                            DetallesFactura f=mapDetallesFactura.get('f('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                f.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdDetalle : ('+f.IdDetalle+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                f.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='DetallesFacturaAPI');
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
        DetallesFacturaResult.result=response;
		logRequest.ClassName__c='DetallesFacturaAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+DetallesFacturaResult.DetallesFacturaList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(DetallesFacturaResult);
    }
    
    global class DetallesFacturaUpsert{
        global list<DetallesFactura>DetallesFacturaList{get;set;}     
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
    global class DetallesFactura{
		global String CodigoDetalleFactura {get;set;}
        global String IdDetalle{get;set;}
		global String IdFactura{get;set;}
		global Double Cantidad{get;set;}
		global String IdProducto{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "DetallesFacturaList":[
                {
                "CodigoDetalleFactura":"0124741",
				"IdDetalle": "JAJA0012019F0020124741",
                "IdFactura": "JAJA0012019F002",
				"Cantidad": 25,				
				"IdProducto": "JAP004"			
                },
                {
                "CodigoDetalleFactura":"0124748",
				"IdDetalle": "JAJA0012019F0020124748",
                "IdFactura": "JAJA0012019F002",
				"Cantidad": 36,				
				"IdProducto": "JAP001"			
                },
                {
                "CodigoDetalleFactura":"0124791",
				"IdDetalle": "JAJA0012019F0020124791",
                "IdFactura": "JAJA0012019F002",
				"Cantidad": 36,				
				"IdProducto": "JAP002"			
                },
                {
                "CodigoDetalleFactura":"0124754",
				"IdDetalle": "JAJA0012019F0020124754",
                "IdFactura": "JAJA0012019F002",
				"Cantidad": 88,				
				"IdProducto": "JAP003"			
                }				
            ]
        }
    **/     
    
}