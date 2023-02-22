/*
    Creacion y actualizacion de Registros de Carteras
    Autor: Luis Espinoza
    14/oct/2019
*/
@RestResource(urlMapping='/CarterasAPI/*')
global with sharing class CarterasAPI {
    
    //https://  /services/apexrest/CarterasAPI
    @HttpPost
    //global static void upsertCarteras(){
    global static String upsertCarteras(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        CarterasUpsert CarterasResult = (CarterasUpsert) System.JSON.deserialize(body, CarterasUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(CarterasResult.CarterasList==null || CarterasResult.CarterasList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Carteras>CarterasArray=CarterasResult.CarterasList;
                List<Cartera__c>CarterasPorInsertar=new List<Cartera__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdCarteraField = Cartera__c.Fields.IdCartera__c;
                //Este mapa es para identificar el registro de Cartera en los resultados
                Map<String , Carteras>mapCarteras=new Map<String , Carteras>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorCarteras=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IdCliente, IdAgencia que vengan en los elementos
				List<String>ClientesKeySet=new List<String>();
				List<String>AgenciasKeySet=new List<String>();
				
				//Llenamos los depositos con cada elemento de cartera
				for(Carteras r: CarterasArray){
					If(r.IdCliente!=null){ClientesKeySet.add(r.IdCliente);}
					If(r.IdAgencia!=null){AgenciasKeySet.add(r.IdAgencia);}
				}
				//Preparamos un mapa de los registros de Clientes relacionados a las Carteras
				Map<String , Account>MapCuentas=new Map<String, Account>();
				For(Account a : [Select ID , Name, IdCliente__c from Account Where IdCliente__c IN : ClientesKeySet LIMIT 5000]){
					MapCuentas.put(a.IdCliente__c , a);
				}
				
				//Preparamos un mapa de los registros de Agencia relacionados a las Carteras
				Map<String , Agencia__c>MapAgencias=new Map<String, Agencia__c>();
				For(Agencia__c a : [Select ID , Name, IdAgencia__c from Agencia__c Where IdAgencia__c IN : AgenciasKeySet LIMIT 5000]){
					MapAgencias.put(a.IdAgencia__c , a);
				}
				
                for(Carteras r: CarterasArray){
                    System.debug('Cartera : ' + r);
					//validacion de valores requeridos
					If(r.IdCartera!=null && r.IdCartera!='' && r.IdCliente!=null && r.IdCliente!='' && r.NumeroCuenta!=null && r.NumeroCuenta!='' 
						&& r.IdAgencia!=null && r.IdAgencia!='' ){
							//validar que el IdCliente exista en la Base
							If(MapCuentas.containsKey(r.IdCliente)){
								Cartera__c c =  new Cartera__c();
								c.AccountId__c 		= MapCuentas.get(r.IdCliente).ID;
								c.IdCartera__c		= r.IdCartera;//not null
								c.Tipo_de_cuenta__c	= r.TipoCuenta;
								c.Name				= r.NumeroCuenta;//not null
								c.IdAgencia__c		= r.IdAgencia;//not null
								If(MapAgencias.containsKey(r.IdAgencia)){
									c.Agencia__c 	= MapAgencias.get(r.IdAgencia).ID;
								}								
								c.IdCliente__c		= r.IdCliente;//not null
								c.Tipo_credito__c	= r.TipoCredito;
								c.Fecha_de_emision__c = r.FechaEmision;
								c.Estado_de_la_cuenta__c = r.EstadoCuenta;
								c.Estado_del_Envio_de_Extracto__c = r.EstadoEnvioExtracto;
								c.EstadodelEnvioCertificadoalDia__c = r.EstadoEnvioCdia;
								c.Estado_del_envio_Declaracion__c = r.EstadoEnvioDrenta;
								c.Estado_del_Envio_Paz_y_Salvo__c = r.EstadoEnvioPazSalvo;
								c.Url_documento__c = r.UrlDocumento;
								c.Fecha_ultimo_pago__c = r.FechaUltPago;
								c.Monto_de_credito__c = r.MontoCredito;
								c.Monto_disponible__c = r.MontoDisponible;
								c.Valor_cuota__c = r.ValorCuota;
								c.Saldo_pendiente__c = r.SaldoPendiente;
								c.Saldo_vencido__c = r.SaldoVencido;
								c.Gastos_de_cobro__c = r.GastosCobro;
								c.Total_intereses__c = r.TotalIntereses;
								c.Total_seguro__c = r.TotalSeguro;
								c.Cuotas_vencidas__c = r.CuotasVencidas;
								c.Dia_de_corte__c = r.DiadeCorte;
								c.Tramo__c = r.Tramo;
								c.Fecha_vencimiento__c = r.FechaVencimiento;
								c.Total_dias_vencidos__c = r.DiasVencidos;
								c.ultimo_cambio_vencimiento__c = r.UltimoCambioVencimiento;
								c.APIUpsert__c 			= 	true;
                                c.Fecha_de_Primer_Pago__c = r.FechaPrimerPago;
                                c.Valor_Pagado_Primera_Fecha_de_Pago__c = r.ValorPrimerPago;
                                c.Fecha_actualizaci_n__c = r.FechaDeActualizacion;
								CarterasPorInsertar.add(c);
								mapCarteras.put('c('+contadorCarteras+')' ,r);
								contadorCarteras++;
							}else{
								//Numero de cliente NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdCartera : ('+r.IdCartera+'). El numero de Cliente ('+r.IdCliente+') no existe en la Base de datos.';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CarterasAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdCartera : ('+r.IdCartera+'). ';
						If(r.IdCartera==null || r.IdCartera==''){msg+='IdCartera, ';}
						If(r.IdCliente==null || r.IdCliente==''){msg+='IdCliente, ';}
						If(r.NumeroCuenta==null || r.NumeroCuenta==''){msg+='NumeroCuenta, ';}
						If(r.IdAgencia==null || r.IdAgencia==''){msg+='IdAgencia, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CarterasAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Carteras a Insertar o Actualizar ' + CarterasPorInsertar);

                if(!CarterasPorInsertar.isEmpty()){
                    Database.UpsertResult[] CarterasPorInsertaResult = database.upsert(CarterasPorInsertar,IdCarteraField ,false);
                    if(!CarterasPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + CarterasPorInsertaResult.size());
                        for(Integer i=0;i<CarterasPorInsertaResult.size();i++){
                            Database.UpsertResult sr = CarterasPorInsertaResult[i];
                            Carteras c=mapCarteras.get('c('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                c.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdCartera : ('+c.IdCartera+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                c.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='CarterasAPI');
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
        CarterasResult.result=response;
		logRequest.ClassName__c='CarterasAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+CarterasResult.CarterasList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(CarterasResult);
    }
    
    global class CarterasUpsert{
        global list<Carteras>CarterasList{get;set;}     
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
    global class Carteras{
		global String IdCartera {get;set;}
        global String TipoCuenta{get;set;}
		global String NumeroCuenta{get;set;}
		global String IdAgencia{get;set;}
		global String IdCliente{get;set;}
		global String TipoCredito{get;set;}
		global Date FechaEmision{get;set;}
		global String EstadoCuenta {get;set;}
		global String EstadoEnvioExtracto{get;set;}
		global String EstadoEnvioCdia{get;set;}
		global String EstadoEnvioDrenta{get;set;}
		global String EstadoEnvioPazSalvo{get;set;}
		global String UrlDocumento{get;set;}
		global Date FechaUltPago{get;set;}
        global Date FechaPrimerPago{get;set;}
        global Double ValorPrimerPago{get;set;}
		global Double MontoCredito{get;set;}
		global Double MontoDisponible{get;set;}
		global Double ValorCuota{get;set;}
		global Double SaldoPendiente{get;set;}	
		global Double SaldoVencido{get;set;}
		global Double GastosCobro{get;set;}
		global Double TotalIntereses{get;set;}
		global Double TotalSeguro{get;set;}								
		global Double CuotasVencidas{get;set;}
		global Double DiadeCorte{get;set;}
		global String Tramo{get;set;}
		global Date FechaVencimiento{get;set;}
		global Integer DiasVencidos{get;set;}
		global Date UltimoCambioVencimiento{get;set;}  
        global Date FechaDeActualizacion{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "CarterasList":[
                {
                "IdCartera":"JAJA001SF101255967",
				"TipoCuenta": "RF",
                "NumeroCuenta": "101255967",
				"IdAgencia": "JA001",
				"IdCliente": "JA0011011900025P",
				"TipoCredito": "TJ",
				"FechaEmision": "2019-08-08",
				"EstadoCuenta": "ACTIVO",
				"EstadoEnvioExtracto": "GENERADO",				
                "EstadoEnvioCdia": "GENERADO",               
                "EstadoEnvioDrenta":"ENVIADO A PROVEEDOR",
				"EstadoEnvioPazSalvo": "NO ENTREGADO A DESTINATARIO",
                "UrlDocumento": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                "FechaUltPago": "2019-08-30",
				"MontoCredito": 5000,
				"MontoDisponible": 1000,
				"ValorCuota": 25,
				"SaldoPendiente" : 250,
				"SaldoVencido": 125,
				"GastosCobro": 33.60,				
                "TotalIntereses": 48.52,
                "TotalSeguro": 8.6,
				"CuotasVencidas": 1,
                "DiadeCorte": 25,
                "Tramo": "1",
				"FechaVencimiento": "2019-07-30",
				"DiasVencidos": 31,
				"UltimoCambioVencimiento": "2019-06-06"					
                },
                {
                "IdCartera":"JAJA003TJ102895745",
				"TipoCuenta": "TJ",
                "NumeroCuenta": "102895745",
				"IdAgencia": "JA003",
				"IdCliente": "JA001180689004T",
				"TipoCredito": "TJ",
				"FechaEmision": "2016-01-30",
				"EstadoCuenta": "ACTIVO",
				"EstadoEnvioExtracto": "GENERADO",				
                "EstadoEnvioCdia": "GENERADO",               
                "EstadoEnvioDrenta":"ENVIADO A DESTINATARIO",
				"EstadoEnvioPazSalvo": "NO ENVIADO A DESTINATARIO",
                "UrlDocumento": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                "FechaUltPago": "2018-12-30",
				"MontoCredito": 85100,
				"MontoDisponible": 45960,
				"ValorCuota": 366,
				"SaldoPendiente" : 4520,
				"SaldoVencido": 2840,
				"GastosCobro": 125.60,				
                "TotalIntereses": 886.52,
                "TotalSeguro": 47.6,
				"CuotasVencidas": 5,
                "DiadeCorte": 21,
                "Tramo": "5",
				"FechaVencimiento": "2019-10-21",
				"DiasVencidos": 186,
				"UltimoCambioVencimiento": "2017-05-12"					
                }				
            ]
        }
    **/     
    
}