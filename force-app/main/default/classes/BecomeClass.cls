/*************************************************************************
Nombre de la Clase: BecomeClass
Versión : 1.0
Fecha de Creación :  15 Marzo de 2023
Funcionalidad:  Validar el autorizador devolviendo un mensaje de respuesta.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié     15/03/2023       Versión Original
*************************************************************************/

public with sharing class BecomeClass {
    public String empresa;
    public String identificacion;
    public String accion;
    
    public static string Become(String empresa, String identificacion, String accion){
                                         
                                    String body = '';
                                    String url = Endpoint__mdt.getInstance('EnviarBecome').URL__c;
                                    String Endpoint = Url + empresa + '/' + identificacion + '/' + accion + '/become/ProValidacionIdentidad';
                                    list <String> Answerx= new list<String>();
                                    list <String> value = new list<String>();
                                    try{
                                        Map<String, Object> objson = new Map<String, Object> ();
                                        objson.put('empresa', empresa);
                                        objson.put('n_ide',identificacion);
                                        objson.put('accion',accion);                                        
                                        
                                        body = String.valueOf(JSON.Serialize(objson));
                                        System.debug(body);
                                        String metodo = 'GET';
                                        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                        Answerx.add(response.getBody());
                                        String data = Answerx[0];
                                        Integer codigo = response.getStatusCode();
                                        if(codigo == 200){
                                            return data;
                                        }else{
                                            Log__c log = new Log__c();
                                            log.ClassName__c = 'Become';
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
                                        log.ClassName__c = 'Become';
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