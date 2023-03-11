@IsTest
public  with sharing class ProcesoFirmaTest {

    @IsTest static void EnviarOtpTest200() {
        EnviarOtp Envotp = new EnviarOtp('3006640003', 'jcmaestre@gmail.com', '1001825573', 'JA');
        list<EnviarOtp> etp = new list<EnviarOtp>();
        etp.add(Envotp);
        
        String body =  '{"errorcode": 0, "attempts_send_sms_otp": true}';
        String endPoint = Endpoint__mdt.getInstance('EnviarOtp').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"mobile": "3006640003", "email": "jcmaestre@gmail.com", "otpId":"1001825573", "proceso": "D"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.EnviarOtp('3006640003', 'jcmaestre', '1001825573', 'JA');
        EnviarOtp.EnviarOTP(etp);
    }
    @IsTest static void EnviarOtpTest500(){
        
        String body = '{"errorcode": null "attempts_send_sms_otp": null}';
        String endPoint = Endpoint__mdt.getInstance('EnviarOtp').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"mobile": "3006640003", "email": "jcmaestre@gmail.com", "otpId":"1001825573", "proceso": "D"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.EnviarOtp('3006640003', 'jcmaestre', '1001825573', 'JA');  
    }   
    
    @IsTest static void EnviarOtpTest400(){
        EnviarOtp Envotp = new EnviarOtp('3006640003', 'jcmaestre@gmail.com', '1001825573', 'JA');
        list<EnviarOtp> etp = new list<EnviarOtp>();
        etp.add(Envotp);
        
        String body =  '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('EnviarOtp').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"mobile": "3006640003", "email": "jcmaestre@gmail.com", "otpId":"1001825573", "proceso": "D"} ','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.EnviarOtp('3006640003', 'jcmaestre', '1001825573', 'JA');
        EnviarOtp.EnviarOTP(etp);
    }
    
    @IsTest static void ValidarOtpTest200(){
        ValidarOtp Valotp = new ValidarOtp('1001825573', '27712', 'JA');
        list<ValidarOtp> vtp = new list<ValidarOtp>();
        vtp.add(Valotp);
        
        String body =  '{"message": true }';
        String endPoint = Endpoint__mdt.getInstance('ValidarOTP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,'','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.ValidarOtp('1001825573', '27712', 'JA');
        ValidarOtp.ValidarOTP(vtp);
    }
    
    @IsTest static void ValidarOtpTest500(){
       
        String body =  '{"message": null}';
        String endPoint = Endpoint__mdt.getInstance('ValidarOTP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,'','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.ValidarOtp('1001825573', '27712', 'JA');
    }
    @IsTest static void ValidarOtpTest400(){
        ValidarOtp Valotp = new ValidarOtp('1001825573', '27712', 'JA');
        list<ValidarOtp> vtp = new list<ValidarOtp>();
        vtp.add(Valotp);
        
        String body =  ' ';
        String endPoint = Endpoint__mdt.getInstance('ValidarOTP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,'','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.ValidarOtp('1001825573', '27712', 'J');
        ValidarOtp.ValidarOTP(vtp);
    }
    @IsTest static void DesmaterializacionTest200() {

        Desmaterializacion Desmtr = new Desmaterializacion('JA_B5_3555107', 'JA_B5_2022_2938248', '1129514335', '57287', 'JAMAR');
        list<Desmaterializacion> desm = new list<Desmaterializacion>();
        desm.add(Desmtr);

        String body = '{"ps_vcResultado":"OK","ps_vcResultMens":"Desmaterialización de documentos realizada de forma exitosa"}';
        String endPoint = Endpoint__mdt.getInstance('Desmaterializacion').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"age_est": "01", "cod_est": "3386996","cod_agr": "95","periodo": "2022","rem": "2938248","cedula": "1129514335","otp": "57287","usuario":"JAMAR", "empresa": "JA"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.Desmaterializacion('01','3386996','95','2022','2938248','1129514335','57287','JAMAR', 'JA');
        Desmaterializacion.Desmaterializacion(desm);
    }
    
    @IsTest static void DesmaterializacionTest500() {

        String body = '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('Desmaterializacion').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"age_est": "01", "cod_est": "3386996","cod_agr": "95","periodo": "2022","rem": "2938248","cedula": "1129514335","otp": "57287","usuario":"JAMAR", "empresa": "JA"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.Desmaterializacion('01','3386996','95','2022','2938248','1129514335','57287','JAMAR', 'JA');
    }
    
        @IsTest static void validarFirmasTest200() {

        validarFirmas valFirm = new validarFirmas('JA_81_2972442','1140903317');
        list<validarFirmas> firm = new list<validarFirmas>();
        firm.add(valFirm);

        String body = '{"success":true}';
        String endPoint = Endpoint__mdt.getInstance('validarFirmas').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, ' ','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.validarFirmas('JA','67','2972442','1140903317');
        validarFirmas.validarFirmas(firm);
    }
    
    @IsTest static void validarFirmasTest500() {

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('validarFirmas').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, ' ','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.validarFirmas('JA','67','2972442','1140903317');
    }
    
    @IsTest static void validarFirmasTest400() {

        validarFirmas valFirm = new validarFirmas('JA_81_2972442','1140903317');
        list<validarFirmas> firm = new list<validarFirmas>();
        firm.add(valFirm);

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('validarHuella').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, ' ','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        ProcesoFirma.validarFirmas('JA','67','2972442','1140903317');
        validarFirmas.validarFirmas(firm);
    }
    
     @IsTest static void EnviarOtpFail(){
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
            ProcesoFirma.EnviarOtp('3006640003', 'jcmaestre@gmail.com', '1001825573', 'JA');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
     }
     @IsTest static void ValidarOtpFail(){
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
            ProcesoFirma.ValidarOtp('1001825573','27527' , 'empresa');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
    }
    @IsTest static void DesmterializacionFail(){
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
            ProcesoFirma.Desmaterializacion('01','3386996','95','2022','2938248','1129514335','57287','JAMAR', 'JA');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
    }
    
    @IsTest static void validarFirmasfail(){
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
           
            ProcesoFirma.validarFirmas('JA','67','2972442','1140903317');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
     }
    }
    
}