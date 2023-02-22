public class IRespuestaPrecalificacion  {

	public class Ps_responseClob {
		public Boolean success;
		public String message;
		public Data data;
	}
    
	public Ps_responseClob ps_responseClob;
	public Object ps_nuCodError;
	public Object ps_vcMensError;
	public Boolean success;

	public class Data {
		public String c_emp;
		public String c_agr;
		public String c_est;
		public String n_ide;
		public String estado;
		public String subestado;
		public String piloto;
		public String pilexpress;
		public Integer cupo_max;
		public Integer cupo_disp;
		public Integer puntajelisim;
		public Integer cuotasugmax;
		public String lectura_data;
		public String accsug_credito;
		public String accsug_tj;
		public String tipo_cliente;
		public String des_tcliente;
		public String pot_tj;
		public String calcularlectura;
		public String segmento;
		public String usuario;
		public Integer pasesaldo;
		public String aplicascore;
		public String ususimulador;
		public String tipomodelo;
		public String act_pottj;
		public String act_cupo;
		public String ct_estado;
		public String cue;
		public String tcre;
		public String agecue;
		public String total;
		public String saldo;
		public String fup;
		public String estcar;
		public String mostrar_menspiloto;
		public String tipoprecalf;
		public Double scorefinal;
		public String accsuglisim;
		public String fecaccsug;
		public String acciones_sug;
		public String desc_accsugcr;
		public String desc_accsugtj;
		public String identifica_datacredito;
		public String codmodelo;
		public String evaltipocliente;
		public String tipo_estudio;
		public String programa;
		public String modulo;
		public String maquina;
	}

	public static IRespuestaPrecalificacion parse(String json) {
		return (IRespuestaPrecalificacion) System.JSON.deserialize(json, IRespuestaPrecalificacion.class);
	}
}