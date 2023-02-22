/*
Name: JamarDocExtractoMeses
Proposito: retornar los meses disponibles para poder generar el extracto de acuerdo a lo que esta en las tacticas.
Author: Daniela Sanchez
Fecha: 14/03/2022
*/
public class JamarDocExtractoMeses {
    @invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    public JamarDocExtractoMeses(){}
    public JamarDocExtractoMeses(String empresas, String identificacion){
        this.empresas= empresas;
        this.identificacion=identificacion;
    }
    /**
* Method Call to Flow
* */
    @InvocableMethod (label='Meses para tomar extracto')
    public static list<Respuesta> MesesExtractos (list<JamarDocExtractoMeses> Meses){
        System.debug(Meses);
        String empresa  = Meses[0].empresas;
        String identificacion = Meses[0].identificacion;  
        String concatMes = '';
        list <Respuesta> value = new list<Respuesta>();
        Respuesta rp = new Respuesta();
        try{
            String url = 'https://59o1es3b63.execute-api.us-east-1.amazonaws.com/api/v1/JA/users/xx/sumaries?NoIdentificacion='+identificacion;
            list <String> Answerx = new list<String>();
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url,'','GET','25000');
            response.getBody();
            Answerx.add(response.getBody());
            String data = Answerx[0];
            //Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            List<JamarInterfaceExtractoMeses> Lista = new list<JamarInterfaceExtractoMeses>();
            Lista = JamarInterfaceExtractoMeses.parse(data);
            for(Integer i=0; i <Lista.size(); i++ ){               
                String ano = Lista[i].month.substringAfter('/');
                String numeroMes = Lista[i].month.substringBefore('/');
                String fechaformat = ano + '-' + numeroMes;
                concatMes = concatMes+';'+ fechaformat;               
            }
            String mes = concatMes.substring(1);  
            rp.mesExtracto = mes;
            value.add(rp);
            return value;
        }catch(Exception e){
            rp.mesExtracto = 'Sin Datos';
            value.add(rp);
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
    
    public class Respuesta{
        @invocablevariable(Label='Extracto Meses' required=true)
        public String mesExtracto;
    }
    
}