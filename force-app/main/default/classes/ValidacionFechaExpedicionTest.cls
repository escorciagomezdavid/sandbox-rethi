@IsTest
public with sharing class ValidacionFechaExpedicionTest {
    @invocablevariable(Label='Numero de identificación')
    public string identificacion;

    @invocablevariable(Label='Id Estudio')
    public String id_estudio;

    @InvocableVariable(Label='fecha de expedición del documento' required=True)
    public Datetime fecha_expedicion;
    
    public ValidacionFechaExpedicionTest(){
        this.identificacion='22398310';
        this.id_estudio='JA_01_547376';
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        this.fecha_expedicion=myDateTime;
    }
    @IsTest static void valFechaExpTest(){
        ValidarFechaDeExpedicion valFech = new ValidarFechaDeExpedicion();
        list<ValidarFechaDeExpedicion> vfe = new list<ValidarFechaDeExpedicion>();
        valFech.id_estudio='JA_01_547376';
        valFech.identificacion='22398310';
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        valFech.fecha_expedicion=myDateTime;
        vfe.add(valFech);
        String fecha = myDateTime.formatGmt('dd/MM/yyyy');
        Test.startTest();
        String body = '{"success":true,"data":{"accion_sugerida":"G1","segmento":"ORO","saldo_cartera":0.0,"total":0.0,"saldo":0.0,"cod_error":null,"mensj_error":null}}';
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        String url = Endpoint__mdt.getInstance('ValidacionExpedicion').URL__c+'JA';
        Map<String, Object> objson = new Map<String, Object>();
        objson.put('c_agr', '01');
        objson.put('c_est', '547376');
        objson.put('n_ide','22398310');
        objson.put('fecha_exp', fecha);
        String body2 = String.valueOf(JSON.serialize(objson));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(url, body2,'POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        ValidarFechaDeExpedicion.getFechaDeExpedicion(vfe);
    }

    @IsTest static void valFechaExpSinEstudioTest(){
        ValidarFechaDeExpedicion valFech = new ValidarFechaDeExpedicion();
        list<ValidarFechaDeExpedicion> vfe = new list<ValidarFechaDeExpedicion>();
        valFech.id_estudio='';
        valFech.identificacion='22398310';
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        valFech.fecha_expedicion=myDateTime;
        vfe.add(valFech);
        String fecha = myDateTime.formatGmt('dd/MM/yyyy');        
        ValidarFechaDeExpedicion.getFechaDeExpedicion(vfe);
    }

    @IsTest static void valFechaExpFailTest(){
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
            ValidarFechaDeExpedicion valFech = new ValidarFechaDeExpedicion();
            list<ValidarFechaDeExpedicion> vfe = new list<ValidarFechaDeExpedicion>();
            valFech.id_estudio='JA_01_547376';
            valFech.identificacion='22398310';
            Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
            valFech.fecha_expedicion=myDateTime;
            vfe.add(valFech);
        try{
            ValidarFechaDeExpedicion.getFechaDeExpedicion(vfe);

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
      }
    }
    
}