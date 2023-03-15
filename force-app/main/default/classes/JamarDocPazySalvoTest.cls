@isTest
public class JamarDocPazySalvoTest {   
    
        @invocablevariable(Label='Empresa' required=true)
        public string empresa;
        @invocablevariable(Label='Identificacion' required=true)
        public string identificacion;
        @invocablevariable(Label='cuenta' required=true)
        public string cuenta;  
        @invocablevariable(Label='agencia' required=true)
        public string agencia;
        @invocablevariable(Label='tipo_credito' required=true)
        public string tipoCredito;
 
    

    

    
     @IsTest static void JamarDocPazySalvoTest () {
            list <String> AnswerxToken = new list<String>();    
            String method= ''; 
            String Urltokens ='';
            String datatoken = '';
            
    

        JamarDocPazySalvo valFirm = new JamarDocPazySalvo('JA','26139520','A3', '18471', 'TJ');
        list<JamarDocPazySalvo> Doc = new list<JamarDocPazySalvo>();
        Doc.add(valFirm);

        String body = '{"documento": "https://jamar-pdf-dev.s3.amazonaws.com/historia_credito/aldia-155102.pdf"}';
        String endPoint = Endpoint__mdt.getInstance('Documentos').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMock(200,body));
        Map<String, Object> objson = new Map<String, Object>();
            objson.put('usuario','CIEL');
            objson.put('contrasena','CIEL2021*');
            body = String.valueOf(JSON.Serialize(objson));
            System.debug(body);
            HttpResponse responseConsultaEndpoint = JamarConsumoHTTP.callServiceExternalWithTimeOut(Urltokens, body, method,'25000');
            Integer codigo = responseConsultaEndpoint.getStatusCode();
            AnswerxToken.add(responseConsultaEndpoint.getBody());
            datatoken = AnswerxToken[0];
            System.debug(datatoken);
            Map<String, Object> jsonToken = (Map<String, Object>) JSON.deserializeUntyped(datatoken);
                String token = String.ValueOf(jsonToken.get('access_token'));    
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithToken(Endpoint, '', 'GET', token);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = body;
        System.assertEquals(200, response.getStatusCode());
        Test.stopTest();
        JamarDocPazySalvo.GeneracionPazySalvo(Doc);
    }
    
      @IsTest static void JamarDocPazySalvoFail(){
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
            JamarDocPazySalvo valFirm = new JamarDocPazySalvo('JA','26139520','A3', '18471', 'TJ');
            list<JamarDocPazySalvo> Doc = new list<JamarDocPazySalvo>();
            Doc.add(valFirm);
           
            JamarDocPazySalvo.GeneracionPazySalvo(Doc);

        }catch(DmlException ex){
            System.assertEquals('Insert failed. First exception on row 0; first error: OP_WITH_INVALID_USER_TYPE_EXCEPTION, Operation not valid for this user type: []', ex.getMessage());
        }        
        Test.stopTest();
        }
    
    } 
}