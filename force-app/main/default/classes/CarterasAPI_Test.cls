@isTest
public class CarterasAPI_Test {
  
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
        }  
    
    static testmethod void CarterasUpsertTest(){
			Account cuenta = [Select ID , IdCliente__c from Account Limit 1];
			Agencia__c agencia = [Select ID , IdAGencia__c from Agencia__c Limit 1];
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/CarterasAPI/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"CarterasList":[{"IdCartera":"JA'+agencia.IdAGencia__c+'SF001",'+
				+'"TipoCuenta": "RF","NumeroCuenta": "001","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "'+cuenta.IdCliente__c+'","TipoCredito": "TJ",'+
				+'"FechaEmision": "2019-08-08","EstadoCuenta": "ACTIVO","EstadoEnvioExtracto": "GENERADO","EstadoEnvioCdia": "GENERADO","EstadoEnvioDrenta":"GENERADO","EstadoEnvioPazSalvo": "GENERADO",'+
                +'"FechaUltPago": "2019-08-30","MontoCredito": 5000,"MontoDisponible": 1000,"ValorCuota": 25,"SaldoPendiente" : 250,"SaldoVencido": 125,"GastosCobro": 33.60,"TotalIntereses": 48.52,'+
                +'"TotalSeguro": 8.6,"CuotasVencidas": 1,"DiadeCorte": 25,"Tramo": "1","FechaVencimiento": "2019-07-30","DiasVencidos": 31,"UltimoCambioVencimiento": "2019-06-06", "FechaPrimerPago": "2019-06-06", "ValorPrimerPago": 40008.52}]}';
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            CarterasAPI.upsertCarteras();

			//test de la accion insert con array vacio
			String body2 = '{"CarterasList":[]}';
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            CarterasAPI.upsertCarteras();			
			
			//test de la accion insert con cliente inexistente
			String body3 = '{"CarterasList":[{"IdCartera":"JA'+agencia.IdAGencia__c+'SF001",'+
				+'"TipoCuenta": "RF","NumeroCuenta": "001","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "1234","TipoCredito": "TJ"}]}';
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            CarterasAPI.upsertCarteras();
			
			//test de la accion insert con datos requeridos faltantes
			String body4 = '{"CarterasList":[{"IdCartera":"JA'+agencia.IdAGencia__c+'SF001",'+
				+'"TipoCuenta": "RF","NumeroCuenta": "001","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "","TipoCredito": "TJ"}]}';
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            CarterasAPI.upsertCarteras();					


			//test de la accion insert con datos erroneos
			String body5 = '{"CarterasList":[{"IdCartera":"JA'+agencia.IdAGencia__c+'SF001",'+
				+'"TipoCuenta": "RFTTTT","NumeroCuenta": "001","IdAgencia": "'+agencia.IdAGencia__c+'","IdCliente": "'+cuenta.IdCliente__c+'","TipoCredito": "TJ",'+
				+'"FechaEmision": "2019-08-08","EstadoCuenta": "ACTIVO","EstadoEnvioExtracto": "GENERADO","EstadoEnvioCdia": "GENERADO","EstadoEnvioDrenta":"GENERADO","EstadoEnvioPazSalvo": "GENERADO",'+
                +'"FechaUltPago": "2019-08-30","MontoCredito": 5000,"MontoDisponible": 1000,"ValorCuota": 25,"SaldoPendiente" : 250,"SaldoVencido": 125,"GastosCobro": 33.60,"TotalIntereses": 48.52,'+
                +'"TotalSeguro": 8.6,"CuotasVencidas": 1,"DiadeCorte": 25,"Tramo": "1","FechaVencimiento": "2019-07-30","DiasVencidos": 31,"UltimoCambioVencimiento": "2019-06-06", "FechaDeActualizacion": "2019-06-06"}]}';
            req.requestBody = blob.valueOF(body5);
            RestContext.request = req;
            CarterasAPI.upsertCarteras();				

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

    
}