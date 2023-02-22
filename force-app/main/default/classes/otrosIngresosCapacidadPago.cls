/*************************************************************************
Nombre de la Clase: Otros ingresos capacidad de pago
Versión : 1.0
Fecha de Creación :  17 Noviembre 2022
Funcionalidad: Solicita los datos y devuelve respuesta, del proceso cuando se piden otros ingresos.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       17/11/2022       Versión Original
*************************************************************************/
public with sharing class otrosIngresosCapacidadPago {
    @invocablevariable(Label = 'idEstudio' required = true)
	public string idEstudio;
	@invocablevariable(Label = 'codigo ocupacion' required = true)
	public string codigoOcupacion;
    @invocablevariable(Label = 'otros ingresos' required = true)
	public Integer otrosIngresos;
    @invocablevariable(Label = 'Actividad de negocio' required = false)
	public string actividadNegocio;
    @invocablevariable(Label = 'identificacion' required = true)
	public string identificacion;

    public otrosIngresosCapacidadPago() {
    }

    public otrosIngresosCapacidadPago(String idEstudio, String codigoOcupacion, Integer otrosIngresos,
                                        String actividadNegocio, String identificacion){

                                            this.idEstudio = idEstudio; 
                                            this.codigoOcupacion=codigoOcupacion;
                                            this.otrosIngresos=otrosIngresos;
                                            this.actividadNegocio=actividadNegocio;
                                            this.identificacion = identificacion;
    }

    @InvocableMethod (label='Otros ingresos Capacidad')
    public static List<String> consultarCapacidadPago(list<otrosIngresosCapacidadPago> otrosIngresosCap){
                        String idEstudio = otrosIngresosCap[0].idEstudio;
                        System.debug(idEstudio);
                        String codigoOcupacion = otrosIngresosCap[0].codigoOcupacion;
                        String actividadNegocio = otrosIngresosCap[0].actividadNegocio;
                        String identificacion = otrosIngresosCap[0].identificacion;
                        Integer otrosIngresos = otrosIngresosCap[0].otrosIngresos;
                        List<String> value = new List<String>();
                        List<String> datosEstudio = new List<String> ();

                        for (String st : idEstudio.split('_')) {
                            datosEstudio.add(st);
                        }
                        String empresa= datosEstudio[0];
                        System.debug(empresa);
                        String agencia = datosEstudio[1];
                        String estudio = datosEstudio[2];
                        String data = Calificacion.CapacidadPagoOtrosIngresos(empresa, otrosIngresos, codigoOcupacion, actividadNegocio,agencia,estudio,identificacion);
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