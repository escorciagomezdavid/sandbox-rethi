/*************************************************************************
Nombre de la Clase: Capacidad de pago
Versión : 1.0
Fecha de Creación :  21 Noviembre 2022
Funcionalidad: Se recopilan los datos y espera respuesta del sistema externo
               para el proceso de capacidad de pago.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       21/11/2022       Versión Original
*************************************************************************/
public with sharing class CapacidadPago {

    @invocablevariable(Label = 'idEstudio' required = true)
	public string idEstudio;
	@invocablevariable(Label = 'titular' required = true)
	public string titular;
    @invocablevariable(Label = 'miembro' required = true)
	public string miembro;
	@invocablevariable(Label = 'usuario' required = true)
	public string usuario;

    public CapacidadPago() {}
    public CapacidadPago(String idEstudio,String titular,String miembro,
                           String usuario){
        this.idEstudio = idEstudio; 
        this.titular=titular;
        this.miembro=miembro;
        this.usuario=usuario;            
    }
    @InvocableMethod (label='Capacidad de pago')
    public static List<responseCP> consultarCapacidadPago(list<CapacidadPago> CP){
        String idEstudio = CP[0].idEstudio;
        String titular = CP[0].titular;
        String miembro = CP[0].miembro;
        String usuario = CP[0].usuario;
        List<responseCP> rp = new List<responseCP>();
        responseCP response = new responseCP();
        List<String> datosEstudio = new List<String> ();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String agencia = datosEstudio[1];
        String estudio = datosEstudio[2];
        String data = Calificacion.CapacidadPago(empresa, agencia, estudio, titular,miembro,usuario.toUpperCase());
        if(data != 'Error en el consumo'){
            InterfaceCapacidadDePago ResultCapacidadPago = new InterfaceCapacidadDePago();	
            ResultCapacidadPago = InterfaceCapacidadDePago.parse(data);
            System.debug(ResultCapacidadPago);
            if(ResultCapacidadPago != null){
                response.success = ResultCapacidadPago.success;
                response.cuotaCartera = ResultCapacidadPago.data.nucuotaencartera;
                response.cuotaSugerida = ResultCapacidadPago.data.nucuotasugerida;
                response.cuotaSugtol=ResultCapacidadPago.data.nucuotasugtol;
                response.cuotaSugdisp = ResultCapacidadPago.data.nucuotasugdisp;
                response.cuotaConsumida = ResultCapacidadPago.data.nucuotaconsumida;
                response.cuotaPagarNormal = ResultCapacidadPago.data.nucuotapagarnormal;
                response.cuotaPagarPlanFinan = ResultCapacidadPago.data.nucuotapagarplanfinan;
                response.mensaje = ResultCapacidadPago.data.mensaje;
                response.nucoderror=ResultCapacidadPago.data.nucoderror;
                response.mensError=ResultCapacidadPago.data.menserror;
                rp.add(response);
                return rp;
            }else{
                response.mensError = 'Error en el sistema';
                rp.add(response);
                return rp;
            }
        }else{
            response.mensError = data;
            rp.add(response);
            return rp;
        }
    }

    public class responseCP{
        @invocablevariable(Label='Success' required=true)
        public Boolean success;
        @invocablevariable(Label='Cuota Sugerida' required=true)
        public Double cuotaSugerida;
        @invocablevariable(Label='Cuota Sugerida Total' required=true)
        public Double cuotaSugtol;
        @invocablevariable(Label='Cuota Sugerida Disponible' required=true)
        public Double cuotaSugdisp;
        @invocablevariable(Label='Cuota Consumida' required=true)
        public String cuotaConsumida;
        @invocablevariable(Label='Cuota en Cartera' required=true)
        public Double cuotaCartera;
        @invocablevariable(Label='Cuota a pagar Normal' required=true)
        public Double cuotaPagarNormal;
        @invocablevariable(Label='Cuota a pagar Plan final' required=true)
        public Double cuotaPagarPlanFinan;
        @invocablevariable(Label='Cumple Cuota' required=true)
        public Double cumpleCuota;
        @invocablevariable(Label='Mensaje' required=true)
        public String mensaje; 
        @invocablevariable(Label='Numero codigo Error' required=true)
        public String nucoderror; 
        @invocablevariable(Label='Mensaje de error' required=true)
        public String mensError;        
    }
}