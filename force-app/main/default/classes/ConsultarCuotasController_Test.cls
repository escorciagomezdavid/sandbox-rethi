@isTest
public class ConsultarCuotasController_Test {

    @TestSetup
    static void makeData(){
        Account cli = new Account
		(                
			Name='Test Individual',
			Empresa__c = 'JA',
			IdCliente__c = 'test',
			Identificacion__c = 'IDtest'
		);
		TriggerHandler.byPass('TriggerHandlerAccount');
		Insert cli;
		TriggerHandler.ClearbyPass('TriggerHandlerAccount');
		
		Cartera__c car = new Cartera__c
			(                
				idcartera__C='123_456_789_0000_1111',
				Name = '123456789',
				AccountId__c = cli.Id
			);
		TriggerHandler.byPass('TriggerHandlerCartera');
		Insert car;
        
        Factura__c f= new Factura__c();
        f.Name='12345';
        f.IdFactura__c = 'JAJA0012019F002';
        f.IdCartera__c = '123_456_789_0000_1111';
        Insert f;
    }
    
    @IsTest
    static void methodFactura(){
        Id idFactura = [Select Id From Factura__c Limit 1].id;

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('FacturaJSON');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            string resultado = ConsultarCuotasController.consultarCuotas(idFactura);
        Test.stopTest();
        
    }

    @IsTest
    static void methodCartera(){
        Id idCartera = [Select Id From Cartera__c Limit 1].id;

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('CarteraJSON');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            string resultado = ConsultarCuotasController.consultarCuotas(idCartera);
        Test.stopTest();
        
    }
}