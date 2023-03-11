/*************************************************************************
Nombre de la Clase: Validar Otp
Versión : 1.0
Fecha de Creación :  15 Diciembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de enviar OTP.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Jorge Castro       15/12/2022       Versión Original
*************************************************************************/
public with sharing class ValidarOtp {
    @invocablevariable(Label = 'cedula' required = true)
    public string cedula;
    @invocablevariable(Label = 'pin' required = true)
    public string pin;
    @invocablevariable(Label = 'empresa' required = true)
    public string empresa;
    
    public validarOtp(){}
    public ValidarOtp(String cedula,String pin,String empresa){
        this.cedula=cedula; 
        this.pin=pin;
        this.empresa=empresa;    
    }
    @InvocableMethod (label='Validar OTP')
    public static List<responseVTP> ValidarOTP(list<ValidarOTP> VTP){
        String cedula = VTP[0].cedula;
        String pin = VTP[0].pin;  
        String empresa = VTP[0].empresa; 
        List<responseVTP> rp = new List<responseVTP>();
        responseVTP response = new responseVTP();
        
        String data = ProcesoFirma.ValidarOtp(cedula, pin, empresa);
        
        if(data != 'Error en el consumo'){
            Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
            Boolean success = Boolean.valueOf(jsonParsed.get('message'));
             if(success != null ){
                response.message = success;
                rp.add(response);
                return rp;
             }else{
                response.message = false;
                rp.add(response);
                return rp;
             }
        }else{
               response.message = false;
               rp.add(response);
               return rp;
        }    
       
    }
    public class responseVTP{
        @invocablevariable(Label='message' required=true)
        public Boolean message;
     
    }   
}