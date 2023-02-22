/*************************************************************************
Nombre de la Clase: Validar Firmas
Versión : 1.0
Fecha de Creación :  21 Diciembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de Validar Firmas.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié       23/12/2022       Versión Original
*************************************************************************/

public with sharing class ValidarFirmas {

    @invocablevariable(Label = 'idEstudio' required = true) //empresa, agencia del estudio, codigo del estudio
	public string idEstudio;
    @invocablevariable(Label = 'identificacion' required = true)
	public string identificacion;

    public ValidarFirmas() {}
    public ValidarFirmas(String idEstudio, String identificacion){
        this.idEstudio=idEstudio;
        this.identificacion=identificacion; 
    }
    @InvocableMethod (label='Validar Firmas')
    public static List<String> ValidarFirmas(list<ValidarFirmas> VF){
		String idEstudio = VF[0].idEstudio;
        String identificacion = VF[0].identificacion;  
        List<String> value = new List<String>();
        
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String agencia= datosEstudio[1];
        String estudioCod = datosEstudio[2];
        
        String data = ProcesoFirma.validarFirmas(empresa, agencia, estudioCod, identificacion);
        System.debug(data);
        if(data != 'Error en el consumo'){
            Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
            Boolean success = Boolean.valueOf(jsonParsed.get('success'));
            if(success == true){
                value.add('VALIDACIÓN EXITOSA');
                return value;
            }else if(success == false){
                value.add('VALIDACIÓN NO EXITOSA');
                return value;
            }
        }else{
            value.add('ERROR EN EL CONSUMO DEL SERVICIO');
            return value;
        }

        return null;       
    }
}