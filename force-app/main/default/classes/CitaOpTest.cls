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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JA', 'JA_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JA', 'JA_95_2021_2561402');
    }

    @IsTest static void calendarioEntregaJA400(){
        TestDataFactory.crearOportunityAndProducts('JA','JA_95_2021_2561402',null);

        Test.startTest();
        String body='{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(400, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JA', 'JA_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JA', 'JA_95_2021_2561402');
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
            CitaOp.calendarioCitaEntrega('JA', 'JA_95_2021_2561402', 'OP');
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(400, response.getStatusCode());
        CitaOp.calendarioCitaEntrega('JP', 'JP_95_2021_2561402', 'OP');
        Test.stopTest();
        lwcCitaOp.calendarioCitasEntrega('JP', 'JP_95_2021_2561402');
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
            CitaOp.calendarioCitaEntrega('JP', 'JP_95_2021_2561402', 'OP');
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

            
            lwcCitaOp.calendarioCitasEntrega('JA', 'JA_95_2021_2561402');
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, null,'GET',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, null,'GET',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, null,'GET',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, null,'GET',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(url, '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}','POST',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '{"country":"01","codeModel":"02","date":"20230330","rem":"3324759","agency":"95","tecnico":"00774","codRecurso":"03","unitType":"J1"}','PUT',null);
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
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '{"country":"01","codeModel":"02","date":"20230330","rem":"3324759","agency":"95","tecnico":"00774","codRecurso":"03","unitType":"J1"}','PUT',null);
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


}