@isTest
public class FacturasAPI_Test {
  
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
    
    static testmethod void FacturasUpsertTest(){
			Account cuenta = [Select ID , IdCliente__c from Account Limit 1];
			Agencia__c agencia = [Select ID , IdAGencia__c from Agencia__c Limit 1];
			Cartera__c cartera = [Select ID , IdCartera__c from cartera__c Limit 1];
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/FacturasAPI/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"FacturasList":[{"NumeroFactura":"F002","IdCartera": "'+cartera.IdCartera__c+'","IdFactura": "JAJA0012019F002","IdAgencia": "'+agencia.IdAGencia__c+'","Periodo": "2019","Emision": "2019-08-08","TipoVenta": "CR",'+
					+'"IdCliente": "'+cuenta.IdCliente__c+'","NombreVendedor": "Juan","CodigoVendedor": "VE0057","RemisionOp":"OP0085","EmisionOp": "2019-08-30","DireccionDespacho": "Cali calle 45c","MontoCompra": 1260, "Stage": "X"}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            FacturasAPI.upsertFacturas();

			//test de la accion insert con array vacio
			String body2 = '{"FacturasList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            FacturasAPI.upsertFacturas();		
			
			//test de la accion insert con cliente inexistente
			String body3 = '{"FacturasList":[{"NumeroFactura":"F002","IdCartera": "'+cartera.IdCartera__c+'","IdFactura": "JAJA0012019F002","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "22514"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            FacturasAPI.upsertFacturas();
			
			//test de la accion insert con datos requeridos faltantes
			String body4 = '{"FacturasList":[{"NumeroFactura":"","IdCartera": "'+cartera.IdCartera__c+'","IdFactura": "JAJA0012019F002","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "22514"}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            FacturasAPI.upsertFacturas();			


			//test de la accion insert con datos erroneos
			String body5 = '{"FacturasList":[{"NumeroFactura":"F002","IdCartera": "'+cartera.IdCartera__c+'","IdFactura": "JAJA0012019F002","IdAgencia": "'+agencia.IdAGencia__c+'","Periodo": "2019","Emision": "2019-08-08","TipoVenta": "CRT",'+
					+'"IdCliente": "'+cuenta.IdCliente__c+'","NombreVendedor": "Juan","CodigoVendedor": "VE0057","RemisionOp":"OP0085","EmisionOp": "2019-08-30","DireccionDespacho": "Cali calle 45c","MontoCompra": 1260}]}';
            req.requestBody = blob.valueOF(body5);
            RestContext.request = req;
            FacturasAPI.upsertFacturas();			

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
					},
					{
					"NumeroFactura":"F003",
					"IdCartera": "JAJA003TJ102895745",
					"IdFactura": "JAJA0032019F003",
					"IdAgencia": "JA003",				
					"Periodo": "2019",
					"Emision": "2019-06-01",
					"TipoVenta": "TJ",
					"IdCliente": "JA001180689004T",
					"NombreVendedor": "Michel Gutierrez Lopez",				
					"CodigoVendedor": "VE0062",               
					"RemisionOp":"OP0064",
					"EmisionOp": "2018-12-30",
					"DireccionDespacho": "Barranquilla F66",
					"MontoCompra": 25000				
					}				
				]
			}
		  **/	
    }

    
}