/*************************************************************************
Nombre de la Clase: AccionSugerida
Versión : 1.0
Fecha de Creación :  17 Noviembre 2022
Funcionalidad: Solicita los datos y devuelve respuesta, del proceso de accion sugerida.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       17/11/2022       Versión Original
*************************************************************************/

public with sharing class AccionSugerida {
    @invocablevariable(Label = 'idEstudio' required = true)
	public string idEstudio;
	@invocablevariable(Label = 'identificacion' required = true)
	public string identificacion;
	@invocablevariable(Label = 'usuario' required = true)
	public string usuario;

    public AccionSugerida() { }
    public AccionSugerida(String idEstudio,String identificacion,
                           String usuario){
        this.idEstudio = idEstudio; 
        this.identificacion=identificacion;
        this.usuario=usuario;            
    }
    @InvocableMethod (label='Accion Sugerida')
    public static List<responseAS> consultaAccionSugerida(list<AccionSugerida> AccionSug){
        String idEstudio = AccionSug[0].idEstudio;
        String identificacion = AccionSug[0].identificacion;
        String usuario = AccionSug[0].usuario;
        List<responseAS> rp = new List<responseAS>();
        responseAS response = new responseAS();
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String agencia = datosEstudio[1];
        String estudio = datosEstudio[2];

        String data = Calificacion.AccionSugerida(empresa, agencia, estudio, identificacion, usuario.toUpperCase());
        System.debug(data);
        if(data != 'Error en el consumo'){
            InterfaceAccionSugerida ResultAccionSugerida = new InterfaceAccionSugerida();	
            ResultAccionSugerida = InterfaceAccionSugerida.parse(data);
            System.debug(ResultAccionSugerida);
            if(ResultAccionSugerida != null){
                response.success = ResultAccionSugerida.success;
                response.sub_proceso = ResultAccionSugerida.data.sub_proceso;
                response.tipo_pep = ResultAccionSugerida.data.tipo_pep;
                response.accion_sugerida = ResultAccionSugerida.data.accion_sugerida;
                response.segmento = ResultAccionSugerida.data.segmento;
                response.saldo_cartera = ResultAccionSugerida.data.saldo_cartera;
                response.total = ResultAccionSugerida.data.total;
                response.saldo = ResultAccionSugerida.data.saldo;
                response.cod_error = ResultAccionSugerida.data.cod_error;
                response.mensj_error = ResultAccionSugerida.data.mensj_error;
                rp.add(response);
                return rp;
            }else{
                response.mensj_error = 'Error en el sistema';
                rp.add(response);
                return rp;
            }
            
        }else{
            response.mensj_error = data;
            rp.add(response);
            return rp;
        }
    }

    public class responseAS{
        @invocablevariable(Label='Success' required=true)
        public Boolean success;
        @invocablevariable(Label='Sub Proceso' required=true)
        public String sub_proceso;
        @invocablevariable(Label='Tipo pep' required=true)
        public String tipo_pep;
        @invocablevariable(Label='Accion sugerida' required=true)
        public String accion_sugerida;
        @invocablevariable(Label='Segmento' required=true)
        public String segmento;
        @invocablevariable(Label='Saldo Cartera' required=true)
        public Double saldo_cartera;
        @invocablevariable(Label='Total' required=true)
        public Double total;
        @invocablevariable(Label='Saldo' required=true)
        public Double saldo;
        @invocablevariable(Label='Codigo de error' required=true)
        public Double cod_error;
        @invocablevariable(Label='Mensaje de error' required=true)
        public String mensj_error;       
    }
}