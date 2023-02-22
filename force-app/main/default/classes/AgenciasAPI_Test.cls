@isTest
public class AgenciasAPI_Test {
  
		@testSetup static void setup(){
        }  
    
    static testmethod void agenciasUpsertTest(){
            test.startTest();
			
			Agencia__c agencia = new Agencia__c(Name='agencia1', Nombre_comercial__c='agencianombrecomercial' , IdAgencia__c='JA0000' , Empresa__c='JA' , Codigo_de_agencia__c='0000' );
			Insert agencia;
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/agenciasapi/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"agenciasList":[{"NombreAgencia":"Tienda Barranquilla","NombreComercial":"Muebles Jamar S.A Sucursal Barranquilla","IdAgencia": "JA001","Empresa": "JA","CodigoAgencia": "001"}]}';			
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            AgenciasAPI.upsertAgencias();
			
            // test de la accion con el array vacio
			String body2 = '{"agenciasList":[]}';			
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            AgenciasAPI.upsertAgencias();

			//test de la accion insert con un valor erroneo en empresa
			String body3 = '{"agenciasList":[{"NombreAgencia":"Tienda Barranquilla","NombreComercial":"Muebles Jamar S.A Sucursal Barranquilla","IdAgencia": "JA001","Empresa": "JAN","CodigoAgencia": "001"}]}';			
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            AgenciasAPI.upsertAgencias();

			//test de la accion insert para que genere error interno
			String body4 = '{"agenciasList":[{"NombreAgenci":"Tienda Barranquilla","NombreComercial":"Muebles Jamar S.A Sucursal Barranquílla","IdAgencia": "JA001","Empresa": "JAN","CodigoAgencia": "001"}]}';			
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            AgenciasAPI.upsertAgencias();	
			
			/**
				{
					"agenciasList":[
						{
						"NombreAgencia":"Tienda Barranquilla",
						"NombreComercial":"Muebles Jamar S.A Sucursal Barranquilla",
						"IdAgencia": "JA001",
						"Empresa": "JA",
						"CodigoAgencia": "001"
						}									  
					]
				}
		  **/	
    }

    
}