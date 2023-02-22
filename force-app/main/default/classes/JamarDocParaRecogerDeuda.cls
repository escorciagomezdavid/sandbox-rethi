public class JamarDocParaRecogerDeuda {
    @invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    @invocablevariable(Label='agencia' required=true)
    public string agencia;
    @invocablevariable(Label='tipoCredito' required=true)
    public string tipoCredito;
    @invocablevariable(Label='cuenta' required=true)
    public string cuenta;  
    @invocablevariable(Label='factura')
    public string factura;
    
    public JamarDocParaRecogerDeuda(){}
    public JamarDocParaRecogerDeuda(String empresas, String identificacion, String agencia,
                                    String tipoCredito, String cuenta, String factura){
                                        this.empresas = empresas;
                                        this.identificacion = identificacion;
                                        this.agencia = agencia;
                                        this.tipoCredito = tipoCredito;
                                        this.cuenta = cuenta;
                                        this.factura = factura;
                                    }
    
    /**
* Method Call to Flow
* */
    @InvocableMethod (label='Generacion Certificado para Recoger Deuda')
    public static list<String> GeneracionCertificadoParaRecogerDeuda (list<JamarDocParaRecogerDeuda> JamarDocParaRecogerDeuda){
        /**
* this variable exist for return method Value ID
* */
        list <String> value = new list<String>();
        String identificacion = JamarDocParaRecogerDeuda[0].identificacion;
        String empresa = JamarDocParaRecogerDeuda[0].empresas;
        String cuenta = JamarDocParaRecogerDeuda[0].cuenta;
        String factura = JamarDocParaRecogerDeuda[0].factura;
        String tipoCredito = JamarDocParaRecogerDeuda[0].tipoCredito;
        String agencia = JamarDocParaRecogerDeuda[0].agencia;
        String tipoCertificado = 'L';
        String urls = '';
        
        try{
            String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+empresa+'/'+identificacion+'/'+agencia+'/'+cuenta+'/'+tipoCredito+'/cartaSaldo';
            list <String> Answerx = new list<String>();
            list <String> IdValue = new list<String>();
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
            request.setTimeout(25000);
            HttpResponse response = http.send(request);
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            System.debug(jsonParseds);
            urls = String.valueOf(jsonParseds.get('url'));
            if(urls==null){
                value.add('SIN URL');
                return value;
            }else{
                value.add(urls);
            }
            //System.debug(urls);
            return value;                       
        }catch(Exception e){
            value.add('SIN URL');
            Log__c log = new Log__c();
            log.ClassName__c = 'Certificado Pra Recoger Deuda';
            log.date__c = Datetime.now();
            log.message__c = 'Error en ws: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = urls;
            if(empresa == 'JA'){
                log.Empresa__c = 'Colombia';
            }
            insert log;
        }
        
        return value;
    }
    
    
}