@isTest
public class ContactosAPI_Test {
  
		@testSetup static void setup(){
			map<string, RecordType> mapRecordType = Util.getRecordTypes();
			
			//create account
			Account cuenta = new Account();
			cuenta.RecordTypeId = Util.mapRecordType.get('Account-'+LABEL.AccountRecordTypePersonAccount).Id;
			cuenta.LastName = 'Ortiz';
			cuenta.Identificacion__c='001180689004T';
			cuenta.IdCliente__c='JA001180689004T';
			cuenta.Empresa__c='JA';
			Insert cuenta;
        }  
    
    static testmethod void ContactosUpsertTest(){
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/ContactosAPI/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"ContactosList":[{"FechaNacimiento":"2000-07-02","Descripcion": "Contactodeprueba","NoLlamar": true,"CorreoElectronico": "usuario@mail.com","Fax": "18006932","PrimerNombre": "Javier Cosme",'+
					+'"NoRecibirEmails": true,"NoRecibirFax": true,"TelefonoDomicilio": "23338574","Apellido": "Castillo Flores","OrigenCandidato":"Web","CiudadResidencia": "Cali",'+
					+'"PaisResidencia": "Colombia","LatitudResidencia": 3.4280053,"LongitudResidencia": -76.545262,"CalleResidencia": "15a","TelefonoMovil": "88975285","CiudadTrabajo" : "Bogota",'+
					+'"PaisTrabajo": "Colombia","LatitudTrabajo": 4.6486259,"LongitudTrabajo": -74.2478912,"CalleTrabajo":"16c","OtroTelefono": "89548562","TelefonoTrabajo":"21748598",'+
					+'"Titulo": "Sr","IdCliente": "JA001180689004T","TipoMiembro": "F","TipoReferencia": "FAMILIAR","TipoRelacion": "HIJO(A)","TipoIdentificacion": "PASAPORTE",'+
					+'"Empresa": "JA","Identificacion": "008101190558S","IdContacto": "JA008101190558S","Sexo": "MASCULINO","EstadoCivil": "SOLTERO","Ocupacion": "EMPLEADO"}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            ContactosAPI.upsertContactos();

			//test de la accion insert con array vacio
			String body2 = '{"ContactosList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            ContactosAPI.upsertContactos();			
			
			//test de la accion insert con cliente inexistente
			String body3 = '{"ContactosList":[{"FechaNacimiento":"2000-07-02","Descripcion": "Contactodeprueba","NoLlamar": true,"CorreoElectronico": "usuario@mail.com","Fax": "18006932","PrimerNombre": "Javier Cosme",'+
					+'"NoRecibirEmails": true,"NoRecibirFax": true,"TelefonoDomicilio": "23338574","Apellido": "Castillo Flores","OrigenCandidato":"Web","CiudadResidencia": "Cali",'+
					+'"PaisResidencia": "Colombia","LatitudResidencia": 3.4280053,"LongitudResidencia": -76.545262,"CalleResidencia": "15a","TelefonoMovil": "88975285","CiudadTrabajo" : "Bogota",'+
					+'"PaisTrabajo": "Colombia","LatitudTrabajo": 4.6486259,"LongitudTrabajo": -74.2478912,"CalleTrabajo":"16c","OtroTelefono": "89548562","TelefonoTrabajo":"21748598",'+
					+'"Titulo": "Sr","IdCliente": "JA00000","TipoMiembro": "F","TipoReferencia": "FAMILIAR","TipoRelacion": "HIJO(A)","TipoIdentificacion": "PASAPORTE",'+
					+'"Empresa": "JA","Identificacion": "008101190558S","IdContacto": "JA008101190558S","Sexo": "MASCULINO","EstadoCivil": "SOLTERO","Ocupacion": "EMPLEADO"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            ContactosAPI.upsertContactos();	
			
			//test de la accion insert con datos requeridos faltantes
			String body4 = '{"ContactosList":[{"IdCliente": "JA00000"}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            ContactosAPI.upsertContactos();						


			//test de la accion insert con datos erroneos
			String body5 = '{"ContactosList":[{"Apellido":"Ortiz" , "IdCliente": "JA001180689004T" , "Identificacion": "008101190558S", "IdContacto": "JA008101190558S" , "Empresa":"JAM"}]}';
            req.requestBody = blob.valueOF(body5);
            RestContext.request = req;
            ContactosAPI.upsertContactos();					
			
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

    
}