/**
    TEST para clase MJModificarContactoAPI
    Autor: Jonathan Parrales
    19/FEB/2020
	Helped by TestDataFactory & 
**/
@isTest
public class MJModificarContactoAPI_Test {
 	
    
    @testSetup static void setup(){
        //Crear Datos de prueba
        TestDataFactory.createOrphanContacts(10);
        
    }
    //Testea el metodo updateSEUSAccount, en este caso no se llama el Mock del WS para generar un error y entrar al catch del error
    static testMethod void test_updateSEUSContactNoMock(){
       set<Id> orphanContactsIdSet = new set<Id>();
		for (Contact a: [Select Id from Contact limit 10]){
            orphanContactsIdSet.add(a.Id);
        }        
        MJModificarContactoAPI.updateSEUSContact(orphanContactsIdSet);
    }
    
    //Testea el metodo updateSEUSAccount, en este caso se llama el Mock del WS
    static testMethod void test_updateSEUSContactConMock(){
        set<Id> orphanContactsIdSet = new set<Id>();
        for (Contact a: [Select Id from Contact limit 10]){
            orphanContactsIdSet.add(a.Id);
        }
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        //Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarContacto_Mock());
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarContacto_Mock());
        MJModificarContactoAPI.updateSEUSContact(orphanContactsIdSet);
        TEst.stopTest();
        
    }

}