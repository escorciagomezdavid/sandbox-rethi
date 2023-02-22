public with sharing class MJAsyncServicesCall{	
    
	//MJAsyncServicesCall.updateSEUSAccount(AccountsToApiUpsert);
    @future (callout=true)
    public static void updateSEUSAccount(set<Id> accountIdSet){
        //If(Test.isRunningTest() == false)
          MJModificarClienteAPI.updateSEUSAccount(accountIdSet);
    }
	
	//MJAsyncServicesCall.updateSEUSContact(ContactsToApiUpsert);
    @future (callout=true)
    public static void updateSEUSContact(set<Id> contactIdSet){
        //If(Test.isRunningTest() == false)
          MJModificarContactoAPI.updateSEUSContact(contactIdSet);
    }	
	
	//MJAsyncServicesCall.updateSEUSCartera(CarterasToApiUpsert);
    @future (callout=true)
    public static void updateSEUSCartera(set<Id> carteraIdSet){
        //If(Test.isRunningTest() == false)
          MJModificarCarteraAPI.updateSEUSCartera(carteraIdSet);
    }	

	//MJAsyncServicesCall.createSEUSCobroDomicilio(CobrosDomicilioToApiUpsert);
    @future (callout=true)
    public static void createSEUSCobroDomicilio(set<Id> cobrosDomicilioIdSet){
        //If(Test.isRunningTest() == false)
          MJCrearCobroDomicilioAPI.createSEUSCobroDomicilio(cobrosDomicilioIdSet);
    }
	
	//MJAsyncServicesCall.createSEUSCompromisoPago(CasesToApiUpsert);
    @future (callout=true)
    public static void createSEUSCompromisoPago(set<Id> CompromisosPagoIdSet){
        //If(Test.isRunningTest() == false)
          MJCrearCompromisoPagoAPI.createSEUSCompromisoPago(CompromisosPagoIdSet);
    }		
}