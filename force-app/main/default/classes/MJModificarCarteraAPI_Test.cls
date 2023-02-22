/**
    TEST para clase MJModificarCarteraAPI
    Autor: Jonathan Parrales
    21/FEB/2020
  Helped by TestDataFactory & SEUSWSActualizarCartera_Mock
**/
@isTest
public class MJModificarCarteraAPI_Test {
    @testSetup static void setup(){
        //Crear Datos de prueba		
        TestDataFactory.createCarteras(10);
        
    }
    //Testea el metodo updateSEUSCartera, en este caso no se llama el Mock del WS para generar un error y entrar al catch del error
    static testMethod void test_updateSEUSCarteraNoMock(){
       set<Id> CarteraIdSet = new set<Id>();
    for (Cartera__c a: [Select Id from Cartera__c limit 10]){
            CarteraIdSet.add(a.Id);
        }        
        MJModificarCarteraAPI.updateSEUSCartera(CarteraIdSet);
    }
    
    //Testea el metodo updateSEUSCartera, en este caso se llama el Mock del WS
    static testMethod void test_updateSEUSCarteraConMock(){
        set<Id> CarteraIdSet = new set<Id>();
        for (Cartera__c a: [Select Id from Cartera__c limit 10]){
            CarteraIdSet.add(a.Id);
        }
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarCartera_Mock());
        MJModificarCarteraAPI.updateSEUSCartera(CarteraIdSet);
        TEst.stopTest();
        
    }
	
    //Testea el metodo updateSEUSCartera, se llama al mock pero se hace un update de una cartera
    static testMethod void test_updateCartera(){
            Account cli = new Account
			(                
				Name='Test Individual',
				Empresa__c = 'JA',
				IdCliente__c = 'test',
				Identificacion__c = 'IDtest'
			);
			Insert cli;
		
        set<Id> CarteraIdSet = new set<Id>();
        Cartera__c a = [Select Id,ultimo_cambio_vencimiento__c,APIUpsert__c from Cartera__c limit 1];
		a.ultimo_cambio_vencimiento__c = system.today() + 1;
         
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarCartera_Mock());
        
		//llamado al ws desde creacion
		Cartera__c c = new Cartera__c
			(                
				idcartera__C='idCartera1234',
				AccountId__c = cli.Id,
				APIUpsert__c = true
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