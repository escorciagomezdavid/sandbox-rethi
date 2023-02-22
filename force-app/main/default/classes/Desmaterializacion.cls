/*************************************************************************
Nombre de la Clase: Desmaterializacion
Versión : 1.0
Fecha de Creación :  29 Diciembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de enviar OTP.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Jorge Castro       15/12/2022       Versión Original
*************************************************************************/
public with sharing class Desmaterializacion {
 
    @invocablevariable(Label = 'idEstudio' required = true) //empresa, agencia del estudio, codigo del estudio
	public string idEstudio;
    @invocablevariable(Label = 'idOp' required = true) //Empresa, agencia de la Op, periodo, Rem
	public string idOp;
    @invocablevariable(Label = 'cedula' required = true)
	public string cedula;
    @invocablevariable(Label = 'otp' required = true)
	public string otp;
    @invocablevariable(Label = 'usuario' required = true)
	public string usuario;

    
    public Desmaterializacion(){}
    public Desmaterializacion(String idEstudio, String idOp, String cedula, String otp, String usuario){
        this.idEstudio=idEstudio;
        this.idOp=idOp;  
        this.cedula=cedula;
        this.otp=otp;
        this.usuario=usuario;
    }
    @InvocableMethod (label='Desmaterializacion')
    public static List<responseDMT> Desmaterializacion(list<Desmaterializacion> DMT){
 
        String cedula = DMT[0].cedula; 
        String otp = DMT[0].otp; 
        String usuario = DMT[0].usuario;
        String idEstudio = DMT[0].idEstudio;
        String idOp = DMT[0].idOp;
        List<responseDMT> rp = new List<responseDMT>();
        responseDMT response = new responseDMT();
                
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String age_est = datosEstudio[1];
        String cod_est = datosEstudio[2];
        
        List<String> datosOp = new List<String> ();
        for (String op : idOp.split('_')) {
			datosOp.add(op);
		}
        String cod_agr= datosOp[1];
        String periodo = datosOp[2];
        String rem = datosOp[3];
        
        String data = ProcesoFirma.Desmaterializacion(age_est, cod_est, cod_agr, periodo, rem, cedula, otp, usuario, empresa);
        if(data != 'Error en el consumo'){
            	
            	Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
                String ps_vcResultado = String.valueOf(jsonParsed.get('ps_vcResultado'));
                String ps_vcResultMens = String.valueOf(jsonParsed.get('ps_vcResultMens'));
                Double ps_nuCodError = Double.valueOf(jsonParsed.get('ps_nuCodError'));
                String ps_vcMensError = String.valueOf(jsonParsed.get('ps_vcMensError'));
                
                if(ps_vcResultado == 'OK'){
                    
                    response.ps_vcResultado = ps_vcResultado;
                    response.ps_vcResultMens = ps_vcResultMens;
                    response.ps_nuCodError = ps_nuCodError;
                    response.ps_vcMensError = ps_vcMensError;
                    rp.add(response);
                    return rp;
                }else{
                    response.ps_vcResultado = 'ERROR';
                    response.ps_vcResultMens = ps_vcResultMens;
                    response.ps_nuCodError = ps_nuCodError;
                    response.ps_vcMensError = ps_vcMensError;
                    rp.add(response);
                    return rp;
                }
        }else{
                response.ps_vcResultado = 'Internal server error';
                return rp;
            }
    } 
    public class responseDMT{
        @invocablevariable(Label='Resultado' required=true)
        public String ps_vcResultado;
        @invocablevariable(Label='ResultMens' required=true)
        public String ps_vcResultMens;
        @invocablevariable(Label='Cod Error' required=true)
        public Double ps_nuCodError;
        @invocablevariable(Label='Mensaje Error' required=true)
        public String ps_vcMensError;
        
    }   
}