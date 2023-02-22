/*************************************************************************
Nombre de la Clase: Calificacion
Versión : 1.0
Fecha de Creación :  17 Noviembre 2022
Funcionalidad: Contiene los metodos para el proceso de calificacion de credito de un cliente. Se realizan llamados
                a los servicios que continen los procedimientos que albergan la logica de negocio.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       17/11/2022       Versión Original
*************************************************************************/

public with sharing class Calificacion {

    public String empresa; // CP
    public String agencia; 
    public String estudio;
    public String identificacion;
    public String identificacionMiembro;
    public String usuario;
 
    public Calificacion(){}
    
    public static String AccionSugerida(String empresa, String agencia, String estudio, String identificacion,String Usuario){
                                            String body = '';
                                            String url = Endpoint__mdt.getInstance('AccionSugerida').URL__c; //custom metadata type
                                            String Endpoint = Url + empresa; //no quemar string
                                            list <String> Answerx= new list<String>();
                                            list <String> value = new list<String>();
                                            try {
                                                Map<String, Object> objson = new Map<String, Object> ();
                                                objson.put('emp', empresa);
                                                objson.put('Agr', agencia);
                                                objson.put('Est', estudio);
                                                objson.put('Ide', identificacion);
                                                objson.put('CalcularLectura','SI');
                                                objson.put('Usuario', usuario);
                                                objson.put('UsuSimulador',usuario);
                                                objson.put('Programa','SALESFORCE'); 
                                                body = String.valueOf(JSON.Serialize(objson));
                                                String metodo = 'POST';
                                                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                                Answerx.add(response.getBody());
                                                String data = Answerx[0];
                                                Integer codigo = response.getStatusCode();
                                                if(codigo == 200){
                                                    return data;
                                                }else {
                                                    Log__c log = new Log__c();
                                                    log.ClassName__c = 'Accion_Sugerida';
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
                                                
                                            } catch(Exception e) {
                                                Log__c log = new Log__c();
                                                log.ClassName__c = 'Accion_Sugerida';
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
    
    public static string CapacidadPago(String empresa,String agencia,String estudio,String identificacion, 
                                            String identificacionMiembro,String usuario){
                                            String body = '';
                                            String url = Endpoint__mdt.getInstance('CapacidadPago').URL__c;
                                            String Endpoint = Url + empresa; 
                                            list <String> Answerx= new list<String>();
                                            list <String> value = new list<String>();
                                            try{
                                                Map<String, Object> objson = new Map<String, Object> ();
                                                objson.put('Empresa', empresa);
                                                objson.put('age_est', agencia);
                                                objson.put('cod_est', estudio);
                                                objson.put('titular',identificacion);
                                                objson.put('miembro', identificacionMiembro);
                                                objson.put('excluir_op','N');
                                                objson.put('nun_decimales','-2');
                                                objson.put('programa','SALESFORCE'); 
                                                objson.put('usuario',usuario); 
                                                body = String.valueOf(JSON.Serialize(objson));
                                                system.debug(body);
                                                String metodo = 'POST';
                                                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                                Answerx.add(response.getBody());
                                                String data = Answerx[0];
                                                system.debug(data);
                                                Integer codigo = response.getStatusCode();
                                                if(codigo == 200){
                                                    return data;
                                                }else {
                                                    Log__c log = new Log__c();
                                                    log.ClassName__c = 'Capacidad_Pago';
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
                                                log.ClassName__c = 'Capacidad_Pago';
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
        //return null;
    }

    public static string FormularioPep(String empresa, String json){
                                            list <String> Answerx= new list<String>();
                                            String url = Endpoint__mdt.getInstance('Form_PEP').URL__c;
                                            String Endpoint = Url + empresa;
                                            String metodo = 'POST';
                                            try{
                                                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, json, metodo,'25000');
                                                Answerx.add(response.getBody());
                                                String data = Answerx[0];
                                                Integer codigo = response.getStatusCode();
                                                if(codigo == 200){
                                                    return data;
                                                }else {
                                                    Log__c log = new Log__c();
                                                    log.ClassName__c = 'Capacidad_Pago';
                                                    log.date__c = Datetime.now();
                                                    log.message__c = 'Error en consumo AWS: ' + data;
                                                    log.success__c = false;
                                                    log.type__c = 'Consumo en ws';
                                                    log.JSON__c = json;
                                                    if (empresa == 'JA') {
                                                        log.Empresa__c = 'Colombia';
                                                    }
                                                    insert log;
                                                    return 'Error en el consumo';
                                                }
                                            }catch(Exception e){
                                                Log__c log = new Log__c();
                                                log.ClassName__c = 'Capacidad_Pago';
                                                log.date__c = Datetime.now();
                                                log.message__c = 'Error en consumo AWS: ' + e.getMessage();
                                                log.success__c = false;
                                                log.type__c = 'Consumo en ws';
                                                log.JSON__c = json;
                                                if (empresa == 'JA') {
                                                    log.Empresa__c = 'Colombia';
                                                }
                                                insert log;
                                                return 'Error en el consumo';
                                            }
    }

    public static string CapacidadPagoOtrosIngresos(String empresa,Integer otrosIngresos,String codigoOcupacion, String actividadNegocio,
                                                        String agenciaEstudio, String cod_Estudio, String identificacion){
                                                            String body = '';
                                                            String url = Endpoint__mdt.getInstance('OtrosIngresosCP').URL__c;
                                                            String Endpoint = Url + empresa; 
                                                            list <String> Answerx= new list<String>();
                                                            list <String> value = new list<String>();
                                                            try{
                                                                Map<String, Object> objson = new Map<String, Object> ();
                                                                objson.put('OTROS_INGRESOS', otrosIngresos);
                                                                objson.put('COD_OCU2', codigoOcupacion);
                                                                objson.put('ACTIVIDAD_NEGOCIO2', actividadNegocio);
                                                                objson.put('AGE_EST',agenciaEstudio);
                                                                objson.put('COD_EST', cod_Estudio);
                                                                objson.put('DOCUMENT',identificacion);
                                                                body = String.valueOf(JSON.Serialize(objson));
                                                                System.debug(body);
                                                                String metodo = 'POST';
                                                                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                                                                Answerx.add(response.getBody());
                                                                String data = Answerx[0];
                                                                Integer codigo = response.getStatusCode();
                                                                if(codigo == 200){
                                                                    return data;
                                                                }else {
                                                                    Log__c log = new Log__c();
                                                                    log.ClassName__c = 'Capacidad_Pago';
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
                                                                log.ClassName__c = 'Capacidad_Pago';
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