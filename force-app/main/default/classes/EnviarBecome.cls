/*************************************************************************
Nombre de la Clase: EnviarBecome
Versión : 1.0
Fecha de Creación :  15 Marzo 2023
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de Become.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié       15/03/2023       Versión Original
*************************************************************************/

public with sharing class EnviarBecome {


    @invocablevariable(Label = 'empresa' required = true)
	public string idEstudio;
	@invocablevariable(Label = 'identificacion' required = true) //agencia de la Op
	public string identificacion;
    @invocablevariable(Label = 'accion' required = true)
	public string accion;

    public EnviarBecome() {}
    public EnviarBecome(String idEstudio, String identificacion, String accion){
        this.idEstudio=idEstudio;
        this.identificacion=identificacion;      
        this.accion=accion;
    }
    
    @InvocableMethod (label='Enviar Become')
    public static List<responseBC> EnviarBC(list<EnviarBecome> BC){
		String idEstudio = BC[0].idEstudio;
        String identificacion = BC[0].identificacion;
        String accion = BC[0].accion;
        
        List<responseBC> rp = new List<responseBC>();
        responseBC response = new responseBC();
        
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        
        String data = BecomeClass.Become(empresa,identificacion,accion);
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

    public class responseBC{
        @invocablevariable(Label='Message' required=true)
        public String message;
        @invocablevariable(Label='success' required=true)
        public Boolean success;
    }
}