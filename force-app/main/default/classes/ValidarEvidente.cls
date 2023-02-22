/*************************************************************************
Nombre de la Clase: Validar Evidente
Versión : 1.0
Fecha de Creación :  21 Diciembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de Validar Evidente.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Breiner Hincapié       23/12/2022       Versión Original
*************************************************************************/

public with sharing class ValidarEvidente {

    @invocablevariable(Label = 'empresa' required = true)
	public string empresa;
    @invocablevariable(Label = 'identificacion' required = true)
	public string identificacion;

    public ValidarEvidente() {}
    public ValidarEvidente(String empresa, String identificacion){
        this.empresa=empresa;
        this.identificacion=identificacion; 
    }
    @InvocableMethod (label='Validar Evidente')
    public static List<String> ValidarEvidente(list<ValidarEvidente> VE){
		String empresa = VE[0].empresa;
        String identificacion = VE[0].identificacion;   
        List<String> value = new List<String>();
        
        String data = ValidacionIdentidad.validarEvidente(empresa, identificacion);
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