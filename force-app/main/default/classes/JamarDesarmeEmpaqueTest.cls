@IsTest
public class JamarDesarmeEmpaqueTest  {
    @invocablevariable(Label = 'fecha cita' required = true)
	public Date fechas;
    
    String fecha = '2022-07-28';
    Date fechaCita = date.valueOf(fecha);
    public JamarDesarmeEmpaqueTest(){
        this.fechaCita = fechaCita;
    }
    
     @istest static void TestFechaEmpaqueDesarme() {
        JamarDesarmeEmpaqueTest testeo = new JamarDesarmeEmpaqueTest();
        JamarDesarmeEmpaque citaServicio = new JamarDesarmeEmpaque(testeo.fechaCita);
        list<JamarDesarmeEmpaque> citaServ = new list<JamarDesarmeEmpaque> ();
        citaServ.add(citaServicio);
        JamarDesarmeEmpaque.FechaDesarmeEmpaque(citaServ);

    }
}