/*
    Creacion y actualizacion de Registros de Clientes
    Autor: Luis Espinoza
    07/oct/2019
*/
@RestResource(urlMapping='/clientesapi/*')
global with sharing class ClientesAPI {
    
    //https://  /services/apexrest/ClientesAPI
    @HttpPost
    //global static void upsertClientes(){
    global static String upsertClientes(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        String idRecordPanama = '';
		String idRecordColombia = '';
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        ClientesUpsert ClientesResult = (ClientesUpsert) System.JSON.deserialize(body, ClientesUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(ClientesResult.ClientesList==null || ClientesResult.ClientesList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
           	  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.StringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<Clientes>ClientesArray=ClientesResult.ClientesList;
                List<Account>ClientesPorInsertar=new List<Account>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdClienteField = Account.Fields.IdCliente__c;
                //Este mapa es para identificar el registro de Cliente en los resultados
                Map<String , Clientes>mapClientes=new Map<String , Clientes>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorClientes=0;
                Integer contadorErrores=0;
				//obtener el recordType
				//Util.getRecordTypes();
				map<string, RecordType> mapRecordType = Util.getRecordTypes();
            	idRecordPanama =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
				idRecordColombia =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();		
            try{
                for(Clientes r: ClientesArray){
                    System.debug('Cliente ' + r);
					//validacion de valores requeridos
					If(r.Apellido!=null && r.Apellido!='' && r.Identificacion!=null && r.Identificacion!='' && r.IdCliente!=null 
						&& r.IdCliente!='' && r.Empresa!=null && r.Empresa!=''){
						Account a =  new Account();
                        if(r.Empresa == 'JA'){
						a.RecordTypeId			=	idRecordColombia;
						}else if(r.Empresa == 'JP'){
						a.RecordTypeId			=	idRecordPanama;
						}	    
						//a.RecordTypeId			=	Util.mapRecordType.get('Account-'+LABEL.AccountRecordTypePersonAccount).Id;
						a.AccountNumber			=	r.NumeroCliente;
						a.AccountSource			=	r.OrigenCliente;
						a.BillingCity			=	r.CiudadResidencia;
						a.BillingCountry		=	r.PaisResidencia;
						a.BillingState			= 	r.EstadoResidencia;
						a.BillingLatitude		=	r.LatitudResidencia;
						a.BillingLongitude		=	r.LongitudResidencia;
						a.BillingStreet			=	r.CalleResidencia;
						a.Description			=	r.Descripcion;
						a.Industry				=	r.Sector;
						//a.Name				=	r.NombreCompletoCliente;
						a.Phone					=	r.TelefonoTrabajo;
						a.Rating				=	r.Segmento;
						a.ShippingCity			=	r.CiudadTrabajo;
						a.ShippingCountry		=	r.PaisTrabajo;
						a.ShippingState			= 	r.EstadoTrabajo;
						a.ShippingLatitude		=	r.LatitudTrabajo;
						a.ShippingLongitude		=	r.LongitudTrabajo;
						a.ShippingStreet		=	r.CalleTrabajo;
						a.Type					=	r.Tipo;
						a.AnioInicio__c			=	r.AnioInicio;
						//person account fields
						a.PersonBirthdate		=	r.FechaNacimiento;
						a.PersonDepartment		=	r.Departamento;
						a.PersonDoNotCall		=	r.NoLlamar;
						a.PersonEmail			=	r.CorreoElectronico;
						a.FirstName				=	r.PrimerNombre;
						a.MiddleName			=	r.SegundoNombre;
						a.PersonHomePhone		=	r.TelefonoDomicilio;
						a.LastName				=	r.Apellido;//not null
						a.PersonMobilePhone		=	r.TelefonoMovil;
						//custom fields
						a.Identificacion__c		=	r.Identificacion;//not null
						a.IdCliente__c			=	r.IdCliente;//not null
						a.Empresa__c			=	r.Empresa;//not null
						a.TipodeEnvioDocumentacion__c	=	r.TipoEnvioDocumentacion;
						a.TipodeIdentificacion__c	=	r.TipoIdentificacion;
						a.Sexo__c				=	r.Sexo;
						a.Estado_civil__c		=	r.EstadoCivil;
						a.Ocupacion__c			=	r.Ocupacion;
						a.APIUpsert__c 			= 	true;
                        a.Token_Cliente__c		= 	r.TokenCliente;
						ClientesPorInsertar.add(a);
						mapClientes.put('a('+contadorClientes+')' ,r);
						contadorClientes++;
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdCliente : ('+r.IdCliente+'). ';
						If(r.Apellido==null || r.Apellido==''){msg+='Apellido, ';}
						If(r.Identificacion==null || r.Identificacion==''){msg+='Identificacion, ';}
						If(r.IdCliente==null || r.IdCliente==''){msg+='IdCliente, ';}
						If(r.Empresa==null || r.Empresa==''){msg+='Empresa, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='ClientesAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('Clientes a Insertar o Actualizar ' + ClientesPorInsertar);

                if(!ClientesPorInsertar.isEmpty()){
                    Database.UpsertResult[] ClientesPorInsertaResult = database.upsert(ClientesPorInsertar,IdClienteField ,false);
                    if(!ClientesPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + ClientesPorInsertaResult.size());
                        for(Integer i=0;i<ClientesPorInsertaResult.size();i++){
                            Database.UpsertResult sr = ClientesPorInsertaResult[i];
                            Clientes a=mapClientes.get('a('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                a.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdCliente : ('+a.IdCliente+'). The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                a.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='ClientesAPI');
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
                //Aqui registrar en el objeto Log
            }
        }
        ClientesResult.result=response;
		logRequest.ClassName__c='ClientesAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+ClientesResult.ClientesList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(ClientesResult);
    }
    
    global class ClientesUpsert{
        global list<Clientes>ClientesList{get;set;}     
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
    global class Clientes{
        global String NumeroCliente {get;set;}
		global String OrigenCliente {get;set;}
        global String CiudadResidencia{get;set;}
		global String PaisResidencia{get;set;}
		global String EstadoResidencia{get;set;}
		global Double LatitudResidencia{get;set;}
		global Double LongitudResidencia{get;set;}
		global String CalleResidencia{get;set;}
		global String Descripcion{get;set;}
		global String Sector{get;set;}
		//global String NombreCompletoCliente{get;set;}
		global String TelefonoTrabajo{get;set;}
		global String Segmento{get;set;}
		global String CiudadTrabajo{get;set;}
		global String PaisTrabajo{get;set;}
		global String EstadoTrabajo{get;set;}
		global Double LatitudTrabajo{get;set;}
		global Double LongitudTrabajo{get;set;}		
		global String CalleTrabajo{get;set;}
		global String Tipo{get;set;}
		global String AnioInicio{get;set;}
		global Date FechaNacimiento{get;set;}
		global String Departamento{get;set;}
		global Boolean NoLlamar{get;set;}
		global String CorreoElectronico{get;set;}
		global String PrimerNombre{get;set;}
		global String SegundoNombre{get;set;}
		global String TelefonoDomicilio{get;set;}
		global String Apellido{get;set;}
		global String TelefonoMovil{get;set;}
		global String Identificacion{get;set;}//not null
		global String IdCliente{get;set;}//not null
		global String Empresa{get;set;}//not null
		global String TipoEnvioDocumentacion{get;set;}
		global String TipoIdentificacion{get;set;}
		global String Sexo{get;set;}
        global String EstadoCivil{get;set;}        
        global String Ocupacion{get;set;}
        global String TokenCliente{get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "ClientesList":[
                {
                "NumeroCliente":"JA0001",
				"OrigenCliente": "Website",
                "CiudadResidencia":"Bogota",
                "PaisResidencia": "Colombia",
				"LatitudResidencia": 4.6486259,
				"LongitudResidencia": -74.2478912,
				"CalleResidencia": "16c",
				"Descripcion": "Test de creacion de cliente desde el ws",
				"Sector": "Education",
				"TelefonoTrabajo": "50688559966",				
                "Segmento": "RENTABLE",               
                "CiudadTrabajo":"Cali",
				"PaisTrabajo": "Colombia",
                "LatitudTrabajo": 3.4280053,
                "LongitudTrabajo": -76.545262,
				"CalleTrabajo": "15a",
				"Tipo": "Customer",
				"AnioInicio": "2015",
				"FechaNacimiento" : "1989-06-18",
				"Departamento": "Informatica",
				"NoLlamar": true,				
                "CorreoElectronico": "krojas@mail.com",
                "PrimerNombre":"Karol Maria",
				"TelefonoDomicilio": "22332585",
                "Apellido":"Rojas Sanchez",
                "TelefonoMovil": "88975285",
				"Identificacion": "001180689004T",
				"IdCliente": "JA001180689004T",
				"Empresa": "JA",
				"TipoEnvioDocumentacion": "DIGITAL",
				"TipoIdentificacion": "CEDULA DE CIUDADANIA",
				"Sexo": "FEMENINO",				                
				"EstadoCivil": "SOLTERO",
				"Ocupacion": "PROFESIONAL INDEPENDIENTE"
                },
                {
                "NumeroCliente":"JA0002",
				"OrigenCliente": "Purchased List",
                "CiudadResidencia":"Barranquilla",
                "PaisResidencia": "Colombia",
				"LatitudResidencia": 10.983818570359011,
				"LongitudResidencia": -74.8180175500000,
				"CalleResidencia": "77c",
				"Descripcion": "Test de creacion de otro cliente desde el ws",
				"Sector": "Entertainment",
				"TelefonoTrabajo": "774581120",				
                "Segmento": "POTROS CREDITO",               
                "CiudadTrabajo":"Medellin",
				"PaisTrabajo": "Colombia",
                "LatitudTrabajo": 6.2612061,
                "LongitudTrabajo": -75.5617707,
				"CalleTrabajo": "65f",
				"Tipo": "Analyst",
				"AnioInicio": "2012",
				"FechaNacimiento" : "2001-11-10",
				"Departamento": "Capital Humano",
				"NoLlamar": false,				
                "CorreoElectronico": "jparrales@mail.com",
                "PrimerNombre":"Jonathan Philipe",
				"TelefonoDomicilio": "22771750",
                "Apellido":"Parrales Duarte",
                "TelefonoMovil": "50473698",
				"Identificacion": "0011011900025P",
				"IdCliente": "JA0011011900025P",
				"Empresa": "JA",
				"TipoEnvioDocumentacion": "FISICO",
				"TipoIdentificacion": "EXTRANJERIA - (CEDULA)",
				"Sexo": "MASCULINO",				                
				"EstadoCivil": "CASADO",
				"Ocupacion": "EMPLEADO"
                },
                {
                "NumeroCliente":"JA0003",
				"OrigenCliente": "Webinar",
                "CiudadResidencia":"Barranquilla",
                "PaisResidencia": "Colombia",
				"LatitudResidencia": 10.983818570359011,
				"LongitudResidencia": -74.8180175500000,
				"CalleResidencia": "77c",
				"Descripcion": "Test de creacion de otro cliente3 desde el ws",
				"Sector": "Finance",
				"TelefonoTrabajo": "774581120",				
                "Segmento": "EJEMPLAR",               
                "CiudadTrabajo":"Medellin",
				"PaisTrabajo": "Colombia",
                "LatitudTrabajo": 6.2612061,
                "LongitudTrabajo": -75.5617707,
				"CalleTrabajo": "65f",
				"Tipo": "Reseller",
				"AnioInicio": "2018",
				"FechaNacimiento" : "2000-07-02",
				"Departamento": "Capital Humano",
				"NoLlamar": true,				
                "CorreoElectronico": "ihdz@mail.com",
                "PrimerNombre":"Shirley Ixel",
				"TelefonoDomicilio": "22761750",
                "Apellido":"Hernandez",
                "TelefonoMovil": "70563289",
				"Identificacion": "00250702007896I",
				"IdCliente": "JA00250702007896I",
				"Empresa": "JA",
				"TipoEnvioDocumentacion": "FISICO",
				"TipoIdentificacion": "PASAPORTE",
				"Sexo": "FEMENINO",				                
				"EstadoCivil": "DIVORCIADO",
				"Ocupacion": "COMERCIANTE NO FORMAL"
                }				
            ]
        }
    **/     
    
}