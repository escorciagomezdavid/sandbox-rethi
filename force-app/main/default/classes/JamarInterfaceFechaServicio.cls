/*
  Name: JamarInterfaceFechaServicio
  Proposito: Desestructura json de servicio de calendario de cita de servicio.
  Autor: Daniela Sanchez
  Fecha: 07/06/2022
 
*/
public class JamarInterfaceFechaServicio {
    public Boolean success;
    public String TIPO_CALENDARIO;
    public String COD_BODEGA;
    public List<FechasCalendario> fechasCalendario;

    public class FechasCalendario {
        public String FECHA_PICKING;
        public String FECHA_CITA;
		public String FECHA_ENTREGA;
    }

    public static JamarInterfaceFechaServicio parse(String json) {
        return (JamarInterfaceFechaServicio) System.JSON.deserialize(json, JamarInterfaceFechaServicio.class);
    }
}