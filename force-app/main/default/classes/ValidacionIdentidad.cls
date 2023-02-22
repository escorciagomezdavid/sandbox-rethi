/*************************************************************************
Nombre de la Clase: Validacion de identidad
Versión : 2.0
Fecha de Creación :  22 Noviembre 2022
Funcionalidad:  Registra los diferentes procesos de validacion de identidad en credito.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       22/11/2022       Versión Original
*************************************************************************/
public with sharing class ValidacionIdentidad {
    public String empresa;
    public String agenciaVendedor;
    public String nombreAsesor;
    public String tipoIdentificacion;
    public String identificacion;
    public String primerNombre;
    public String primerApellido;
    public String segundoApellido;
    public String fechaExpedicion;
    public String agencia;
    public String periodoOP;
    public String numOP;
    public String programa;
    public String agenciaEst;
    public String estudioCod;
    public Integer errorCod;
    public String msjError;
    public String resultado;

    public ValidacionIdentidad() {}

    public static String Evidente(String empresa, String agenciaVendedor, String nombreAsesor, String tipoIdentificacion,
                                String identificacion, String primerNombre, String primerApellido,
                                String segundoApellido, String fechaExpedicion){

                                String body = '';
                                String url = Endpoint__mdt.getInstance('Evidente').URL__c;
                                String Endpoint = Url + empresa+'/evidente/validate';
                                System.debug(Endpoint);
                                list <String> Answerx= new list<String>();
                                list <String> value = new list<String>();
                                System.debug(fechaExpedicion);
                                try{
                                    Map<String, Object> objson = new Map<String, Object> ();
                                                objson.put('c_agr', agenciaVendedor);
                                                objson.put('usuario', nombreAsesor);
                                                objson.put('origen', 'SALESFORCE');
                                                objson.put('usu_autenticacion', 72206494);
                                                objson.put('producto','07');
                                                objson.put('param_producto', 2305);
                                                objson.put('canal','001');
                                                objson.put('ident_tipo',tipoIdentificacion);
                                                objson.put('ident_numero',identificacion);
                                                objson.put('primer_nombre', primerNombre);
                                                objson.put('primer_apellido',primerApellido); 
                                                objson.put('segundo_apellido',segundoApellido);
                                                objson.put('fecha_exp_documento',fechaExpedicion);
                                                body = String.valueOf(JSON.Serialize(objson));
                                                System.debug(body);
                                                String metodo = 'POST';
                                                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                                Answerx.add(response.getBody());
                                                String data = Answerx[0];
                                                System.debug(data);
                                                Integer codigo = response.getStatusCode();
                                                if(codigo == 200){
                                                    return data;
                                                }else{
                                                    Log__c log = new Log__c();
                                                    log.ClassName__c = 'Evidente';
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
                                                log.ClassName__c = 'Evidente';
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
    
    public static string validarEvidente(String empresa, String identificacion){
                                         String body = '';
                                         String url = Endpoint__mdt.getInstance('ValidarEvidente').URL__c;
                                         String Endpoint = Url + identificacion + '/' + empresa; 
                                         list <String> Answerx= new list<String>();
                                         list <String> value = new list<String>();
                                         try{
                                             Map<String, Object> objson = new Map<String, Object> ();
                                             objson.put('c_emp', empresa);
                                             objson.put('ide', identificacion);
                                             
                                             body = String.valueOf(JSON.Serialize(objson));
                                             System.debug(body);
                                             String metodo = 'GET';
                                             HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                             Answerx.add(response.getBody());
                                             String data = Answerx[0];
                                             Integer codigo = response.getStatusCode();
                                             if(codigo == 200){
                                                 return data;
                                             }else {
                                                 Log__c log = new Log__c();
                                                 log.ClassName__c = 'validar_evidente';
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
                                             log.ClassName__c = 'validar_evidente';
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
    
    public static string validarHuella(String empresa, String agencia, String estudioCod, String identificacion){
                                         String body = '';
                                         String url = Endpoint__mdt.getInstance('validarHuella').URL__c;
                                         String Endpoint = Url + empresa + '/' + agencia + '/' + estudioCod + '/' + identificacion; 
                                         list <String> Answerx= new list<String>();
                                         list <String> value = new list<String>();
                                         try{
                                             Map<String, Object> objson = new Map<String, Object> ();
                                             objson.put('c_emp', empresa);
                                             objson.put('age_est', agencia);
                                             objson.put('cod_est', estudioCod);
                                             objson.put('ide', identificacion);
                                             
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
                                                 log.ClassName__c = 'validarHuella';
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
                                             log.ClassName__c = 'validarHuella';
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