/*************************************************************************
Nombre de la Clase: Autorizador
Versión : 1.0
Fecha de Creación :  21 Noviembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de Autorizador.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié       21/12/2022       Versión Original
*************************************************************************/

public with sharing class EnviarAutorizador {

    @invocablevariable(Label = 'idEstudio' required = true) //empresa, agencia del estudio, codigo del estudio
	public string idEstudio;
	@invocablevariable(Label = 'idOp' required = true) //agencia de la Op
	public string idOp;
    @invocablevariable(Label = 'programa' required = true)
	public string programa;
    @invocablevariable(Label = 'identificacion' required = true)
	public string identificacion;
    @invocablevariable(Label = 'usuario' required = true)
	public string usuario;
    @invocablevariable(Label = 'proceso' required = false)
	public string proceso;

    public EnviarAutorizador() {}
    public EnviarAutorizador(String idEstudio, String idOp, String programa, String identificacion, String usuario, String proceso){
        this.idEstudio=idEstudio;
        this.idOp=idOp;      
        this.programa=programa;
        this.identificacion=identificacion; 
        this.usuario=usuario;
        this.proceso=proceso;
    }
    
    @InvocableMethod (label='Enviar Autorizador')
    public static List<responseAU> EnviarAutor(list<EnviarAutorizador> AU){
		String idEstudio = AU[0].idEstudio;
        String idOp = AU[0].idOp;
        String programa = AU[0].programa;
        String identificacion = AU[0].identificacion;   
        String usuario = AU[0].usuario;
        String proceso = AU[0].proceso;
        List<responseAU> rp = new List<responseAU>();
        responseAU response = new responseAU();
        
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String agenciaEst = datosEstudio[1];
        String estudio = datosEstudio[2];
        
        List<String> datosOp = new List<String> ();
        for (String op : idOp.split('_')) {
			datosOp.add(op);
		}
        String agencia= datosOp[1];
        String periodoOP = datosOp[2];
        String numOP = datosOp[3];
        
        String data = AutorizadorClass.Autorizador(empresa,agenciaEst,estudio,agencia,periodoOP,numOP,programa,identificacion,usuario,proceso);
        System.debug(data);
        if(data != 'Error en el consumo'){
            Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
            Boolean success = Boolean.valueOf(jsonParsed.get('success'));

            if(success == true){
                response.success = success;
                response.message = String.valueOf(jsonParsed.get('message'));
                String respuesta = 'Exitoso';
                rp.add(response);
                return rp;
            }else{
                response.success = success;
                response.message = String.valueOf(jsonParsed.get('message'));
                rp.add(response);
                return rp;
       		}
        }
        else{
                response.success = false;
                response.message = 'ERROR EN EL CONSUMO DEL SERVICIO';
                rp.add(response);
                return rp;
            }        
    }

    public class responseAU{
        @invocablevariable(Label='Message' required=true)
        public String message;
        @invocablevariable(Label='success' required=true)
        public Boolean success;
    }
}