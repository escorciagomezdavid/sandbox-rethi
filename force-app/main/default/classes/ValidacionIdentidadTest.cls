@IsTest
public with sharing class ValidacionIdentidadTest {
    @IsTest static void EvidenteFlaseTest200() {
        date myDate = date.newInstance(1987, 12, 17);
        Evidente evdt = new Evidente('JA_01_547376','07','ASC4', 'CC', '1043434561', 'DANIELA', 'SANCHEZ','NAVARRO',myDate,'ASC4');
        List<Evidente> ev = new List<Evidente>();
        ev.add(evdt);
        String body = '{"success":false,"message":"Error de elemento no encontrado. null"}';
        String endPoint = Endpoint__mdt.getInstance('Evidente').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{ "c_agr":"01", "usuario":"DSANCHEZ", "origen":"APPVENDEDOR","usu_autenticacion":72206494,"producto":"07","param_producto":2305,"canal":"001","ident_tipo":"CC","ident_numero":"1043434561","primer_nombre":"DANIELA","primer_apellido":"SANCHEZ","segundo_apellido":"NAVARRO","fecha_exp_documento":"05/12/2017"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ValidacionIdentidad.Evidente('JA', '01', 'ASC4', 'PASAPORTE', '1043434561', 'DANIELA', 'SANCHEZ', 'NAVARRO', '12-05-2017');
        Evidente.GenerarEvidente(ev);
    }

    @IsTest static void EvidenteTrueTest200() {
        date myDate = date.newInstance(1987, 12, 17);
        Evidente evdt = new Evidente('JA_01_547376','07','ASC4', 'CC', '1043434561', 'DANIELA', 'SANCHEZ','NAVARRO',myDate,'ASC4');
        List<Evidente> ev = new List<Evidente>();
        ev.add(evdt);
        String body = '{"success":true,"message":"CORREGIR EL NÚMERO DE IDENTIFICACIÓN. SI ES CORRECTO Y EL PROBLEMA PERSISTE DIRECCIONAR AL CLIENTE A LAS OF DE DATACREDITO.","data":{"id_evidente":285128,"id_auditoria":3985565,"reg_validacion":307860805,"ident_numero":"22398310","ident_tipo":"1","resultado":"06"}}';
        String endPoint = Endpoint__mdt.getInstance('Evidente').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{ "c_agr":"01", "usuario":"DSANCHEZ", "origen":"APPVENDEDOR","usu_autenticacion":72206494,"producto":"07","param_producto":2305,"canal":"001","ident_tipo":"CC","ident_numero":"1043434561","primer_nombre":"DANIELA","primer_apellido":"SANCHEZ","segundo_apellido":"NAVARRO","fecha_exp_documento":"05/12/2017"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ValidacionIdentidad.Evidente('JA', '01', 'ASC4', 'CEDULA DE CIUDADANIA', '1043434561', 'DANIELA', 'SANCHEZ', 'NAVARRO', '12-05-2017');
        Evidente.GenerarEvidente(ev);
    }

    @IsTest static void EvidenteTest500() {
        date myDate = date.newInstance(1987, 12, 17);
        Evidente evdt = new Evidente('JA_01_547376','07','ASC4', 'CEDULA DE CIUDADANIA', '1043434561', 'DANIELA', 'SANCHEZ','NAVARRO',myDate,'ASC4');
        List<Evidente> ev = new List<Evidente>();
        ev.add(evdt);
        String body = '{"success":true,"message":"Error de elemento no encontrado. null"}';
        String endPoint = Endpoint__mdt.getInstance('Evidente').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{ "c_agr":"01", "usuario":"DSANCHEZ", "origen":"APPVENDEDOR","usu_autenticacion":72206494,"producto":"07","param_producto":2305,"canal":"001","ident_tipo":"CC","ident_numero":"1043434561","primer_nombre":"DANIELA","primer_apellido":"SANCHEZ","segundo_apellido":"NAVARRO","fecha_exp_documento":"05/12/2017"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        ValidacionIdentidad.Evidente('JA', '01', 'ASC4', 'NIT', '1043434561', 'DANIELA', 'SANCHEZ', 'NAVARRO', '12-05-2017');
        Evidente.GenerarEvidente(ev);
    }

    @IsTest static void EvidenteTest400() {
       
        String body = '{"success":true,"message":"Error de elemento no encontrado. null"}';
        String endPoint = Endpoint__mdt.getInstance('Evidente').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{ "c_agr":"01", "usuario":"DSANCHEZ", "origen":"APPVENDEDOR","usu_autenticacion":72206494,"producto":"07","param_producto":2305,"canal":"001","ident_tipo":"CC","ident_numero":"1043434561","primer_nombre":"DANIELA","primer_apellido":"SANCHEZ","segundo_apellido":"NAVARRO","fecha_exp_documento":"05/12/2017"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        ValidacionIdentidad.Evidente('JA', '01', 'ASC4', 'CEDULA DE EXTRANJERIA', '1043434561', 'DANIELA', 'SANCHEZ', 'NAVARRO', '12-05-2017');
    }
    
    @IsTest static void ValidarEvidenteTest200() {

        ValidarEvidente valev = new ValidarEvidente('JA','1140903317');
        list<ValidarEvidente> evid = new list<ValidarEvidente>();
        evid.add(valev);

        String body = '{"success":true}';
        String endPoint = Endpoint__mdt.getInstance('ValidarEvidente').URL__c;
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
        ValidacionIdentidad.ValidarEvidente('JA', '1140903317');
        ValidarEvidente.ValidarEvidente(evid);
    }
    
    @IsTest static void ValidarEvidenteTest500() {

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('ValidarEvidente').URL__c;
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
        ValidacionIdentidad.ValidarEvidente('JA', '1140903317');
    }
    
    @IsTest static void ValidarEvidenteTest400() {

        ValidarEvidente valev = new ValidarEvidente('JA','1140903317');
        list<ValidarEvidente> evid = new list<ValidarEvidente>();
        evid.add(valev);

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('ValidarEvidente').URL__c;
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
        ValidacionIdentidad.ValidarEvidente('JA', '1140903317');
        ValidarEvidente.ValidarEvidente(evid);
    }
    
    @IsTest static void validarHuellaTest200() {

        validarHuella valHll = new validarHuella('JA_81_2972442','1140903317');
        list<validarHuella> huel = new list<validarHuella>();
        huel.add(valHll);

        String body = '{"success":true}';
        String endPoint = Endpoint__mdt.getInstance('validarHuella').URL__c;
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
        ValidacionIdentidad.validarHuella('JA','67','2972442','1140903317');
        validarHuella.validarHuella(huel);
    }
    
    @IsTest static void validarHuellaTest500() {

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('validarHuella').URL__c;
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
        ValidacionIdentidad.validarHuella('JA','67','2972442','1140903317');
    }
    
    @IsTest static void validarHuellaTest400() {

        validarHuella valHll = new validarHuella('JA_81_2972442','1140903317');
        list<validarHuella> huel = new list<validarHuella>();
        huel.add(valHll);

        String body = '{"success":false}';
        String endPoint = Endpoint__mdt.getInstance('validarHuella').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endpoint, ' ','GET','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        ValidacionIdentidad.validarHuella('JA','67','2972442','1140903317');
        validarHuella.validarHuella(huel);
    }

    @IsTest static void Evidentefail(){
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
            ValidacionIdentidad.Evidente('JA', '01', 'ASC4', 'TARJETA DE EXTRANJERIA', '1043434561', 'DANIELA', 'SANCHEZ', 'NAVARRO', '12-05-2017');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
    }
    
    @IsTest static void ValidarEvidentefail(){
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
           
            ValidacionIdentidad.ValidarEvidente('JA', '1140903317');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
     }
    }
    
    @IsTest static void validarHuellafail(){
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
           
            ValidacionIdentidad.validarHuella('JA','67','2972442','1140903317');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
     }
    }
}