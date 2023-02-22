/*************************************************************************
Nombre de la Clase: Autorizador
Versión : 1.0
Fecha de Creación :  15 Diciembre 2022
Funcionalidad:  Validar el autorizador devolviendo un mensaje de respuesta.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié     15/12/2022       Versión Original
*************************************************************************/

public with sharing class AutorizadorClass {
    public String empresa;
    public String agenciaEst;
    public String estudio;
    public String agencia;
    public String periodoOP;
    public String numOP;
    public String programa;
    public String identificacion;
    
    
    public static string Autorizador(String empresa, String agenciaEst, String estudio, String agencia, String periodoOP, String numOP, String programa, String identificacion, String usuario, String proceso){
                                         
                                    String body = '';
                                    String url = Endpoint__mdt.getInstance('EnviarAutorizador').URL__c;
                                    String Endpoint = Url + empresa;
                                    list <String> Answerx= new list<String>();
                                    list <String> value = new list<String>();
                                    try{
                                        Map<String, Object> objson = new Map<String, Object> ();
                                        objson.put('pe_vcEmpresa', empresa);
                                        objson.put('pe_vcAge_est',agenciaEst);
                                        objson.put('pe_vcc_est',estudio);
                                        objson.put('pe_vcPerOp', periodoOP);
                                        objson.put('pe_vcNumOp', numOP);
                                        objson.put('pe_vcPrograma', programa);
                                        objson.put('pe_vcN_ide', identificacion);
                                        objson.put('pe_vcAgeOp', agencia);
                                        objson.put('pe_vcUsuario', usuario);
                                        objson.put('pe_vcProceso', proceso);
                                        
                                        
                                        body = String.valueOf(JSON.Serialize(objson));
                                        System.debug(body);
                                        String metodo = 'POST';
                                        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                        Answerx.add(response.getBody());
                                        String data = Answerx[0];
                                        Integer codigo = response.getStatusCode();
                                        if(codigo == 200){
                                            return data;
                                        }else{
                                            Log__c log = new Log__c();
                                            log.ClassName__c = 'Autorizador';
                                            log.date__c = Datetime.now();
                                            log.message__c = 'Error en consumo AWS: ' + data;
                                            log.success__c = false;
                                            log.type__c = 'Consumo en ws';
                                            log.JSON__c = body;
                                            if (empresa == 'JA') {
                                                log.Empresa__c = 'Colombia';
                                            }
                                            insert log;
                                            return 'Error en el consumo';
                                        }
                                        
                                    }catch(Exception e){
                                        Log__c log = new Log__c();
                                        log.ClassName__c = 'Autorizador';
                                        log.date__c = Datetime.now();
                                        log.message__c = 'Error en consumo AWS: ' + e.getMessage();
                                        log.success__c = false;
                                        log.type__c = 'Consumo en ws';
                                        log.JSON__c = body;
                                        if (empresa == 'JA') {
                                            log.Empresa__c = 'Colombia';
                                        }
                                        insert log;
                                        return 'Error en el consumo';
            
        }
                                        

    }
}