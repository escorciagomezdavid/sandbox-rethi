@isTest
public class ClientesAPI_Test {
  
		@testSetup static void setup(){
        }  
    
    static testmethod void ClientesUpsertTest(){
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/clientesapi/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"ClientesList":[{"NumeroCliente":"12345","OrigenCliente": "Website","CiudadResidencia":"Bogota","PaisResidencia": "Colombia","LatitudResidencia": 4.6486259,"LongitudResidencia": -74.2478912,'+
				+'"CalleResidencia": "16c","Descripcion": "Test de creacion de cliente desde el ws","Sector": "Education","TelefonoTrabajo": "50688559966","Segmento": "RENTABLE","CiudadTrabajo":"Cali","PaisTrabajo": "Colombia","LatitudTrabajo": 3.4280053,"LongitudTrabajo": -76.545262,'+
				+'"CalleTrabajo": "15a","Tipo": "Customer","AnioInicio": "2015","FechaNacimiento" : "1989-06-18","Departamento": "Informatica","NoLlamar": true,"CorreoElectronico": "krojas@mail.com","PrimerNombre":"Karol Maria","TelefonoDomicilio": "22332585","Apellido":"Rojas Sanchez",'+
                +'"TelefonoMovil": "88975285","Identificacion": "001180689004T","IdCliente": "JA001180689004T","Empresa": "JA","TipoEnvioDocumentacion": "DIGITAL","TipoIdentificacion": "CEDULA DE CIUDADANIA","Sexo": "FEMENINO","EstadoCivil": "SOLTERO","Ocupacion": "PROFESIONAL INDEPENDIENTE","TokenCliente": "AJAJAJAJ2222"}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            ClientesAPI.upsertClientes();
        
        	//test de la accion insert de registro nuevo JP
			String bodyJP = '{"ClientesList":[{"NumeroCliente":"12345","OrigenCliente": "Website","CiudadResidencia":"Bogota","PaisResidencia": "Colombia","LatitudResidencia": 4.6486259,"LongitudResidencia": -74.2478912,'+
				+'"CalleResidencia": "16c","Descripcion": "Test de creacion de cliente desde el ws","Sector": "Education","TelefonoTrabajo": "50688559966","Segmento": "RENTABLE","CiudadTrabajo":"Cali","PaisTrabajo": "Colombia","LatitudTrabajo": 3.4280053,"LongitudTrabajo": -76.545262,'+
				+'"CalleTrabajo": "15a","Tipo": "Customer","AnioInicio": "2015","FechaNacimiento" : "1989-06-18","Departamento": "Informatica","NoLlamar": true,"CorreoElectronico": "krojas@mail.com","PrimerNombre":"Karol Maria","TelefonoDomicilio": "22332585","Apellido":"Rojas Sanchez",'+
                +'"TelefonoMovil": "88975285","Identificacion": "001180689004T","IdCliente": "JA001180689004T","Empresa": "JP","TipoEnvioDocumentacion": "DIGITAL","TipoIdentificacion": "CEDULA DE CIUDADANIA","Sexo": "FEMENINO","EstadoCivil": "SOLTERO","Ocupacion": "PROFESIONAL INDEPENDIENTE"}]}';
            req.requestBody = blob.valueOF(bodyJP);
            RestContext.request = req;
            ClientesAPI.upsertClientes();

			//test de la accion insert con array vacio
			String body2 = '{"ClientesList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            ClientesAPI.upsertClientes();			
			
			//test de la accion insert con datos requeridos faltantes
			String body3 = '{"ClientesList":[{"NumeroCliente":"12345","PrimerNombre":"Karol Maria","Apellido":"","Identificacion": "001180689004T","IdCliente": "JA001180689004T","Empresa": "JA","TipoEnvioDocumentacion": "DIGITAL","TipoIdentificacion": "CEDULA DE CIUDADANIA","Sexo": "FEMENINO"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            ClientesAPI.upsertClientes();

			//test de la accion insert con datos erroneos
			String body4 = '{"ClientesList":[{"NumeroCliente":"12345","PrimerNombre":"Karol Maria","Apellido":"Rojas","Identificacion": "001180689004T","IdCliente": "JA001180689004T","Empresa": "JA","TipoEnvioDocumentacion": "DIGITAL","TipoIdentificacion": "CEDULA DE CIUDADANIA","Sexo": "FEMENINO"}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            ClientesAPI.upsertClientes();			
			
			/**
				{
				"ClientesList":[
                {
                "NumeroCliente":"12345",
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
                }
				]
				}
		  **/	
    }

    
}