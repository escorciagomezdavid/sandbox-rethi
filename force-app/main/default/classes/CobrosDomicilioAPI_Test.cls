@isTest
public class CobrosDomicilioAPI_Test {
  
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
			
			//create agencia
			Agencia__c a = new Agencia__c();
			a.Name='Sucursal Cali';
			a.IdAGencia__c = 'JA001';
			a.Codigo_de_agencia__c='001';
			a.Empresa__c='JA';
			Insert a;

			//create cartera
			Cartera__c c = new Cartera__c();
			c.Name='101255967';
			c.IdCartera__c = 'JAJA001SF101255967';
			c.IdAGencia__c=a.IdAGencia__c;
			c.Agencia__c=a.Id;
			c.IdCliente__c=cuenta.IdCliente__c;
			c.AccountId__c=cuenta.Id;
			Insert c;
        }
    
    static testmethod void CobrosDomicilioUpsertTest(){
			Account cuenta = [Select ID , IdCliente__c from Account Limit 1];
			/*Agencia__c agencia = [Select ID , IdAGencia__c from Agencia__c Limit 1];*/
			Cartera__c cartera = [Select ID , IdCartera__c from cartera__c Limit 1];
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/CobrosDomicilioAPI/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"CobrosDomicilioList":[{"IdVisitacobro":"JAJA001JA101255963JA001180689004T20191111","Dia": "2019-11-11","MontoPagar": 250.00,"Jornada": "","ComentariosCliente": "Test","IdCartera": "'+cartera.IdCartera__c+'","IdCliente": "'+cuenta.IdCliente__c+'"}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            CobrosDomicilioAPI.upsertCobrosDomicilio();

			//test de la accion insert con array vacio
			String body2 = '{"CobrosDomicilioList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            CobrosDomicilioAPI.upsertCobrosDomicilio();		
			
			//test de la accion insert con cartera inexistente
			String body3 = '{"CobrosDomicilioList":[{"IdVisitacobro":"JAJA001JA101255963JA001180689004T20191111","Dia": "2019-11-11","MontoPagar": 250.00,"Jornada": "","ComentariosCliente": "Test","IdCartera": "'+cartera.IdCartera__c+'","IdCliente": "7878454"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            CobrosDomicilioAPI.upsertCobrosDomicilio();
			
			//test de la accion insert con datos requeridos faltantes
			String body4 = '{"CobrosDomicilioList":[{"IdDetalle":""}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            CobrosDomicilioAPI.upsertCobrosDomicilio();	


			//test de la accion insert con datos erroneos
			String body5 = '{"CobrosDomicilioList":[{"IdVisitacobro":"JAJA001JA101255963JA001180689004T20191111","Dia": "2019-11-11","MontoPagar": 2575435132132484840.00,"Jornada": "","ComentariosCliente": "Test","IdCartera": "'+cartera.IdCartera__c+'","IdCliente": "'+cuenta.IdCliente__c+'"}]}';
            req.requestBody = blob.valueOF(body5);
            RestContext.request = req;
            CobrosDomicilioAPI.upsertCobrosDomicilio();

			/**
			{
				"CobrosDomicilioList":[
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
					}			
				]
			}
		  **/	
    }

    
}