public with sharing class InterfaceCapacidadDePago {
    public Data data;
	public Boolean success;

    public class Data {
		public Double nucuotasugerida;
		public Double nucuotasugtol;
		public Double nucuotasugdisp;
		public String nucuotaconsumida;
		public Double nucuotaencartera;
		public Double nucuotapagarnormal;
		public Double nucuotapagarplanfinan;
		public Double nucumplecuota;
		public String mensaje;
		public String nombreimagen;
		public String visatribute;
		public String nucoderror;
		public String menserror;
	}

    public static InterfaceCapacidadDePago parse(String json) {
		return (InterfaceCapacidadDePago) System.JSON.deserialize(json, InterfaceCapacidadDePago.class);
	}

}