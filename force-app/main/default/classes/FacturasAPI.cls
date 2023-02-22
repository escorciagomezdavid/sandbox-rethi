/*
    Creacion y actualizacion de Registros de Facturas
    Autor: Luis Espinoza
    15/oct/2019
*/
@RestResource(urlMapping='/FacturasAPI/*')
global with sharing class FacturasAPI {
    
    //https://  /services/apexrest/FacturasAPI
    @HttpPost
    //global static void upsertFacturas(){
    global static String upsertFacturas(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        FacturasUpsert FacturasResult = (FacturasUpsert) System.JSON.deserialize(body, FacturasUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(FacturasResult.FacturasList==null || FacturasResult.FacturasList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Facturas>FacturasArray=FacturasResult.FacturasList;
                List<Factura__c>FacturasPorInsertar=new List<Factura__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdFacturaField = Factura__c.Fields.IdFactura__c;
                //Este mapa es para identificar el registro de Factura en los resultados
                Map<String , Facturas>mapFacturas=new Map<String , Facturas>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorFacturas=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IdCliente, IdAgencia que vengan en los elementos
				List<String>ClientesKeySet=new List<String>();
				List<String>AgenciasKeySet=new List<String>();
				List<String>CarterasKeySet=new List<String>();
				
				//Llenamos los depositos con cada elemento de Factura
				System.debug('Array Facturas');
                System.debug(FacturasArray);
				for(Facturas r: FacturasArray){
                    System.debug('Factura Individual');
                    System.debug(r);
					If(r.IdCliente!=null){ClientesKeySet.add(r.IdCliente);}
					If(r.IdAgencia!=null){AgenciasKeySet.add(r.IdAgencia);}
					If(r.IdCartera!=null){CarterasKeySet.add(r.IdCartera);}
				}
                System.debug('Clientes en Array ID');
                System.debug(ClientesKeySet);
                System.debug('Agencias en Array ID');
                System.debug(AgenciasKeySet);
                System.debug('Carteras en Array ID');
                System.debug(CarterasKeySet);
				//Preparamos un mapa de los registros de Clientes relacionados a las Facturas
				Map<String , Account>MapCuentas=new Map<String, Account>();
				For(Account a : [Select ID , Name, IdCliente__c from Account Where IdCliente__c IN : ClientesKeySet LIMIT 5000]){
					System.debug('Cuentas Dentro del For');
                    System.debug(a);
                    MapCuentas.put(a.IdCliente__c , a);
				}
                System.debug('Maps Cuentas');
                System.debug(MapCuentas);
				
				//Preparamos un mapa de los registros de Agencia relacionados a las Facturas
				Map<String , Agencia__c>MapAgencias=new Map<String, Agencia__c>();
				For(Agencia__c a : [Select ID , Name, IdAgencia__c from Agencia__c Where IdAgencia__c IN : AgenciasKeySet LIMIT 5000]){
					MapAgencias.put(a.IdAgencia__c , a);
				}
				
				//Preparamos un mapa de los registros de Cartera relacionados a las Facturas
				Map<String , Cartera__c>MapCarteras=new Map<String, Cartera__c>();
				For(Cartera__c c : [Select ID , Name, IdCartera__c from Cartera__c Where IdCartera__c IN : CarterasKeySet LIMIT 5000]){
					MapCarteras.put(c.IdCartera__c , c);
				}
				
                for(Facturas r: FacturasArray){
                    System.debug('Factura : ' + r);
					//validacion de valores requeridos
					If(r.IdFactura!=null && r.IdFactura!='' && r.IdCliente!=null && r.IdCliente!='' && r.NumeroFactura!=null && r.NumeroFactura!='' 
						&& r.IdAgencia!=null && r.IdAgencia!='' ){
                            System.debug('Cuentas');
                          	System.debug(MapCuentas);
							//validar que el IdCliente exista en la Base
							If(MapCuentas.containsKey(r.IdCliente)){
								Factura__c f =  new Factura__c();
								f.Name				= r.NumeroFactura;//not null
								f.IdCartera__c		= r.IdCartera;
								If(MapCarteras.containsKey(r.IdCartera)){
									f.Numero_Cartera__c	= MapCarteras.get(r.IdCartera).ID;
								}								
								f.IdFactura__c		= r.IdFactura;//not null
								f.IdAgencia__c		= r.IdAgencia;//not null
								If(MapAgencias.containsKey(r.IdAgencia)){
									f.Agencia_Factura__c= MapAgencias.get(r.IdAgencia).ID;
								}
								f.Periodo__c		= r.Periodo;
								f.Emision__c		= r.Emision;
								f.Tipo_de_venta__c	= r.TipoVenta;
								f.IdCliente__c		= r.IdCliente;//not null
								f.Numero_cliente__c	= MapCuentas.get(r.IdCliente).ID;
								f.Nombre_Vendedor__c = r.NombreVendedor;
								f.Codigo_vendedor__c	= r.CodigoVendedor;
								f.Remision_op__c		= r.RemisionOp;
								f.Emision_OP__c			= r.EmisionOp;
								f.Direccion_despacho__c = r.DireccionDespacho;
								f.Monto_de_compra__c	= r.MontoCompra;
                                f.Stage__c				= r.Stage;
																
								FacturasPorInsertar.add(f);
								mapFacturas.put('f('+contadorFacturas+')' ,r);
								contadorFacturas++;
							}else{
								//Numero de cliente NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdFactura : ('+r.IdFactura+'). El numero de Cliente ('+r.IdCliente+') no existe en la Base de datos. ';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='FacturasAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdFactura : ('+r.IdFactura+'). ';
						If(r.IdFactura==null || r.IdFactura==''){msg+='IdFactura, ';}
						If(r.IdCliente==null || r.IdCliente==''){msg+='IdCliente, ';}
						If(r.NumeroFactura==null || r.NumeroFactura==''){msg+='NumeroFactura, ';}
						If(r.IdAgencia==null || r.IdAgencia==''){msg+='IdAgencia, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='FacturasAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Facturas a Insertar o Actualizar ' + FacturasPorInsertar);

                if(!FacturasPorInsertar.isEmpty()){
                    Database.UpsertResult[] FacturasPorInsertaResult = database.upsert(FacturasPorInsertar,IdFacturaField ,false);
                    if(!FacturasPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + FacturasPorInsertaResult.size());
                        for(Integer i=0;i<FacturasPorInsertaResult.size();i++){
                            Database.UpsertResult sr = FacturasPorInsertaResult[i];
                            Facturas f=mapFacturas.get('f('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                f.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdFactura : ('+f.IdFactura+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                f.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='FacturasAPI');
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
        FacturasResult.result=response;
		logRequest.ClassName__c='FacturasAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+FacturasResult.FacturasList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(FacturasResult);
    }
    
    global class FacturasUpsert{
        global list<Facturas>FacturasList{get;set;}     
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
    global class Facturas{
		global String NumeroFactura {get;set;}
        global String IdCartera{get;set;}
		global String IdFactura{get;set;}
		global String IdAgencia{get;set;}
		global String Periodo{get;set;}
		global Date Emision{get;set;}
		global String TipoVenta {get;set;}
		global String IdCliente{get;set;}
		global String NombreVendedor{get;set;}
		global String CodigoVendedor{get;set;}
		global String RemisionOp{get;set;}
		global Date EmisionOp{get;set;}			
		global String DireccionDespacho{get;set;}
		global Double MontoCompra{get;set;}
        global String Stage{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "FacturasList":[
                {
                "NumeroFactura":"F002",
				"IdCartera": "JAJA001SF101255967",
                "IdFactura": "JAJA0012019F002",
				"IdAgencia": "JA001",				
				"Periodo": "2019",
				"Emision": "2019-08-08",
				"TipoVenta": "CR",
				"IdCliente": "JA0011011900025P",
				"NombreVendedor": "Juan Palacios Torres",				
                "CodigoVendedor": "VE0057",               
                "RemisionOp":"OP0085",
                "EmisionOp": "2019-08-30",
				"DireccionDespacho": "Cali calle 45c",
				"MontoCompra": 1260				
                }              			
            ]
        }
    **/     
    
}