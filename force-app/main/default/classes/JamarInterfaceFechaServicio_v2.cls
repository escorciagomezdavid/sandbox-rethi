public class JamarInterfaceFechaServicio_v2 {
	public Boolean success;
    public String TIPO_CALENDARIO;
    public String COD_BOD_ENTRADA;
    public String COD_BOD_SALIDA;
    public List<FechasCalendario> fechasCalendario;

    public class FechasCalendario {
        public String FECHA_PICKING_R;
        public String FECHA_RECOGIDA;
        public String FECHA_PICKING_E;
        public String FECHA_ENTREGA;
    }

    public static JamarInterfaceFechaServicio_v2 parse(String json) {
        return (JamarInterfaceFechaServicio_v2) System.JSON.deserialize(json, JamarInterfaceFechaServicio_v2.class);
    }
}