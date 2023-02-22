/**
    TEST para clase MJCrearCompromisoPagoAPI
    Autor: Jonathan Parrales
    21/FEB/2020
	Helped by TestDataFactory & 
**/
@isTest
public class MJCrearCompromisoPagoAPI_Test {
	@testSetup static void setup(){
        //Crear Datos de prueba
        TestDataFactory.createCases(10);
        
    }
    //Testea el metodo updateSEUSAccount, en este caso no se llama el Mock del WS para generar un error y entrar al catch del error
    static testMethod void test_createSEUSCompromisoPagoNoMock(){
       set<Id> CompromisosPagoIdSet = new set<Id>();
		for (Case a: [Select Id from Case limit 10]){
            CompromisosPagoIdSet.add(a.Id);
        }        
        MJCrearCompromisoPagoAPI.createSEUSCompromisoPago(CompromisosPagoIdSet);
    }
    
    //Testea el metodo updateSEUSAccount, en este caso se llama el Mock del WS
    static testMethod void test_createSEUSCompromisoPagoConMock(){
        set<Id> CompromisosPagoIdSet = new set<Id>();
        for (Case a: [Select Id from Case limit 10]){
            CompromisosPagoIdSet.add(a.Id);
        }
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        //Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarContacto_Mock());
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSCrearCompromisoPago_Mock());
        MJCrearCompromisoPagoAPI.createSEUSCompromisoPago(CompromisosPagoIdSet);
        TEst.stopTest();
        
    }

}