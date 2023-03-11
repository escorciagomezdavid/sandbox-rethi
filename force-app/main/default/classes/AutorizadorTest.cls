@IsTest
public with sharing class AutorizadorTest {

    @IsTest static void EnviarAutorizadorTest200() {

        EnviarAutorizador autorz = new EnviarAutorizador('JA_81_2972442','JA_67_2022_3222686','SALESFORCE','1140903317','AseCre07','');
        list<EnviarAutorizador> autr = new list<EnviarAutorizador>();
        autr.add(autorz);

        String body = '{"message":"Se ha aprobado correctamente","success":true}';
        String endPoint = Endpoint__mdt.getInstance('EnviarAutorizador').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"pe_vcEmpresa":"JA","pe_vcAgeOp":"C1","pe_vcPerOp":"2023","pe_vcNumOp":"3305996","pe_vcPrograma":"SALESFORCE","pe_vcN_ide":"32863350","pe_vcAge_est":"95","pe_vcc_est":"3608425","pe_vcUsuario":"AseCre4","pe_vcProceso":""}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        AutorizadorClass.Autorizador('JA', '81', '2972442', '67', '2022', '3222686', 'SALESFORCE', '1140903317', 'AseCre07', '');
        EnviarAutorizador.EnviarAutor(autr);
    }
    
    @IsTest static void EnviarAutorizadorTest500() {

        String body = '{"message":"No se cumplio ninguna politica de ingreso codigo: Mensaje: , subir a punto de financiación","success":false}';
        String endPoint = Endpoint__mdt.getInstance('EnviarAutorizador').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"pe_vcEmpresa":"JA","pe_vcAgeOp":"C1","pe_vcPerOp":"2023","pe_vcNumOp":"","pe_vcPrograma":"SALESFORCE","pe_vcN_ide":"","pe_vcAge_est":"","pe_vcc_est":"","pe_vcUsuario":"AseCre4","pe_vcProceso":""}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        AutorizadorClass.Autorizador('JA', '81', '2972442', '67', '2022', '3222686', 'SALESFORCE', '1140903317', 'AseCre07', '');        
    }
    
    @IsTest static void EnviarAutorizadorTest400() {

        EnviarAutorizador autorz = new EnviarAutorizador('JA_81_2972442','JA_67_2022_3222686','SALESFORCE','1140903317','AseCre07','');
        list<EnviarAutorizador> autr = new list<EnviarAutorizador>();
        autr.add(autorz);
        
        String body = '"message":"Internal server error","success":false';
        String endPoint = Endpoint__mdt.getInstance('EnviarAutorizador').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"pe_vcEmpresa":"JA","pe_vcAgeOp":"C1","pe_vcPerOp":"2023","pe_vcNumOp":"3305996","pe_vcPrograma":"SALESFORCE","pe_vcN_ide":"32863350","pe_vcAge_est":"95","pe_vcc_est":"3608425","pe_vcUsuario":"AseCre4","pe_vcProceso":""}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        AutorizadorClass.Autorizador('JA', '81', '2972442', '67', '2022', '3222686', 'SALESFORCE', '1140903317', 'AseCre07', '');
        EnviarAutorizador.EnviarAutor(autr);
    }
    
    
    
    @IsTest static void EnviarAutorizadorfail(){
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Chatter Free User' LIMIT 1];    
            User usr = new User(LastName = 'TEST',
                                FirstName='Fail',
                                Alias = 'ftest',
                                Email = 'f.test@asdf.com',
                                Username = 'f.test@asdf.com',
                                ProfileId = profileId.id,
                                TimeZoneSidKey = 'GMT',
                                LanguageLocaleKey = 'en_US',
                                EmailEncodingKey = 'UTF-8',
                                LocaleSidKey = 'en_US'
                                );
            insert usr;
            User testUser = [SELECT Id FROM User WHERE alias = 'ftest'];
        Test.startTest();
        System.runAs(testUser){
        try{
           
            AutorizadorClass.Autorizador('JA', '81', '2972442', '67', '2022', '3222686', 'SALESFORCE', '1140903317', 'AseCre07', '');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
     }
    }
    
     
    
}