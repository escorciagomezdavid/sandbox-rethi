/*
    Creacion y actualizacion de Registros de Contactos
    Autor: Luis Espinoza
    08/oct/2019
*/
@RestResource(urlMapping='/contactosapi/*')
global with sharing class ContactosAPI {
    
    //https://  /services/apexrest/ContactosAPI
    @HttpPost
    //global static void upsertContactos(){
    global static String upsertContactos(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        ContactosUpsert ContactosResult = (ContactosUpsert) System.JSON.deserialize(body, ContactosUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(ContactosResult.ContactosList==null || ContactosResult.ContactosList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Contactos>ContactosArray=ContactosResult.ContactosList;
                List<Contact>ContactosPorInsertar=new List<Contact>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdContactoField = Contact.Fields.IdUnico__c;
                //Este mapa es para identificar el registro de Contacto en los resultados
                Map<String , Contactos>mapContactos=new Map<String , Contactos>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorContactos=0;
                Integer contadorErrores=0;
				//obtener recordTypes
				map<string, RecordType> mapRecordType = Util.getRecordTypes();				
            try{
				//deposito de los IdCliente que vengan en los elementos
				List<String>ClientesKeySet=new List<String>();
				//Llenamos el deposito con cada elemento de contacto
				for(Contactos r: ContactosArray){
					If(r.IdCliente!=null){ClientesKeySet.add(r.IdCliente);}
				}
				//Preparamos un mapa de los registros de Clientes relacionados a los contactos
				Map<String , Account>MapCuentas=new Map<String, Account>();
				For(Account a : [Select ID , Name, IdCliente__c from Account Where IdCliente__c IN : ClientesKeySet LIMIT 5000]){
					MapCuentas.put(a.IdCliente__c , a);
				}
                for(Contactos r: ContactosArray){
                    System.debug('Contacto ' + r);
					//validacion de valores requeridos
					If(r.Apellido!=null && r.Apellido!='' && r.IdCliente!=null && r.IdCliente!='' && r.Identificacion!=null && r.Identificacion!='' 
						&& r.IdContacto!=null && r.IdContacto!='' && r.Empresa!=null && r.Empresa!='' ){
							//validar que el IdCliente exista en la Base
							If(MapCuentas.containsKey(r.IdCliente)){
								Contact c =  new Contact();
								c.AccountPA__c 		= MapCuentas.get(r.IdCliente).ID;
								c.Birthdate 		= r.FechaNacimiento;
								c.Description 		= r.Descripcion;
								c.DoNotCall			= r.NoLlamar;
								c.Email 			= r.CorreoElectronico;
								c.Fax				= r.Fax;
								c.FirstName 		= r.PrimerNombre;
								c.HasOptedOutOfEmail	= r.NoRecibirEmails;
								c.HasOptedOutOfFax	= r.NoRecibirFax;
								c.HomePhone			= r.TelefonoDomicilio;
								c.LastName 			= r.Apellido;
								c.LeadSource 		= r.OrigenCandidato;
								c.MailingCity 		= r.CiudadResidencia;
								c.MailingCountry 	= r.PaisResidencia;
								c.MailingLatitude 	= r.LatitudResidencia;
								c.MailingLongitude 	= r.LongitudResidencia;
								c.MailingStreet		= r.CalleResidencia;
								c.MobilePhone 		= r.TelefonoMovil;
								c.OtherCity 		= r.CiudadTrabajo;
								c.OtherCountry 		= r.PaisTrabajo;
								c.OtherLatitude 	= r.LatitudTrabajo;
								c.OtherLongitude	= r.LongitudTrabajo;
								c.OtherStreet 		= r.CalleTrabajo;
								c.OtherPhone 		= r.OtroTelefono;
								c.Phone 			= r.TelefonoTrabajo;
								c.Title				= r.Titulo;
								c.IdCliente__c 		= r.IdCliente;
								c.Tipo_de_miembro__c	= r.TipoMiembro;
								c.Tipo_de_referencia__c = r.TipoReferencia;
								c.Tipo_de_relacion__c 	= r.TipoRelacion;
								c.tipo_de_identificacion__c = r.TipoIdentificacion;
								c.Empresa__c 		= r.Empresa;
								c.Identificacion__c = r.Identificacion;
								c.IdContacto__c 	= r.IdContacto;
								c.Sexo__c 			= r.Sexo;
								c.Estado_civil__c	= r.EstadoCivil;
								c.Ocupacion__c 		= r.Ocupacion;
								c.IdUnico__c 		= r.IdCliente+'_'+r.IdContacto;
								c.APIUpsert__c 			= 	true;
								ContactosPorInsertar.add(c);
								mapContactos.put('c('+contadorContactos+')' ,r);
								contadorContactos++;
							}else{
								//Numero de cliente NO existe en la BD , se envia el resultado como error
								Response res =  new Response();
								res.success=false;
								res.statusCode=Util.statusCode400;
								res.message='IdContacto : ('+r.IdCliente+'_'+r.IdContacto+'). El numero de Cliente ('+r.IdCliente+') no existe en la Base de datos.';                               
								r.result  =  res;
								contadorErrores++;
								Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='ContactosAPI');
								logsInsert.add(logError);								
							}
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdContacto : ('+r.IdCliente+'_'+r.IdContacto+'). ';
						If(r.Apellido==null || r.Apellido==''){msg+='Apellido, ';}
						If(r.IdCliente==null || r.IdCliente==''){msg+='IdCliente, ';}
						If(r.Identificacion==null || r.Identificacion==''){msg+='Identificacion, ';}
						If(r.IdContacto==null || r.IdContacto==''){msg+='IdContacto, ';}
						If(r.Empresa==null || r.Empresa==''){msg+='Empresa, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='ContactosAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Contactos a Insertar o Actualizar ' + ContactosPorInsertar);

                if(!ContactosPorInsertar.isEmpty()){
                    Database.UpsertResult[] ContactosPorInsertaResult = database.upsert(ContactosPorInsertar,IdContactoField ,false);
                    if(!ContactosPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + ContactosPorInsertaResult.size());
                        for(Integer i=0;i<ContactosPorInsertaResult.size();i++){
                            Database.UpsertResult sr = ContactosPorInsertaResult[i];
                            Contactos c=mapContactos.get('c('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                c.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdContacto : ('+c.IdCliente+'_'+c.IdContacto+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                c.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='ContactosAPI');
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
        ContactosResult.result=response;
		logRequest.ClassName__c='ContactosAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+ContactosResult.ContactosList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(ContactosResult);
    }
    
    global class ContactosUpsert{
        global list<Contactos>ContactosList{get;set;}     
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
    global class Contactos{
        global Date FechaNacimiento {get;set;}
		global String Descripcion {get;set;}
        global Boolean NoLlamar{get;set;}
		global String CorreoElectronico{get;set;}
		global String Fax{get;set;}
		global String PrimerNombre{get;set;}
		global Boolean NoRecibirEmails{get;set;}
		global Boolean NoRecibirFax{get;set;}
		global String TelefonoDomicilio{get;set;}
		global String Apellido{get;set;}//not null
		global String OrigenCandidato {get;set;}
		global String CiudadResidencia{get;set;}
		global String PaisResidencia{get;set;}
		global Double LatitudResidencia{get;set;}
		global Double LongitudResidencia{get;set;}
		global String CalleResidencia{get;set;}
		global String TelefonoMovil{get;set;}
		//global String NombreCompletoContacto{get;set;}				
		global String CiudadTrabajo{get;set;}
		global String PaisTrabajo{get;set;}
		global Double LatitudTrabajo{get;set;}
		global Double LongitudTrabajo{get;set;}	
		global String CalleTrabajo{get;set;}
		global String OtroTelefono{get;set;}
		global String TelefonoTrabajo{get;set;}
		global String Titulo{get;set;}								
		global String IdCliente{get;set;}//not null
		global String TipoMiembro{get;set;}
		global String TipoReferencia{get;set;}
		global String TipoRelacion{get;set;}
		global String TipoIdentificacion{get;set;}
		global String Empresa{get;set;}//not null
		global String Identificacion{get;set;}//not null
		global String IdContacto{get;set;}//not null						
		global String Sexo{get;set;}
        global String EstadoCivil{get;set;}        
        global String Ocupacion{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "ContactosList":[
                {
                "FechaNacimiento":"2000-07-02",
				"Descripcion": "Contacto de prueba creado desde el WS",
                "NoLlamar": true,
				"CorreoElectronico": "usuario@mail.com",
				"Fax": "18006932",
				"PrimerNombre": "Javier Cosme",
				"NoRecibirEmails": true,
				"NoRecibirFax": true,
				"TelefonoDomicilio": "23338574",				
                "Apellido": "Castillo Flores",               
                "OrigenCandidato":"Web",
				"CiudadResidencia": "Cali",
                "PaisResidencia": "Colombia",
                "LatitudResidencia": 3.4280053,
				"LongitudResidencia": -76.545262,
				"CalleResidencia": "15a",
				"TelefonoMovil": "88975285",
				"CiudadTrabajo" : "Bogota",
				"PaisTrabajo": "Colombia",
				"LatitudTrabajo": 4.6486259,				
                "LongitudTrabajo": -74.2478912,
                "CalleTrabajo":"16c",
				"OtroTelefono": "89548562",
                "TelefonoTrabajo":"21748598",
                "Titulo": "Sr",
				"IdCliente": "JA001180689004T",
				"TipoMiembro": "F",
				"TipoReferencia": "FAMILIAR",
				"TipoRelacion": "HIJO(A)",
				"TipoIdentificacion": "PASAPORTE",
				"Empresa": "JA",				                
				"Identificacion": "008101190558S",
				"IdContacto": "JA008101190558S",
				"Sexo": "MASCULINO",
				"EstadoCivil": "SOLTERO",
				"Ocupacion": "EMPLEADO"			
                }              				
            ]
        }
    **/     
    
}