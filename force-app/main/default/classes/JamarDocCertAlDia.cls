public class JamarDocCertAlDia {
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

        
    	public JamarDocCertAlDia(){}
        public JamarDocCertAlDia(String empresa,String identificacion,
                                 String cuenta, String agencia, String tipoCredito){
            this.empresa = empresa;
            this.identificacion = identificacion;
            this.cuenta = cuenta;
            this.agencia = agencia;
            this.tipoCredito = tipoCredito; 
                       
            
        }
    
    	/**
    	 * Method Call to Flow
    	 * */
   	@InvocableMethod (label='Generacion Documento Certificado al Dia')
    public static list<String> GeneracionCertAlDia (list<JamarDocCertAlDia> JamarDocCertAlDia){

        	
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
            * */
           String empresa = JamarDocCertAlDia[0].empresa;
           String identificacion = JamarDocCertAlDia[0].identificacion;
           String cuenta = JamarDocCertAlDia[0].cuenta;
           String agencia = JamarDocCertAlDia[0].agencia;
           String tipoCredito = JamarDocCertAlDia[0].tipoCredito;
           String data = '';
           String url = '';
           String urldoc = '';
           String message = '';
            try {
                url ='https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+empresa+'/'+identificacion+'/'+agencia+'/'+cuenta+'/'+tipoCredito+'/AlDia';
                System.debug(url);
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(url);
                request.setMethod('GET');
                request.setHeader('Content-Type','application/json');
                request.setTimeout(25000);
                HttpResponse response = http.send(request);
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
            } catch(Exception e) {
                /**
                 * Creamos un Log para Tracer de Errores
                 * */
                value.add('SIN URL');
                Log__c log = new Log__c();
                log.ClassName__c = 'Cert_al_dia';
                log.date__c = Datetime.now();
                log.message__c = 'Error en consumo AWS: ' + e.getMessage();
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