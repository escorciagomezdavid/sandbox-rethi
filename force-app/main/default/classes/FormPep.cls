/*************************************************************************
Nombre de la Clase: Form Pep
Versión : 1.0
Fecha de Creación :  17 Noviembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de persona politicamente expuesta.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       17/11/2022       Versión Original
*************************************************************************/
public with sharing class FormPep {
    @invocablevariable(Label = 'Empresa' required = true)
	public string empresa;
	@invocablevariable(Label = 'Json PEP' required = true)
	public string json;

    public FormPep() { }
    public FormPep(String empresa, String json){
        this.empresa=empresa;
        this.json=json;
    }

    @InvocableMethod (label='Formulario PEP')
    public static List<String> GuardarPEP(list<FormPep> PEP){
        String empresa = PEP[0].empresa;
        String json = PEP[0].json;
        List<String> value = new List<String>();
        String data = Calificacion.FormularioPep(empresa, json);
        if(data != 'Error en el consumo'){
            Map<String, Object> jsonParsed = (Map<String, Object>) System.JSON.deserializeUntyped(data);
            Boolean success = Boolean.valueOf(jsonParsed.get('success'));
            if(success == true){
                value.add('GUARDADO EXITOSO');
                return value;
            }else if(success == false){
                value.add('NO EXITOSO');
                return value;
            }
        }else{
            value.add('ERROR EN EL CONSUMO DEL SERVICIO');
            return value;
        }

        return null;
    }
}