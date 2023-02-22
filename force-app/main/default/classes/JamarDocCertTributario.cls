/*
Name: JamarDocCertTributario
Proposito: retornar la url del certificado tributario de un cliente.
Author: Daniela Sanchez
Fecha: 23/08/2021
*/
public class JamarDocCertTributario {
    /**
    * Attributes the class apex, exist Attributes common between class example Cuenta al dia
    * */
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    @invocablevariable(Label='ano' required=true)
    public string ano;
    @invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='agencia' required=true)
    public string agencia;
    @invocablevariable(Label='Cuenta' required=true)
    public string cuenta;
    @invocablevariable(Label='TipoCredito' required=true)
    public string TipoCredito;
    
    public JamarDocCertTributario(){}
    public JamarDocCertTributario(String identificacion, String ano,String empresas,String agencia,
                                  String cuenta, String TipoCredito){
                                      this.identificacion = identificacion;
                                      this.ano = ano;
                                      this.empresas = empresas;
                                      this.agencia = agencia;
                                      this.cuenta = cuenta;
                                      this.TipoCredito = TipoCredito;
                                      
                                  }
    /**
    * Method Call to Flow
    * */
    @InvocableMethod (label='Generacion Certificado Tributario')
    public static list<String> GeneracionCertificadoTributario (list<JamarDocCertTributario> JamarDocCertTributario){
        
        /**
        * this variable exist for return method Value ID
        * */
        list <String> value = new list<String>();
        /**
        * this variable exist for parsing response the service
        * */
         list <String> Answerx = new list<String>();
        
        String identificacion = JamarDocCertTributario[0].identificacion;
        String empresa = JamarDocCertTributario[0].empresas;
        String ano = JamarDocCertTributario[0].ano;
        String agencia = JamarDocCertTributario[0].agencia;
        String cuenta = JamarDocCertTributario[0].cuenta;
        String tipoCredito = JamarDocCertTributario[0].TipoCredito;
        
        try{
            String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+empresa+'/'+identificacion+'/'+agencia+'/'+cuenta+'/'+tipoCredito+'/'+ano+'/Declaracion';
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, null, 'GET', '25000');
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
            String urldoc = String.valueOf(jsonParsed.get('documento'));
            String message = String.valueOf(jsonParsed.get('mensaje'));
            if(message == null){
                 value.add(urldoc);
            }else{
                 value.add(message);
            }            
            return value;            
        }catch(Exception e){
            /**
            * Creamos un Log para capturar los Errores
            * */
            value.add('SIN URL');
            Log__c log = new Log__c();
            log.ClassName__c = 'Cert_tributario';
            log.date__c = Datetime.now();
            log.message__c = 'Error en ws: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = '';
            if(empresa == 'JA'){
                log.Empresa__c = 'Colombia';
            }
            insert log;
        }
        return value;
    }
    
}