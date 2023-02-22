@isTest
public class DetallesFacturaAPI_Test {
  
		@testSetup static void setup(){
			map<string, RecordType> mapRecordType = Util.getRecordTypes();

			//create factura
			Factura__c f= new Factura__c();
			f.Name='12345';
			f.IdFactura__c='JAJA0012019F002';
			Insert f;
			
			//create producto
			Product2 p = new Product2();
			p.Name='mesa';
			p.IdProducto__c='JAP001';
			Insert p;
        }
    
    static testmethod void DetallesFacturaUpsertTest(){
			/*Account cuenta = [Select ID , IdCliente__c from Account Limit 1];
			Agencia__c agencia = [Select ID , IdAGencia__c from Agencia__c Limit 1];
			Cartera__c cartera = [Select ID , IdCartera__c from cartera__c Limit 1];*/
			Factura__c f = [Select ID , IdFactura__c from Factura__c Limit 1];
			Product2 p = [Select ID , IdProducto__c from Product2 Limit 1];
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/DetallesFacturaAPI/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"DetallesFacturaList":[{"CodigoDetalleFactura":"0124741","IdDetalle": "JAJA0012019F0020124741","IdFactura": "'+f.IdFactura__c+'","Cantidad": 25,"IdProducto": "'+p.IdProducto__c+'"}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            DetallesFacturaAPI.upsertDetallesFactura();

			//test de la accion insert con array vacio
			String body2 = '{"DetallesFacturaList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            DetallesFacturaAPI.upsertDetallesFactura();		
			
			//test de la accion insert con cliente inexistente
			String body3 = '{"DetallesFacturaList":[{"CodigoDetalleFactura":"0124741","IdDetalle": "JAJA0012019F0020124741","IdFactura": "1234","Cantidad": 25,"IdProducto": "'+p.IdProducto__c+'"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            DetallesFacturaAPI.upsertDetallesFactura();
			
			//test de la accion insert con datos requeridos faltantes
			String body4 = '{"DetallesFacturaList":[{"IdDetalle":""}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            DetallesFacturaAPI.upsertDetallesFactura();	


			//test de la accion insert con datos erroneos
			String body5 = '{"DetallesFacturaList":[{"CodigoDetalleFactura":"0124741","IdDetalle": "JAJA0012019F0020124741","IdFactura": "'+f.IdFactura__c+'","Cantidad": 4454656765432132486464641,"IdProducto": "'+p.IdProducto__c+'"}]}';
            req.requestBody = blob.valueOF(body5);
            RestContext.request = req;
            DetallesFacturaAPI.upsertDetallesFactura();		

			/**
			{
				"DetallesFacturaList":[
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