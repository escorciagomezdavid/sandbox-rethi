/*************************************************************************
Nombre de la Clase: Enviar OTP
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
public with sharing class EnviarOtp {
    @invocablevariable(Label = 'telefono' required = true)
	public string telefono;
	@invocablevariable(Label = 'correo' required = true)
	public string correo;
    @invocablevariable(Label = 'cedula' required = true)
	public string cedula;
	@invocablevariable(Label = 'empresa' required = true)
	public string empresa;
    
    public EnviarOtp(){}
    public EnviarOtp(String telefono,String correo,String cedula,String  empresa){
        this.telefono = telefono; 
        this.correo=correo;
        this.cedula=cedula;
        this.empresa=empresa;    
    }
    @InvocableMethod (label='Enviar OTP')
    public static List<responseETP> EnviarOTP(list<EnviarOTP> ETP){
        String telefono = ETP[0].telefono;
        String correo = ETP[0].correo;
        String cedula = ETP[0].cedula;
        String empresa = ETP[0].empresa;
        //if (empresa =='JA'){
        //    telefono = telefono.replace('57','');
        //}else{
        //    telefono = telefono.replace('507','');
        //}
       
        List<responseETP> rp = new List<responseETP>();
        responseETP response = new responseETP();
        
        String data = ProcesoFirma.EnviarOTP(telefono, correo, cedula,empresa);
        
        if(data != 'Error en el consumo'){
            Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
                Double errorcode = Double.valueOf(jsonParsed.get('errorcode'));
                Boolean attempts_send_sms_otp = Boolean.valueOf(jsonParsed.get('attempts_send_sms_otp'));
            	System.debug(attempts_send_sms_otp);
             if(attempts_send_sms_otp != null){
                response.errorcode = errorcode;
                response.attempts_send_sms_otp = attempts_send_sms_otp;
                rp.add(response);
                return rp;
             }else{
                response.attempts_send_sms_otp = false;
                rp.add(response);
                return rp;
             }
       }else{
                response.attempts_send_sms_otp = false;
                rp.add(response);
                return rp;
       }
    }
    public class responseETP{
        @invocablevariable(Label='errorcode' required=true)
        public Double errorcode;
        @invocablevariable(Label='Mensaje de envio' required=true)
        public Boolean attempts_send_sms_otp;
    }   
}