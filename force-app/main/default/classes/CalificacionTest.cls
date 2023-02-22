@IsTest
public with sharing class CalificacionTest {

    @IsTest static void accionSugeridaTest200() {

        AccionSugerida AccionSug = new AccionSugerida('JA_01_547376','22398310','asesorc4');
        list<AccionSugerida> accS = new list<AccionSugerida>();
        accS.add(AccionSug);

        String body = '{"success":true,"data":{"accion_sugerida":"G1","segmento":"ORO","saldo_cartera":0.0,"total":0.0,"saldo":0.0,"cod_error":null,"mensj_error":null}}';
        String endPoint = Endpoint__mdt.getInstance('AccionSugerida').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Programa": "SALESFORCE", "UsuSimulador": "asecre4C","Usuario": "asecre4C","CalcularLectura": "SI","Ide": "22398310","Est": "547376","Agr": "01","emp":"JA"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.AccionSugerida('JA','01','547376','22398310','asecre4C');
        AccionSugerida.consultaAccionSugerida(accS);
    }

    @IsTest static void accionSugeridaTest500() {

        String body = '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('AccionSugerida').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Programa": "SALESFORCE", "UsuSimulador": "asecre4C","Usuario": "asecre4C","CalcularLectura": "SI","Ide": "22398310","Est": "547376","Agr": "01","emp":"JA"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        Calificacion.AccionSugerida('JA','01','547376','22398310','asecre4C');
    }

    @IsTest static void accionSugeridaTest400() {
        
        AccionSugerida AccionSug = new AccionSugerida('JA_01_547376','22398310','asesorc4');
        list<AccionSugerida> accS = new list<AccionSugerida>();
        accS.add(AccionSug);
        String body = '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('AccionSugerida').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Programa": "SALESFORCE", "UsuSimulador": "asecre4C","Usuario": "asecre4C","CalcularLectura": "SI","Ide": "22398310","Est": "547376","Agr": "01","emp":"JA"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        Calificacion.AccionSugerida('JA','01','547376','22398310','asecre4C');
        AccionSugerida.consultaAccionSugerida(accS);
    }

    @IsTest static void capacidadDePagoTest400() {

        CapacidadPago CP = new CapacidadPago('JA_01_547376','22398310','22398310','asecre4C');
        list<CapacidadPago> Cpg = new list<CapacidadPago>();
        Cpg.add(CP);
        String body = '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('CapacidadPago').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Empresa": "JA","age_est": "01", "cod_est": "3855467", "titular": "1000111222","miembro": "1000111222","excluir_op": "N","nun_decimales": "-2", "programa": "FABRICA","usuario": "SANDRADE"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPago('JA', '01', '3855467', '1000111222', '1000111222', 'asecre4C');
        CapacidadPago.consultarCapacidadPago(Cpg);
    }

    @IsTest static void capacidadDePagoTest200() {
        
        CapacidadPago CP = new CapacidadPago('JA_01_547376','22398310','22398310','asecre4C');
        list<CapacidadPago> Cpg = new list<CapacidadPago>();
        Cpg.add(CP);
        String body = '{"data":{"nucuotasugerida":87099.0,"nucuotasugtol":95808.9,"nucuotasugdisp":70000.0,"nucuotaconsumida":null,"nucuotaencartera":0.0,"nucuotapagarnormal":21810.0,"nucuotapagarplanfinan":16821.0,"nucumplecuota":1.0,"mensaje":"Cuota Ok","nombreimagen":null,"visatribute":"NORMAL","nucoderror":null,"menserror":null},"success":true}';
        String endPoint = Endpoint__mdt.getInstance('CapacidadPago').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Empresa": "JA","age_est": "01", "cod_est": "3855467", "titular": "1000111222","miembro": "1000111222","excluir_op": "N","nun_decimales": "-2", "programa": "FABRICA","usuario": "SANDRADE"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPago('JA', '01', '3855467', '1000111222', '1000111222', 'asecre4C');
        CapacidadPago.consultarCapacidadPago(Cpg);
    }

    @IsTest static void capacidadDePagoTest500() {

        String body = '{"message":"Internal server error"}';
        String endPoint = Endpoint__mdt.getInstance('AccionSugerida').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"Empresa": "JA","age_est": "01", "cod_est": "3855467", "titular": "1000111222","miembro": "1000111222","excluir_op": "N","nun_decimales": "-2", "programa": "FABRICA","usuario": "SANDRADE"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPago('JA', '01', '3855467', '1000111222', '1000111222', 'asecre4C');
    }

    @IsTest static void formPepTest400() {

        String body = '{"message":"Internal server error"}';
        String json='{"document": "892115012-1","ESTADO": "N","NIVEL_RIESGO": "","CANAL_VINCULACION": "","PROPOSITO_CR": "a","ORIGEN_FONDO": "a","PAIS_FONDO": "a","POLITICA_EXPUESTA": "S","EXTRECHO_COLABORADOR_PEP": "a","FAM_POLITICA_EXPUESTA": "N","NOM_FAM_POLITCA_EXPUESTA": "","ESTADO_SALUD": "a"}';
        FormPep pep = new FormPep('JA_01_547376',json);
        list<FormPep> FPep = new list<FormPep>();
        FPep.add(pep);
        String endPoint = Endpoint__mdt.getInstance('Form_PEP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        Calificacion.FormularioPep('JA',json);
        FormPep.GuardarPEP(FPep);
    }

    @IsTest static void formPepTest200() {

        String body = '{"success":true,"message":"OK"}';
        String json='{"document": "892115012-1","ESTADO": "N","NIVEL_RIESGO": "","CANAL_VINCULACION": "","PROPOSITO_CR": "a","ORIGEN_FONDO": "a","PAIS_FONDO": "a","POLITICA_EXPUESTA": "S","EXTRECHO_COLABORADOR_PEP": "a","FAM_POLITICA_EXPUESTA": "N","NOM_FAM_POLITCA_EXPUESTA": "","ESTADO_SALUD": "a"}';
        String endPoint = Endpoint__mdt.getInstance('Form_PEP').URL__c;
        FormPep pep = new FormPep('JA_01_547376',json);
        list<FormPep> FPep = new list<FormPep>();
        FPep.add(pep);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.FormularioPep('JA',json);
        FormPep.GuardarPEP(FPep);
    }

    @IsTest static void formPepTestFalse200() {

        String body = '{"success":false,"message":"OK"}';
        String json='{"document": "892115012-1","ESTADO": "N","NIVEL_RIESGO": "","CANAL_VINCULACION": "","PROPOSITO_CR": "a","ORIGEN_FONDO": "a","PAIS_FONDO": "a","POLITICA_EXPUESTA": "S","EXTRECHO_COLABORADOR_PEP": "a","FAM_POLITICA_EXPUESTA": "N","NOM_FAM_POLITCA_EXPUESTA": "","ESTADO_SALUD": "a"}';
        String endPoint = Endpoint__mdt.getInstance('Form_PEP').URL__c;
        FormPep pep = new FormPep('JA_01_547376',json);
        list<FormPep> FPep = new list<FormPep>();
        FPep.add(pep);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.FormularioPep('JA',json);
        FormPep.GuardarPEP(FPep);
    }

    @IsTest static void formPepTest500() {

        String body = '{"success":true,"message":"OK"}';
        String json='{"document": "892115012-1","ESTADO": "N","NIVEL_RIESGO": "","CANAL_VINCULACION": "","PROPOSITO_CR": "a","ORIGEN_FONDO": "a","PAIS_FONDO": "a","POLITICA_EXPUESTA": "S","EXTRECHO_COLABORADOR_PEP": "a","FAM_POLITICA_EXPUESTA": "N","NOM_FAM_POLITCA_EXPUESTA": "","ESTADO_SALUD": "a"}';
        String endPoint = Endpoint__mdt.getInstance('Form_PEP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        Calificacion.FormularioPep('JA',json);
    }

    @IsTest static void otrosIngresosTest400() {

        String body = '{"message":"Internal server error"}';
        String json='{"OTROS_INGRESOS": 5000000,"COD_OCU2": "d","ACTIVIDAD_NEGOCIO2": "Breiner","AGE_EST": "01", "COD_EST": "1555629","DOCUMENT": "1129514335"}';
        String endPoint = Endpoint__mdt.getInstance('OtrosIngresosCP').URL__c;
        otrosIngresosCapacidadPago  Cpg= new otrosIngresosCapacidadPago('JA_01_547376','05',500000,'INDEPENDIENTE','1129514335');
        list<otrosIngresosCapacidadPago> OIC = new list<otrosIngresosCapacidadPago>();
        OIC.add(Cpg);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(400,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(400, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPagoOtrosIngresos('JA', 5000000, 'D', 'Independiente', '01', '1555629', '1129514335');
        otrosIngresosCapacidadPago.consultarCapacidadPago(OIC);
        
    }

    @IsTest static void otrosIngresosTest200() {
        
        otrosIngresosCapacidadPago Cpg = new otrosIngresosCapacidadPago('JA_01_547376','05',500000,'INDEPENDIENTE','1129514335');
        list<otrosIngresosCapacidadPago> OIC = new list<otrosIngresosCapacidadPago>();
        OIC.add(Cpg);
        String body = '{"success":true,"message":"OK"}';
        String json='{"OTROS_INGRESOS": 5000000,"COD_OCU2": "d","ACTIVIDAD_NEGOCIO2": "Breiner","AGE_EST": "01", "COD_EST": "1555629","DOCUMENT": "1129514335"}';
        String endPoint = Endpoint__mdt.getInstance('OtrosIngresosCP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPagoOtrosIngresos('JA', 5000000, 'D', 'Independiente', '01', '1555629', '1129514335');
        otrosIngresosCapacidadPago.consultarCapacidadPago(OIC);
    }

    @IsTest static void OtrosIngresosFalseTest200() {
        
        otrosIngresosCapacidadPago Cpg = new otrosIngresosCapacidadPago('JA_01_547376','05',500000,'INDEPENDIENTE','1129514335');
        list<otrosIngresosCapacidadPago> OIC = new list<otrosIngresosCapacidadPago>();
        OIC.add(Cpg);
        String body = '{"success":false,"message":"OK"}';
        String json='{"OTROS_INGRESOS": 5000000,"COD_OCU2": "d","ACTIVIDAD_NEGOCIO2": "Breiner","AGE_EST": "01", "COD_EST": "1555629","DOCUMENT": "1129514335"}';
        String endPoint = Endpoint__mdt.getInstance('OtrosIngresosCP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPagoOtrosIngresos('JA', 5000000, 'D', 'Independiente', '01', '1555629', '1129514335');
        otrosIngresosCapacidadPago.consultarCapacidadPago(OIC);
    }

    @IsTest static void otrosIngresosTest500() {

        String body = '{"message":"Internal server error"}';
        String json='{"OTROS_INGRESOS": 5000000,"COD_OCU2": "d","ACTIVIDAD_NEGOCIO2": "Breiner","AGE_EST": "01", "COD_EST": "1555629","DOCUMENT": "1129514335"}';
        String endPoint = Endpoint__mdt.getInstance('OtrosIngresosCP').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(500,body));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint,json,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(500, response.getStatusCode());
        Test.stopTest();
        Calificacion.CapacidadPagoOtrosIngresos('JA', 5000000, 'D', 'Independiente', '01', '1555629', '1129514335');
    }

    @IsTest static void otrosIngresosfail(){
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
           
            Calificacion.CapacidadPagoOtrosIngresos('JA', 500000, 'D', 'Independiente', '01', '1555629', '1129514335');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
     }
    }

    @IsTest static void accionSugeridafail(){
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
            Calificacion.AccionSugerida('JA','01','547376','22398310','asecre4C');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
    }

    @IsTest static void formPepfail(){
        String json='{"document": "892115012-1","ESTADO": "N","NIVEL_RIESGO": "","CANAL_VINCULACION": "","PROPOSITO_CR": "a","ORIGEN_FONDO": "a","PAIS_FONDO": "a","POLITICA_EXPUESTA": "S","EXTRECHO_COLABORADOR_PEP": "a","FAM_POLITICA_EXPUESTA": "N","NOM_FAM_POLITCA_EXPUESTA": "","ESTADO_SALUD": "a"}';
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
            Calificacion.FormularioPep('JA',json);    

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();   
      }     
    }

    @IsTest static void capacidadPagofail(){
        
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
            Calificacion.CapacidadPago('JA', '01', '3855467', '1000111222', '1000111222', 'asecre4C');

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
    }
    }



}