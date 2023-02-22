/**
    TEST para clase MJAuthenticationAP
    Autor: Jonathan Parrales
    19/FEB/2020
	Helped by TestDataFactory & SEUSWSToken_Mock
**/
@isTest
public class MJAuthenticationAPI_Test {
	@testSetup static void setup(){
        //TestDataFactory.createGeneralData();
        
    }
    
    static testMethod void autenticar(){
        //Se llama al metodo sin el mock para entrar en el excpetion
        MJAuthenticationAPI.getAccessToken('user','password','endpoint');
    
    }
    
    static testMethod void autenticarExitoso(){
      	
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        Test.startTest();
    	MJAuthenticationAPI.getAccessToken('user','password','endpoint');
        TEst.stopTest();
    }
    
    static testMethod void autenticarTokenExistente(){
        //SAPAuthToken__c token = new SAPAuthToken__c(Token__c = 'TPrueba',Name = 'Token Actual', Fecha_de_Expiracion__c = datetime.now().addHours(24), Propiedad__c = 'Red Medica');
        //insert token;
        TestDataFactory.createToken();
        Test.startTest();
    	//MJAuthenticationAPI.getAccessToken('user','password','endpoint');
    	MJAuthenticationAPI.getAccessToken('user','password',label.SEUSWSToken);
        Test.stopTest();
    }
    
    static testMethod void autenticarTokenExistente2(){
                Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        //SAPAuthToken__c token = new SAPAuthToken__c(Token__c = 'TPrueba',Name = 'Token Actual', Fecha_de_Expiracion__c = datetime.now(), Propiedad__c = 'Red Medica');
        //insert token;
        TestDataFactory.createToken();
        Test.startTest();
    	MJAuthenticationAPI.Authentication auth  = MJAuthenticationAPI.getAccessToken('user','password','endpoint');
        auth.upsertToken();
        TEst.stopTest();
    }
}