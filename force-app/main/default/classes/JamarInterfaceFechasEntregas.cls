/*************************************************************************
Nombre de la Clase:     JamarInterfaceFechasEntregas
Versión :               2.0
Fecha de Creación :     24/10/2021
Funcionalidad :         Mapear la estructura del json de respuesta del 
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez         24/10/2021     Versión Original
* Daniela Sanchez         14/02/2023     Cambio del json respuesta del calendario de asignacion de cita.

*************************************************************************/
public class JamarInterfaceFechasEntregas {
	public class Response {
		public Boolean success;
		public String message;
		public List<Data> data;
	}

	public String erroCode;
	public String errorMessage;
	public Response response;

	public class Fechas {
		public String Fecha;
		public String Estado;
	}

	public class Data {
		public List<Fechas> Fechas;
	}

    
    public static JamarInterfaceFechasEntregas parse (String json) {
		return (JamarInterfaceFechasEntregas) System.JSON.deserialize(json, JamarInterfaceFechasEntregas.class);
	}

}