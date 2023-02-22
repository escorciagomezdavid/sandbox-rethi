public with sharing class InterfaceEvidente {

    public Boolean success;
	public String message;
    public String errors;
	public Data data;

    public class Data {
		public Integer id_evidente;
		public Integer id_auditoria;
		public Integer reg_validacion;
		public String ident_numero;
		public String ident_tipo;
		public String resultado;
	}

    public static InterfaceEvidente parse(String json) {
		return (InterfaceEvidente) System.JSON.deserialize(json, InterfaceEvidente.class);
	}
}