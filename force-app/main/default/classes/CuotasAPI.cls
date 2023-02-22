/*
    Creacion y actualizacion de Registros de Cuotas
    Autor: Luis Espinoza
    05/nov/2019
*/
@RestResource(urlMapping='/CuotasAPI/*')
global with sharing class CuotasAPI {
    
    //https://  /services/apexrest/CuotasAPI
    @HttpPost
    //global static void upsertCuotas(){
    global static String upsertCuotas(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        CuotasUpsert CuotasResult = (CuotasUpsert) System.JSON.deserialize(body, CuotasUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(CuotasResult.CuotasList==null || CuotasResult.CuotasList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Cuotas>CuotasArray=CuotasResult.CuotasList;
                List<Cuota__c>CuotasPorInsertar=new List<Cuota__c>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdCuotaField = Cuota__c.Fields.IdCuota__c;
                //Este mapa es para identificar el registro de Factura en los resultados
                Map<String , Cuotas>mapCuotas=new Map<String , Cuotas>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorCuotas=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IDFactura, IdCarteras que vengan en los elementos
				List<String>FacturasKeySet=new List<String>();
				List<String>CarterasKeySet=new List<String>();
				
				//Llenamos los depositos con cada elemento de Cuota
				for(Cuotas r: CuotasArray){
					If(r.IdFactura!=null){FacturasKeySet.add(r.IdFactura);}
					If(r.IdCartera!=null){CarterasKeySet.add(r.IdCartera);}
				}
				//Preparamos un mapa de los registros de Factura relacionados a las Cuotas
				Map<String , Factura__c>MapFacturas=new Map<String, Factura__c>();
				For(Factura__c a : [Select ID , Name, IdFactura__c from Factura__c Where IdFactura__c IN : FacturasKeySet LIMIT 5000]){
					MapFacturas.put(a.IdFactura__c , a);
				}
				
				//Preparamos un mapa de los registros de Carteras relacionados a las Cuotas
				Map<String , Cartera__c>MapCarteras=new Map<String, Cartera__c>();
				For(Cartera__c a : [Select ID , Name, IdCartera__c from Cartera__c Where IdCartera__c IN : CarterasKeySet LIMIT 5000]){
					MapCarteras.put(a.IdCartera__c , a);
				}				
                for(Cuotas r: CuotasArray){
                    System.debug('Cuota : ' + r);
					//validacion de valores requeridos
					If(r.IdFactura!=null && r.IdFactura!='' && r.IdCuota!=null && r.IdCuota!='' && r.NumeroCuota!=null && r.NumeroCuota!='' 
						&& r.IdCartera!=null && r.IdCartera!='' ){
							//validar que el IdCartera exista en la Base
							If(MapCarteras.containsKey(r.IdCartera)){
								Cuota__c c =  new Cuota__c();
								c.Name 					= r.NumeroCuota;
								c.IdCuota__c			= r.IdCuota;
								c.Numero_documento__c	= r.NumeroDocumento;
								c.Fuente__c				= r.Fuente;
								c.Fecha_vencimiento__c	= r.FechaVencimiento;
								c.Fecha_pago__c			= r.FechaPago;
								c.Gastos_cobranza__c	= r.GastosCobranza;
								c.Intereses__c			= r.Intereses;
								c.Seguros__c			= r.Seguros;
								c.Estado_de_cuota__c	= r.EstadoCuota;
								c.IdFactura__c			= r.IdFactura;
                                c.Fecha_actualizacion__c = r.FechaActualizacion;
								If(MapFacturas.containsKey(r.IdFactura)){
									c.Numero_de_factura__c 	= MapFacturas.get(r.IdFactura).ID;
								}
								c.IdCartera__c			= r.IdCartera;
								If(MapCarteras.containsKey(r.IdCartera)){
									c.Numero_de_cartera__c 	= MapCarteras.get(r.IdCartera).ID;
								}
								c.Valor_pagado__c		= r.ValorPagado;								
								CuotasPorInsertar.add(c);
								mapCuotas.put('c('+contadorCuotas+')' ,r);
								contadorCuotas++;
							}else{
								//Numero de Cartera NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdCuota : ('+r.IdCuota+'). El numero de Cartera ('+r.IdCartera+') no existe en la Base de datos.';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CuotasAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdCuota : ('+r.IdCuota+'). ';
						If(r.IdCuota==null || r.IdCuota==''){msg+='IdCuota, ';}
						If(r.IdFactura==null || r.IdFactura==''){msg+='IdFactura, ';}
						If(r.NumeroCuota==null || r.NumeroCuota==''){msg+='NumeroCuota, ';}
						If(r.IdCartera==null || r.IdCartera==''){msg+='IdCartera, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='CuotasAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Cuotas a Insertar o Actualizar ' + CuotasPorInsertar);

                if(!CuotasPorInsertar.isEmpty()){
                    Database.UpsertResult[] CuotasPorInsertaResult = database.upsert(CuotasPorInsertar,IdCuotaField ,false);
                    if(!CuotasPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + CuotasPorInsertaResult.size());
                        for(Integer i=0;i<CuotasPorInsertaResult.size();i++){
                            Database.UpsertResult sr = CuotasPorInsertaResult[i];
                            Cuotas f=mapCuotas.get('c('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                f.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdCuota : ('+f.IdCuota+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                f.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='CuotasAPI');
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
        CuotasResult.result=response;
		logRequest.ClassName__c='CuotasAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+CuotasResult.CuotasList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(CuotasResult);
    }
    
    global class CuotasUpsert{
        global list<Cuotas>CuotasList{get;set;}     
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
    global class Cuotas{
		global String NumeroCuota {get;set;}
        global String IdCuota{get;set;}
		global String NumeroDocumento{get;set;}
		global String Fuente{get;set;}
		global Date FechaVencimiento{get;set;}
		global Date FechaPago{get;set;}
        global Date FechaActualizacion{get;set;}
		global Double GastosCobranza{get;set;}
		global Double Intereses{get;set;}
		global Double Seguros{get;set;}
		global String EstadoCuota{get;set;}
		global String IdFactura{get;set;}
		global String IdCartera{get;set;}
		global Double ValorPagado{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "CuotasList":[
                {
                "NumeroCuota":"02",
				"IdCuota": "JAJA001TJ101255963001CU0120191111",
                "NumeroDocumento": "20191111",
				"Fuente": "CU",				
				"FechaVencimiento": "2019-12-08",
                "FechaPago": "2019-12-08",
				"GastosCobranza": 25,
                "Intereses": 12,
				"Seguros": 2.5,				
				"EstadoCuota": "CANCELADA",			
                "IdFactura": "JA012019001",		
				"IdCartera": "JA01TARJETAJAMAR101255963",			
                "ValorPagado":39.5		
                },
                {
                "NumeroCuota":"03",
				"IdCuota": "JAJA001TJ101255963001CU0220191110",
                "NumeroDocumento": "20191110",
				"Fuente": "CU",				
				"FechaVencimiento": "2019-12-08",
                "FechaPago": "2019-11-10",
				"GastosCobranza": 32,
                "Intereses": 5.6,
				"Seguros": 1.7,				
				"EstadoCuota": "CANCELADA",			
                "IdFactura": "JA012019001",		
				"IdCartera": "JA01TARJETAJAMAR101255963",			
                "ValorPagado":25.85		
                }				
            ]
        }
    **/     
    
}