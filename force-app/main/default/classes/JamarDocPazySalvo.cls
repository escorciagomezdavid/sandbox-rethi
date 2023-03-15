public class JamarDocPazySalvo {
    /**
* Attributes the class apex, exist Attributes common between class example Cuenta al dia
* */
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

    
    
    public JamarDocPazySalvo(){}
    public JamarDocPazySalvo (String empresa,String identificacion,
                              String cuenta, String agencia, String tipoCredito) {
                                  this.empresa = empresa;
                                  this.identificacion = identificacion;
                                  this.cuenta = cuenta;
                                  this.agencia = agencia;
                                  this.tipoCredito = tipoCredito;   
                              }
    
    /**
* Method Call to Flow
* */
    @InvocableMethod (label='Generacion Documento Paz y Salvo')
    public static list<String> GeneracionPazySalvo (list<JamarDocPazySalvo> JamarDocPazySalvo){
        
        /**
* this variable exist for parsing response the service
* */
        list <String> Answerx = new list<String>();
        
        /**
* this variable exist for return method Value ID
* */
        list <String> value = new list<String>();
        
        /**
* extract Values
* */    list <String> AnswerxToken = new list<String>();
        String empresa = JamarDocPazySalvo[0].empresa;
        String identificacion = JamarDocPazySalvo[0].identificacion;
        String cuenta = JamarDocPazySalvo[0].cuenta;
        String agencia = JamarDocPazySalvo[0].agencia;
        String tipoCredito = JamarDocPazySalvo[0].tipoCredito;
        String data = '';
        String url = '';
        String urldoc = '';
        String message = '';
        String Endpoint = '';
        String body = '';
        String datatoken = '';
        
        
        /**
* Make request Http to service WebLogic and return value 
* */     url = Endpoint__mdt.getInstance('Documentos').URL__c;
         Endpoint = url + empresa+'/'+identificacion+'/'+agencia+'/'+cuenta+'/'+tipoCredito+'/PazYSalvo';
        try{
            String Urltokens = Endpoint__mdt.getInstance('Tokens').URL__c;
            String method = 'POST';
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
            System.debug('access_token:  ' + token);
            System.debug(url);
            HttpResponse response = JamarConsumoHTTP.callServiceExternalWithToken(Endpoint, '', 'GET', token);
            Answerx.add(response.getBody());
            data = Answerx[0];
            Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
            urldoc = String.valueOf(jsonParsed.get('documento'));
            message = String.valueOf(jsonParsed.get('mensaje'));
            if(message == null){
                value.add(urldoc);
            }else{
                value.add(message);
            }
            return value;
            
        } catch(Exception e){
            /**
            * Creamos un Log para Tracer de Errores
            * */        
            value.add('SIN URL');
            Log__c log = new Log__c();
            log.ClassName__c = 'Cert_Paz_y_Salvo';
            log.date__c = Datetime.now();
            log.message__c = 'Error en el consumo de AWS: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = url;
            if(empresa == 'JA'){
                log.Empresa__c = 'Colombia';
            }
            insert log;
        }
        return value;     
    }
    
}