/*************************************************************************
Nombre de la Clase: ProcesoFirma
Versión : 1.0
Fecha de Creación : 15 Diciembre 2022
Funcionalidad: Contiene los metodos para el proceso de Firmas de credito de un cliente. Se realizan llamados
                a los servicios que continen los procedimientos que albergan la logica de negocio.
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Jorge Castro       15/12/2022       Versión Original
* Jorge Castro       29/12/2022       Agregamos proceso de desmtarializacion
*************************************************************************/
public class ProcesoFirma {
	public String telefono;
    public String correo;
    public String cedula;
    public String pin; 
    public String empresa;
    //Desmaterializacion
    public String age_est;
    public String cod_est;
    public String cod_agr;
    public String periodo;
    public String rem;
    public String otp;
    public String usuario;
    public String agencia;
    public String estudioCod;
    public String identificacion;


    
    public static String EnviarOtp(String telefono, String correo, String cedula, String empresa){
        String body = '';
        String url = Endpoint__mdt.getInstance('EnviarOtp').URL__c;
        String Endpoint = Url + empresa + '/epik/OTP'; 
        list <String> Answerx= new list<String>();
        list <String> value = new list<String>();
        try{
            Map<String, Object> objson = new Map<String, Object> ();
                objson.put('mobile', telefono);
                objson.put('email', correo);
                objson.put('otpId', cedula);
                objson.put('proceso', 'D');
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
                    log.ClassName__c = 'Enviar_OTP';
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
                log.ClassName__c = 'Enviar_OTP';
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
    public static String ValidarOtp(String cedula, String pin, String empresa){
        String body = '';
        String url = Endpoint__mdt.getInstance('ValidarOTP').URL__c;
        String Endpoint = Url + empresa + '/aldeamos/validateOtp?otpId=' + cedula + '&pin=' + pin + '&proceso=D'; 
        list <String> Answerx= new list<String>();
        list <String> value = new list<String>();
        try{
            Map<String, Object> objson = new Map<String, Object> ();
                objson.put('otpId', cedula);
                objson.put('pin', pin);
                objson.put('proceso', 'D');
                objson.put('c_emp', empresa);
                body = String.valueOf(JSON.Serialize(objson));
                String metodo = 'GET';
                HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(Endpoint, body, metodo,'25000');
                Answerx.add(response.getBody());
                String data = Answerx[0];
                Integer codigo = response.getStatusCode();
                if(codigo == 200){
                    return data;
                }else {
                    Log__c log = new Log__c();
                    log.ClassName__c = 'Validar_Otp';
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
                log.ClassName__c = 'Validar_Otp';
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
    public static String Desmaterializacion(String age_est , String cod_est , String cod_agr, String periodo, String rem, String cedula, String otp, String usuario, String empresa ){
        String body = '';
        String url = Endpoint__mdt.getInstance('Desmaterializacion').URL__c;
        String Endpoint = Url + empresa + '/epik/desmaterializar/quick' ; 
        list <String> Answerx= new list<String>();
        list <String> value = new list<String>();
        try{
            Map<String, Object> objson = new Map<String, Object> ();
            objson.put('age_est',age_est);
            objson.put('c_est',cod_est);
            objson.put('c_agr',cod_agr);
            objson.put('per',periodo);
            objson.put('rem',rem);
            objson.put('cedula',cedula);
            objson.put('otp',otp);
            objson.put('usu',usuario);
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
                    log.ClassName__c = 'Desmaterializacion';
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
        }catch(Exception e) {
                Log__c log = new Log__c();
                log.ClassName__c = 'Desmaterializacion';
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
    
    public static string validarFirmas(String empresa, String agencia, String estudioCod, String identificacion){
        String body = ' ';
        String url = Endpoint__mdt.getInstance('validarFirmas').URL__c;
        String Endpoint = Url + empresa + '/' + agencia + '/' + estudioCod + '/' + identificacion;
        System.debug(Endpoint);
        list <String> Answerx= new list<String>();
        list <String> value = new list<String>();
        try{
            String metodo = 'GET';
            System.debug('LINEA 212');
            system.debug('body:'+ body + 'metodo: ' + metodo);
            HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(Endpoint, body, metodo);
            System.debug(response);
            System.debug('LINEA 214');
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Integer codigo = response.getStatusCode();
            if(codigo == 200){
                System.debug(data);
                return data;
            }else {
                Log__c log = new Log__c();
                log.ClassName__c = 'validarFirmas';
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
            log.ClassName__c = 'validarFirmas';
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