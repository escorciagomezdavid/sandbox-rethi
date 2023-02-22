public with sharing class InterfaceAccionSugerida {
    public Boolean success;
	public Data data;

	public class Data {
		public String accion_sugerida;
		public String segmento;
		public Double saldo_cartera;
		public Double total;
		public Double saldo;
		public Double cod_error;
		public String mensj_error;
		public String sub_proceso;
		public String tipo_pep;
	}

	
	public static InterfaceAccionSugerida parse(String json) {
		return (InterfaceAccionSugerida) System.JSON.deserialize(json, InterfaceAccionSugerida.class);
	}
}