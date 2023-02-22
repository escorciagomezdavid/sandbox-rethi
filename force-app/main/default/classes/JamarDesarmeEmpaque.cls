/*
  Name: JamarDesarmeEmpaque
  Proposito: Hace peticion a servicio que Graba la cita de servicio.
  Autor: Daniela Sanchez
  Fecha: 09/06/2022
 
*/
public class JamarDesarmeEmpaque {

	@invocablevariable(Label = 'fecha cita' required = true)
	public Date fechaCita;

	public JamarDesarmeEmpaque() { }
	public JamarDesarmeEmpaque(Date fechaCita) {
		this.fechaCita = fechaCita;
	}
	@InvocableMethod(label = 'Fecha de Desarme o Empaque')
	public static List<Response> FechaDesarmeEmpaque(list<JamarDesarmeEmpaque> fechaServicio) {
		Date x = fechaServicio[0].fechaCita;
		Date fechaPrevia;
		response rp = new response();
		list<response> value = new list<response> ();
		DateTime dt = DateTime.newInstance(x.year(), x.month(), x.day() - 1);
		System.debug(dt);
		String format = 'EEEE,dd-MMMM-YYYY';
		String fecha = dt.format(format);
		String diaSub = fecha.substringBefore(',');
		String diaSpanish = dias(diaSub);
		if (diaSpanish == 'Domingo') {
			DateTime tx = DateTime.newInstance(x.year(), x.month(), x.day() - 2);
			fechaPrevia = Date.newInstance(tx.year(), tx.month(), tx.day());
			System.debug(tx);
		} else if (fecha == 'Monday,04-July-2022' || fecha == 'Wednesday,20-July-2022' || fecha == 'Monday,15-August-2022' || fecha == 'Monday,17-Octuber-2022' ||
		           fecha == 'Monday,7-November-2022' || fecha == 'Monday,14-November-2022' || fecha == 'Thursday,08-December-2022'){
				   fechaPrevia = Date.newInstance(dt.year(), dt.month(), dt.day());
		}else {
			fechaPrevia = Date.newInstance(dt.year(), dt.month(), dt.day());
		}
		rp.calendario = fechaPrevia;
		value.add(rp);
		return value;
	}
	public class response {
		@invocablevariable(Label = 'cita de Empaque o Desarme' required = true)
		public Date calendario;

	}
	public static String dias(string fecha) {
		Map<String, String> semana = new Map<String, String> ();
		String dia;
		semana.put('Monday', 'Lunes');
		semana.put('Tuesday', 'Martes');
		semana.put('Wednesday', 'Miercoles');
		semana.put('Thursday', 'Jueves');
		semana.put('Friday', 'Viernes');
		semana.put('Saturday', 'Sabado');
		semana.put('Sunday', 'Domingo');

		for (String m : semana.keySet()) {
			if (m == fecha) {
				dia = semana.get(m);
			}
		}
		return dia;
	}
}