@IsTest
public with sharing class CitaOpTest {
    public CitaOpTest() {
    }
    @IsTest static void calendarioEntrega(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);

        Test.startTest();
        String body='{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JA_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JA_95_2021_2561402');
    }
    @IsTest static void calendarioEntregaJA400(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);

        Test.startTest();
        String body='{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(400, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JA_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JA_95_2021_2561402');
    }
    @IsTest static void calendariaEntregaJAfail(){
        
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
            CitaOp.calendarioCitaEntrega('JA_95_2021_2561402', 'OP');
        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void calendarioEntregaJP400(){
        TestDataFactory.crearOportunityAndProducts('JP','JP_95_2021_2561402',null);

        Test.startTest();
        String body='{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(400, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JP_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JP_95_2021_2561402');
    }
    @IsTest static void calendariaEntregaJPfail(){
        
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
            CitaOp.calendarioCitaEntrega('JP_95_2021_2561402', 'OP');
        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void lwccalendariaEntregafail(){
        
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

            
            lwcCitaOp.calendarioCitasEntrega('JA_95_2021_2561402');
            //CitaOp.calendarioCitaEntrega('JA', 'JA_95_2021_2561402', 'OP');                       

        }catch(AuraHandledException ex){
            System.assertEquals('Script-thrown exception', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void asignacionCitaEntrega(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);

        Test.startTest();
        String body='{ "ps_nucoderror": 20, "ps_vcmenserror": "La cita a asignar debe ser mayor al dia actual"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint+'JA/asignarCitaEntrega', '{"userOper":"Daniela","origenOper": "SALESFORCE","comprMcia": "S","citaEntrega": "15/10/2021","tipoDoc": "OP","numOp": "2824356","periodo": "2021","agencia": "01"}','POST',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{ "ps_nucoderror": 20, "ps_vcmenserror": "La cita a asignar debe ser mayor al dia actual"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaOp('JA_95_2021_2561402', '2023-02-25', '0054O00000A10KNQAZ');
        Test.stopTest();
    }
    @IsTest static void validacionCitaEntrega(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399',null);        
        Account getCuenta = [Select ID from Account where Identificacion__c = 'ID001'];
        Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = '2599399'];
        TestDataFactory.crearCase('0054O00000A10KNQAZ', getCuenta.id,getIdOpp.Id);
        Test.startTest();        
        String body='{"data": [{"CITA_ENTREGA": "25/02/23"}]}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
        String url = endPoint + 'JA' + '/validacionCitaEntrega?n_ide=' + '1043434561' + '&rem=' + '2561402' + '&c_agr=' + '95' + '&per=' + '2021';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.validacionCitaEntrega('JA_95_2021_2599399', '2023-02-02', 'BOT', false);
        Test.stopTest();
        lwcCitaOp.asignacionCitaEntregaOp('JA_95_2021_2599399', '2023-02-02', 'BOT', false);      
    }
    @IsTest static void validacionCitaEntregaReasignacion(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399',null);        
        Account getCuenta = [Select ID from Account where Identificacion__c = 'ID001'];
        Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = '2599399'];
        TestDataFactory.crearCase('0054O00000A10KNQAZ', getCuenta.id,getIdOpp.Id);
        Test.startTest();        
        String body='{"data": [{"CITA_ENTREGA": "25/02/23"}]}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
        String url = endPoint + 'JA' + '/validacionCitaEntrega?n_ide=' + '1043434561' + '&rem=' + '2561402' + '&c_agr=' + '95' + '&per=' + '2021';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.validacionCitaEntrega('JA_95_2021_2599399', '2023-02-02', 'BOT', true);
        Test.stopTest();      
    }
    @IsTest static void validacionCitaEntregaNoArmable(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399','SinUrl');        
        Account getCuenta = [Select ID from Account where Identificacion__c = 'ID001'];
        Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = '2599399'];
        TestDataFactory.crearCase('0054O00000A10KNQAZ', getCuenta.id,getIdOpp.Id);
        Test.startTest();        
        String body='{"data": [{"CITA_ENTREGA": "25/02/23"}]}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
        String url = endPoint + 'JA' + '/validacionCitaEntrega?n_ide=' + '1043434561' + '&rem=' + '2561402' + '&c_agr=' + '95' + '&per=' + '2021';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.validacionCitaEntrega('JA_95_2021_2599399', '2023-02-02', 'BOT', true);
        Test.stopTest();      
    }
    @IsTest static void validacionCitaEntregadiferentea200(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399','SinUrl');        
        Test.startTest();        
        String body='{"message":"Internal server error"}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
        String url = endPoint + 'JA' + '/validacionCitaEntrega?n_ide=' + '1043434561' + '&rem=' + '2561402' + '&c_agr=' + '95' + '&per=' + '2021';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(500, response.getStatusCode());
        CitaOp.validacionCitaEntrega('JA_95_2021_2599399', '2023-02-02', 'BOT', true);
        Test.stopTest();
       
    }
    @IsTest static void validacionCitaEntregafail(){
        
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
            CitaOp.validacionCitaEntrega('JA_95_2021_2599399', '2023-02-02', 'BOT', true);
        }catch(ListException ex){
            System.assertEquals('List index out of bounds: 0', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void lwcAsignacionEntregafail(){
        
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

            
            lwcCitaOp.asignacionCitaEntregaOp('JA_95_2021_2599399', '2023-02-02', 'BOT', false);
            //CitaOp.calendarioCitaEntrega('JA', 'JA_95_2021_2561402', 'OP');                       

        }catch(AuraHandledException ex){
            System.assertEquals('Script-thrown exception', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void calendarioCitaArmado(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);

        Test.startTest();
        String body = '{'+
                    '    \"calendar\": \"2021-03-17:J1;2021-03-17:J2;2021-03-18:J1;2021-03-18:J2;2021-03-19:J1;2021-03-19:J2;2021-03-20:J1;2021-03-20:J2;2021-03-23:J1;2021-03-23:J2;2021-03-24:J1;2021-03-24:J2;2021-03-25:J1;2021-03-25:J2;2021-03-26:J1;2021-03-26:J2;2021-03-27:J1;2021-03-27:J2;2021-03-29:J1;2021-03-29:J2;2021-03-30:J1;2021-03-30:J2;2021-03-31:J1;2021-03-31:J2;2021-04-5:J1;2021-04-5:J2;2021-04-6:J1;2021-04-6:J2;2021-04-7:J1;2021-04-7:J2;2021-04-8:J1;2021-04-8:J2;2021-04-9:J1;2021-04-9:J2;2021-04-12:J1;2021-04-12:J2;2021-04-13:J1;2021-04-13:J2;2021-04-14:J1;2021-04-14:J2;2021-04-15:J1;2021-04-15:J2;2021-04-16:J1;2021-04-16:J2;2021-04-17:J1;2021-04-17:J2;2021-04-19:J1;2021-04-19:J2;2021-04-20:J1;2021-04-20:J2\",'+
                    '    \"tecnico\": \"007711\",'+
                    '    \"recurso\": \"03\",'+
                    '    \"error\": null,'+
                    '    \"ds\": \"{\\\"ps_vctecnico\\\":\\\"007711\\\",\\\"ps_vccodrecurso\\\":\\\"03\\\",\\\"ps_vccalendario\\\":\\\"2021-03-17:J1;2021-03-17:J2;2021-03-18:J1;2021-03-18:J2;2021-03-19:J1;2021-03-19:J2;2021-03-20:J1;2021-03-20:J2;2021-03-23:J1;2021-03-23:J2;2021-03-24:J1;2021-03-24:J2;2021-03-25:J1;2021-03-25:J2;2021-03-26:J1;2021-03-26:J2;2021-03-27:J1;2021-03-27:J2;2021-03-29:J1;2021-03-29:J2;2021-03-30:J1;2021-03-30:J2;2021-03-31:J1;2021-03-31:J2;2021-04-5:J1;2021-04-5:J2;2021-04-6:J1;2021-04-6:J2;2021-04-7:J1;2021-04-7:J2;2021-04-8:J1;2021-04-8:J2;2021-04-9:J1;2021-04-9:J2;2021-04-12:J1;2021-04-12:J2;2021-04-13:J1;2021-04-13:J2;2021-04-14:J1;2021-04-14:J2;2021-04-15:J1;2021-04-15:J2;2021-04-16:J1;2021-04-16:J2;2021-04-17:J1;2021-04-17:J2;2021-04-19:J1;2021-04-19:J2;2021-04-20:J1;2021-04-20:J2\\\",\\\"ps_vcmsgerror\\\":null}\"'+
                    '}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('Cita_Armado').URL__c;
        String url= endPoint+ '/'+'JA'+'/assembly-express';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioCitaArmado('JA_95_2021_2561402', '2021-03-17', '01');
        lwcCitaOp.calendarioArmado('JA_95_2021_2561402', '2021-03-17', '01');
        Test.stopTest();
    }

    @IsTest static void calendarioCitaArmado500(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);
        Test.startTest();
        String body = '{"message":"Internal server error"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        String endPoint = Endpoint__mdt.getInstance('Cita_Armado').URL__c;
        String url= endPoint+ '/'+'JA'+'/assembly-express';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(500, response.getStatusCode());
        CitaOp.calendarioCitaArmado('JA_95_2021_2561402', '2021-03-17', '01');
        Test.stopTest();
    }
    @IsTest static void calendarioCitaArmadoSinCalendario(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);
        Test.startTest();
        String body = '{calendar:null,tecnico: 007711,recurso: 03,error: null,ds: {ps_vctecnico:007711,ps_vccodrecurso:03,ps_vccalendario:2021-03-17:J1;2021-03-17:J2;2021-03-18:J1;2021-03-18:J2;2021-03-19:J1;2021-03-19:J2;2021-03-20:J1;2021-03-20:J2;2021-03-23:J1;2021-03-23:J2;2021-03-24:J1;2021-03-24:J2;2021-03-25:J1;2021-03-25:J2;2021-03-26:J1;2021-03-26:J2;2021-03-27:J1;2021-03-27:J2;2021-03-29:J1;2021-03-29:J2;2021-03-30:J1;2021-03-30:J2;2021-03-31:J1;2021-03-31:J2;2021-04-5:J1;2021-04-5:J2;2021-04-6:J1;2021-04-6:J2;2021-04-7:J1;2021-04-7:J2;2021-04-8:J1;2021-04-8:J2;2021-04-9:J1;2021-04-9:J2;2021-04-12:J1;2021-04-12:J2;2021-04-13:J1;2021-04-13:J2;2021-04-14:J1;2021-04-14:J2;2021-04-15:J1;2021-04-15:J2;2021-04-16:J1;2021-04-16:J2;2021-04-17:J1;2021-04-17:J2;2021-04-19:J1;2021-04-19:J2;2021-04-20:J1;2021-04-20:J2,ps_vcmsgerror:null}}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('Cita_Armado').URL__c;
        String url= endPoint+ '/'+'JA'+'/assembly-express';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioCitaArmado('JA_95_2021_2561402', '2021-03-17', '01');
        Test.stopTest();
    }
    @IsTest static void lwccalendarioArmadofail(){
        
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

            
            lwcCitaOp.calendarioArmado('JA_95_2021_2561402', '2021-03-17', '01');                   

        }catch(AuraHandledException ex){
            System.assertEquals('Script-thrown exception', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @IsTest static void asignacionCitaArmado(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399',null);        
        Test.startTest();        
        String body='{"calendar": "OK","error": "E-2. No hay datos de la OP para la AGE:95 Rem:3324759"}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('Asignacion_Cita_Armado').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"country":"01","codeModel":"02","date":"20230330","rem":"3324759","agency":"95","tecnico":"00774","codRecurso":"03","unitType":"J1"}','PUT');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaArmado('JA_95_2021_2599399', '01', '2023-02-01', '00774', '03', true, 'BOT');
        Test.stopTest();
        lwcCitaOp.AsignacionArmado('JA_95_2021_2599399', '01', '2023-02-01', '00774', '03', true, 'BOT');
    }
    @IsTest static void asignacionCitaArmadoNoOK(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399',null);        
        Test.startTest();        
        String body='{"calendar": null,"error": "E-2. No hay datos de la OP para la AGE:95 Rem:3324759"}';   
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String endPoint = Endpoint__mdt.getInstance('Asignacion_Cita_Armado').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"country":"01","codeModel":"02","date":"20230330","rem":"3324759","agency":"95","tecnico":"00774","codRecurso":"03","unitType":"J1"}','PUT');        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaArmado('JA_95_2021_2599399', '01', '2023-02-01', '00774', '03', true, 'BOT');
        Test.stopTest();
        lwcCitaOp.AsignacionArmado('JA_95_2021_2599399', '01', '2023-02-01', '00774', '03', true, 'BOT');
    }
    @IsTest static void lwccitaArmadofail(){
        
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
            lwcCitaOp.AsignacionArmado('JA_95_2021_2599399', '01', '2023-02-01', '00774', '03', true, 'BOT');                  

        }catch(AuraHandledException ex){
            System.assertEquals('Script-thrown exception', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @isTest static void lwcenvioProductosEntrega(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2599399',null);
        Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = '2599399'];
        lwcCitaOp.envioProductosEntrega(getIdOpp.Id);
    }
    @isTest static void calendarioEntregasParciales(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='[[{"calendario":[{"Fechas":[{"Fecha":"2023-03-22","Estado":"S"},{"Fecha":"2023-03-23","Estado":"S"}]}],"fecha_entrega":"2023-03-22","productos":[{"sku":"095166","nom_producto":"COLCHON TWIN 1.00X1.90X14 SENSACION POLIESTER SEMI ORTOPEDICO","fecha_entrega":"2023-03-22","cantidad":1.0,"csc":"100","es_obsequio":false,"padre":null}]}]]';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/entregas/' + '2561402';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @isTest static void calendarioEntregasParciales2opciones(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='[[{"calendario":[{"Fechas":[{"Fecha":"2023-04-05","Estado":"S"},{"Fecha":"2023-04-12","Estado":"S"},{"Fecha":"2023-04-14","Estado":"S"},{"Fecha":"2023-04-19","Estado":"S"},{"Fecha":"2023-04-21","Estado":"S"},{"Fecha":"2023-04-26","Estado":"S"},{"Fecha":"2023-04-28","Estado":"S"},{"Fecha":"2023-05-03","Estado":"S"},{"Fecha":"2023-05-05","Estado":"S"},{"Fecha":"2023-05-10","Estado":"S"},{"Fecha":"2023-05-12","Estado":"S"},{"Fecha":"2023-05-17","Estado":"S"},{"Fecha":"2023-05-19","Estado":"S"},{"Fecha":"2023-05-24","Estado":"S"},{"Fecha":"2023-05-26","Estado":"S"},{"Fecha":"2023-05-31","Estado":"S"},{"Fecha":"2023-06-02","Estado":"S"},{"Fecha":"2023-06-07","Estado":"S"},{"Fecha":"2023-06-09","Estado":"S"},{"Fecha":"2023-06-14","Estado":"S"},{"Fecha":"2023-06-16","Estado":"S"},{"Fecha":"2023-06-21","Estado":"S"},{"Fecha":"2023-06-23","Estado":"S"},{"Fecha":"2023-06-28","Estado":"S"}]}],"fecha_entrega":"2023-04-05","productos":[{"sku":"7023484","nom_producto":"SALA RINCONERA OPORTO CHENILLE LUXURY TRIGO 2X2","fecha_entrega":"2023-03-22","cantidad":1.0,"csc":"100","es_obsequio":false,"padre":null},{"sku":"095166","nom_producto":"COLCHON TWIN 1.00X1.90X14 SENSACION POLIESTER SEMI ORTOPEDICO","fecha_entrega":"2023-03-22","cantidad":1.0,"csc":"200","es_obsequio":false,"padre":null},{"sku":"TE70010100101","nom_producto":"TENDIDO 2.00 MADERA","fecha_entrega":"2023-04-05","cantidad":1.0,"csc":"400","es_obsequio":false,"padre":"7023203"},{"sku":"7023203","nom_producto":"CAMA DOBLE BASIC 2.00 FOSTER EUROLINO PERLA/CHAMPAÑA","fecha_entrega":"2023-04-05","cantidad":1.0,"csc":"300","es_obsequio":false,"padre":null}]}],[{"calendario":[{"Fechas":[{"Fecha":"2023-03-22","Estado":"S"},{"Fecha":"2023-03-24","Estado":"S"},{"Fecha":"2023-03-29","Estado":"S"},{"Fecha":"2023-03-31","Estado":"S"},{"Fecha":"2023-04-05","Estado":"S"},{"Fecha":"2023-04-12","Estado":"S"},{"Fecha":"2023-04-14","Estado":"S"},{"Fecha":"2023-04-19","Estado":"S"},{"Fecha":"2023-04-21","Estado":"S"},{"Fecha":"2023-04-26","Estado":"S"},{"Fecha":"2023-04-28","Estado":"S"},{"Fecha":"2023-05-03","Estado":"S"},{"Fecha":"2023-05-05","Estado":"S"},{"Fecha":"2023-05-10","Estado":"S"},{"Fecha":"2023-05-12","Estado":"S"},{"Fecha":"2023-05-17","Estado":"S"},{"Fecha":"2023-05-19","Estado":"S"},{"Fecha":"2023-05-24","Estado":"S"},{"Fecha":"2023-05-26","Estado":"S"},{"Fecha":"2023-05-31","Estado":"S"},{"Fecha":"2023-06-02","Estado":"S"},{"Fecha":"2023-06-07","Estado":"S"},{"Fecha":"2023-06-09","Estado":"S"},{"Fecha":"2023-06-14","Estado":"S"}]}],"fecha_entrega":"2023-03-22","productos":[{"sku":"7023484","nom_producto":"SALA RINCONERA OPORTO CHENILLE LUXURY TRIGO 2X2","fecha_entrega":"2023-03-22","cantidad":1.0,"csc":"100","es_obsequio":false,"padre":null},{"sku":"095166","nom_producto":"COLCHON TWIN 1.00X1.90X14 SENSACION POLIESTER SEMI ORTOPEDICO","fecha_entrega":"2023-03-22","cantidad":1.0,"csc":"200","es_obsequio":false,"padre":null}]},{"calendario":[{"Fechas":[{"Fecha":"2023-04-05","Estado":"S"},{"Fecha":"2023-04-12","Estado":"S"},{"Fecha":"2023-04-14","Estado":"S"},{"Fecha":"2023-04-19","Estado":"S"},{"Fecha":"2023-04-21","Estado":"S"},{"Fecha":"2023-04-26","Estado":"S"},{"Fecha":"2023-04-28","Estado":"S"},{"Fecha":"2023-05-03","Estado":"S"},{"Fecha":"2023-05-05","Estado":"S"},{"Fecha":"2023-05-10","Estado":"S"},{"Fecha":"2023-05-12","Estado":"S"},{"Fecha":"2023-05-17","Estado":"S"},{"Fecha":"2023-05-19","Estado":"S"},{"Fecha":"2023-05-24","Estado":"S"},{"Fecha":"2023-05-26","Estado":"S"},{"Fecha":"2023-05-31","Estado":"S"},{"Fecha":"2023-06-02","Estado":"S"},{"Fecha":"2023-06-07","Estado":"S"},{"Fecha":"2023-06-09","Estado":"S"},{"Fecha":"2023-06-14","Estado":"S"},{"Fecha":"2023-06-16","Estado":"S"},{"Fecha":"2023-06-21","Estado":"S"},{"Fecha":"2023-06-23","Estado":"S"},{"Fecha":"2023-06-28","Estado":"S"}]}],"fecha_entrega":"2023-04-05","productos":[{"sku":"TE70010100101","nom_producto":"TENDIDO 2.00 MADERA","fecha_entrega":"2023-04-05","cantidad":1.0,"csc":"400","es_obsequio":false,"padre":"7023203"},{"sku":"7023203","nom_producto":"CAMA DOBLE BASIC 2.00 FOSTER EUROLINO PERLA/CHAMPAÑA","fecha_entrega":"2023-04-05","cantidad":1.0,"csc":"300","es_obsequio":false,"padre":null}]}]]';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/entregas/' + '2561402';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @isTest static void calendarioEntregasParcialesSinCalendario(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='[]';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/entregas/' + '2561402';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @isTest static void calendarioEntregasParciales500(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='{"message":"Internal server error"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/entregas/' + '2561402';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(500, response.getStatusCode());
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @IsTest static void calendarioParcialfail(){
        
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
            CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');                  

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
    }
    }
    @isTest static void calendarioEntregasParcialesSinvendedor(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='129';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @isTest static void calendarioEntregasParcialesNoencuentraOp(){
        Test.startTest();
        CitaOp.calendarioEntregasParciales('JA_95_2021_2561402');
        Test.stopTest();
    }
    @IsTest static void asignacionEntregaParcial(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Account getCuenta = [Select ID from Account where Identificacion__c = 'ID001'];
        Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = '2561402'];
        TestDataFactory.crearCase('0054O00000A10KNQAZ', getCuenta.id,getIdOpp.Id);
        Test.startTest();
        String body='{"info_rem":{"tienda":"95","per":"2023","numop":"3300247"},"grupos":[{"cita_entrega":"26-02-2023","productos":[{"cod":"7001482","csc":"100"},{"cod":"7019359","csc":"200"}]}]}';
        String respuesta='{"status":true,"message":"Reparto guardado correctamente"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,respuesta));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/guardarreparto';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, body, 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = respuesta;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaEntregaParcial('JA_95_2021_2561402', body, 'BOT');
        lwcCitaOp.asignacionCitaEntregaParcial('JA_95_2021_2561402', body, 'BOT');
        Test.stopTest();
    }
    @IsTest static void asignacionEntregaParcialSinCaso(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='{"info_rem":{"tienda":"95","per":"2023","numop":"3300247"},"grupos":[{"cita_entrega":"26-02-2023","productos":[{"cod":"7001482","csc":"100"},{"cod":"7019359","csc":"200"}]}]}';
        String respuesta='{"status":true,"message":"Reparto guardado correctamente"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,respuesta));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/guardarreparto';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, body, 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = respuesta;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaEntregaParcial('JA_95_2021_2561402', body, 'BOT');
        Test.stopTest();
    }
    @IsTest static void asignacionEntregaParcialNoExitosa(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='{"info_rem":{"tienda":"95","per":"2023","numop":"3300247"},"grupos":[{"cita_entrega":"26-02-2023","productos":[{"cod":"7001482","csc":"100"},{"cod":"7019359","csc":"200"}]}]}';
        String respuesta='{"status":false,"message":"Reparto guardado correctamente"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,respuesta));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/guardarreparto';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, body, 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = respuesta;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.asignacionCitaEntregaParcial('JA_95_2021_2561402', body, 'BOT');
        Test.stopTest();
    }
    @IsTest static void asignacionEntregaParcial500(){
        TestDataFactory valor = new TestDataFactory();
        valor.codigoVendedor='904';
        valor.id_oportunidad='JA_95_2021_2561402';
        valor.empresa='JA';
        TestDataFactory.crearOrdenPedido(valor);
        Test.startTest();
        String body='{"info_rem":{"tienda":"95","per":"2023","numop":"3300247"},"grupos":[{"cita_entrega":"26-02-2023","productos":[{"cod":"7001482","csc":"100"},{"cod":"7019359","csc":"200"}]}]}';
        String respuesta='{"message":"Internal server error"}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        String stage = System.label.STAGE;
        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
        String url = endpoint.URL__c + valor.empresa + '/guardarreparto';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalBasic(url, body, 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = respuesta;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(500, response.getStatusCode());
        CitaOp.asignacionCitaEntregaParcial('JA_95_2021_2561402', body, 'BOT');
        Test.stopTest();
    }


}