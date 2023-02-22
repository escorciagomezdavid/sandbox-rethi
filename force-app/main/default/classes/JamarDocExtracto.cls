/*
Name: JamarDocCertExtracto
Proposito: retornar la url del extracto del mes de un cliente.
Author: Daniela Sanchez
Fecha: 23/08/2021
*/
public class JamarDocExtracto {
    
    @invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    @invocablevariable(Label='period')
    public string period;
    
    public JamarDocExtracto(){}
    public JamarDocExtracto(String empresas, String identificacion, String period){
        this.empresas = empresas;
        this.identificacion = identificacion;
        this.period = period;
    }
    /**
* Method Call to Flow
* */
    @InvocableMethod (label='Generacion de Extracto')
    public static list<String> GeneracionExtracto (list<JamarDocExtracto> JamarDocExtracto){
        list <String> value = new list<String>();
        
        String identificacion = JamarDocExtracto[0].identificacion;
        String empresa = JamarDocExtracto[0].empresas;
        String period = JamarDocExtracto[0].period;
        
        try{
            String  urls = extractUrls(identificacion, empresa, period);
            String urlright = urls.remove('(');
            String urlleft = urlright.remove(')');
            value.add(urlleft);
            
        }catch(Exception e){
            
            /**
* Creamos un Log para capturar los Errores
* */
            Log__c log = new Log__c();
            log.ClassName__c = 'Extracto';
            log.date__c = Datetime.now();
            log.message__c = 'Error en ws: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            //log.JSON__c = body;
            if(empresa == 'JA'){
                log.Empresa__c = 'Colombia';
            }
            insert log;
        }
        return value; 
    }
    
    public static String extractUrls(String identify, String company, String period){
        
        String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+company+'/extracto/' + identify +'/'+period;
        list <String> Answerx = new list<String>();
        HttpResponse response = JamarConsumoHTTP.callServiceExternal(url,null,'GET','25000');
        System.debug(response.getBody());
        Answerx.add(response.getBody());
        String data = Answerx[0];
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        String urls = String.valueOf(jsonParseds.get('url'));
        System.debug(urls);
        return urls;        
    }
    
}