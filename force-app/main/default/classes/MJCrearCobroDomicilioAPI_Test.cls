/**
    TEST para clase MJCrearCompromisoPagoAPI
    Autor: Jonathan Parrales
    21/FEB/2020
  Helped by TestDataFactory & 
**/
@isTest
public class MJCrearCobroDomicilioAPI_Test {
@testSetup static void setup(){
        // se crea un token fake
		system.debug('TEST: se crea el token fake');
		SEUSAuthToken__c MyToken = new SEUSAuthToken__c(Name = 'Token Actual' , Propiedad__c = 'SEUS' , Token__c = 'test', FechaDeExpiracion__c = system.today()+1);			
		Insert MyToken;	
        //Crear Datos de prueba
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.createCarteras(1);
		TestDataFactory.createCases(1);
        TestDataFactory.createCobrosDomicilio(10);			
        
    }
    //Testea el metodo updateSEUSAccount, en este caso no se llama el Mock del WS para generar un error y entrar al catch del error
    static testMethod void test_createSEUSCompromisoPagoNoMock(){
       set<Id> CobrosDomicilioIdSet = new set<Id>();
    for (Cobro_a_domicilio__c a: [Select Id from Cobro_a_domicilio__c limit 10]){
            CobrosDomicilioIdSet.add(a.Id);
        }        
        MJCrearCobroDomicilioAPI.createSEUSCobroDomicilio(CobrosDomicilioIdSet);
    }
    
    //Testea el metodo updateSEUSAccount, en este caso se llama el Mock del WS
    static testMethod void test_createSEUSCompromisoPagoConMock(){
        set<Id> CobrosDomicilioIdSet = new set<Id>();
        for (Cobro_a_domicilio__c a: [Select Id from Cobro_a_domicilio__c limit 10]){
            CobrosDomicilioIdSet.add(a.Id);
        }
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        //Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarContacto_Mock());
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSCrearCobroDomicilio_Mock());
        MJCrearCobroDomicilioAPI.createSEUSCobroDomicilio(CobrosDomicilioIdSet);
        TEst.stopTest();
        
    }
	
    //Testea el metodo updateSEUSCartera, se llama al mock pero se hace un update de una cartera
    static testMethod void test_updateCobroDomicilio(){         
		
		Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
		
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
				idcartera__C='idCartera1234',
				Name = '123456789',
				AccountId__c = cli.Id
			);
		TriggerHandler.byPass('TriggerHandlerCartera');
		Insert car;
		TriggerHandler.clearbyPass('TriggerHandlerCartera');
		
		Case caso = new Case
			(
				Status='Abierto',	  
				OwnerId = Userinfo.getUserId(),
				AccountId = cli.Id
			);
		TriggerHandler.byPass('TriggerHandlerCase');
		Insert caso;	
		TriggerHandler.clearbyPass('TriggerHandlerCase');
				
        set<Id> CarteraIdSet = new set<Id>();
        Cobro_a_domicilio__c a = [Select Id,Comentarios_del_cliente__c,APIUpsert__c from Cobro_a_domicilio__c limit 1];
		a.Comentarios_del_cliente__c = 'teststtststststs';
			
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSCrearCobroDomicilio_Mock());
        
		//llamado al ws desde creacion
		Cobro_a_domicilio__c c = new Cobro_a_domicilio__c
			(                
				Numero_cartera__c = car.Id,
				APIUpsert__c = true,
				Numero_caso__c = caso.Id
			);
		Insert c;
		
		//llamado al ws desde actualizacion
		update a;
		
		//actualizacion desde SEUS
		a.APIUpsert__c = true;
		update a;
		
        TEst.stopTest();
        
    }		

}