@IsTest
public class JamarAsignacionCitaServicioTest {
    @invocablevariable(Label = 'ID_OP' required = true)
    public string idOp;
    @invocablevariable(Label = 'numero caso' required = true)
    public string numeroCaso;
    @invocablevariable(Label = 'codigo producto' required = true)
    public string codProducto;
    @invocablevariable(Label = 'codigo bodega' required = true)
    public string codBodega;
    @invocablevariable(Label = 'fecha cita' required = true)
    public string fechaCita;
    @invocablevariable(Label = 'tipo Calendario' required = true)
    public string tipoCalendario;
    @invocablevariable(Label = 'tipo Solucion' required = true)
    public string tipoSol;
    @invocablevariable(Label = 'Proceso' required = true)
	public string proceso;

    public JamarAsignacionCitaServicioTest() {
        this.idOp = 'JA_95_2021_2599399';
        this.numeroCaso = '00347118';
        this.codProducto = '234567';
        this.codBodega = '72';
        this.fechaCita = '2022-06-30:2022-06-29';
        this.tipoCalendario = 'N';
        this.tipoSol = 'CAMBIO';
        this.proceso = 'REASIGNACION';
    }

    @istest static void TestAsignacionCitaReasignacion() {
        String identificacion = 'ID001';
        TestDataFactory.createAccount(identificacion);	
        Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		TestDataFactory.crearCaseGarantia(getCuenta.ID, 'SERVICIO DE GARANTIA', null, null, 'Abierto');
        Case caso = [select ID,CaseNumber from Case where AccountId =: getCuenta.ID]; 
        JamarAsignacionCitaServicioTest testeo = new JamarAsignacionCitaServicioTest();
        JamarAsignacionCitaServicio citaServicio = new JamarAsignacionCitaServicio(testeo.idOp, caso.CaseNumber, testeo.codProducto, testeo.codBodega, testeo.fechaCita, testeo.tipoCalendario, testeo.tipoSol, testeo.proceso);
        list<JamarAsignacionCitaServicio> citaServ = new list<JamarAsignacionCitaServicio> ();
        citaServ.add(citaServicio);	
        Test.startTest();      
        String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
        Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock());
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28","fecha_recogida": "2022-06-29","fecha_entrega": "2022-07-15","tipo_calendario": "N","tipo_sol": "CAM"}', 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"success":true,"message":"Cita asignada exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarAsignacionCitaServicio.AsignarCitaServicio(citaServ);
        Test.stopTest();
    }
    
    @istest static void TestAsignacionCitaAutomatico() {
        String identificacion = 'ID001';
        TestDataFactory.createAccount(identificacion);	
        Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		TestDataFactory.crearCaseGarantia(getCuenta.ID, 'SERVICIO DE GARANTIA', null, null, 'Abierto');
        Case caso = [select ID,CaseNumber from Case where AccountId =: getCuenta.ID]; 
        JamarAsignacionCitaServicioTest testeo = new JamarAsignacionCitaServicioTest();
        JamarAsignacionCitaServicio citaServicio = new JamarAsignacionCitaServicio(testeo.idOp, caso.CaseNumber, testeo.codProducto, testeo.codBodega, testeo.fechaCita, testeo.tipoCalendario, testeo.tipoSol, 'AUTOMATICO');
        list<JamarAsignacionCitaServicio> citaServ = new list<JamarAsignacionCitaServicio> ();
        citaServ.add(citaServicio);	
        Test.startTest();      
        String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
        Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock());
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28","fecha_recogida": "2022-06-29","fecha_entrega": "2022-07-15","tipo_calendario": "N","tipo_sol": "CAM"}', 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"success":true,"message":"Cita asignada exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarAsignacionCitaServicio.AsignarCitaServicio(citaServ);
        Test.stopTest();
    }
    
     @istest static void TestAsignacionCitaReasignacionTaller() {
        String identificacion = 'ID001';
        TestDataFactory.createAccount(identificacion);	
        Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		TestDataFactory.crearCaseGarantia(getCuenta.ID, 'SERVICIO DE GARANTIA', null, null, 'Abierto');
        Case caso = [select ID,CaseNumber from Case where AccountId =: getCuenta.ID]; 
        JamarAsignacionCitaServicioTest testeo = new JamarAsignacionCitaServicioTest();
        JamarAsignacionCitaServicio citaServicio = new JamarAsignacionCitaServicio(testeo.idOp, caso.CaseNumber, testeo.codProducto, testeo.codBodega, '2022-11-12:2022-11-25|2022-11-24', testeo.tipoCalendario, 'TALLER', 'AUTOMATICO');
        list<JamarAsignacionCitaServicio> citaServ = new list<JamarAsignacionCitaServicio> ();
        citaServ.add(citaServicio);	
        Test.startTest();      
        String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
        Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock());
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28","fecha_recogida": "2022-06-29","fecha_entrega": "2022-07-15","tipo_calendario": "N","tipo_sol": "TAL"}', 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"success":true,"message":"Cita asignada exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        System.debug('Error: ' + citaServ);
        JamarAsignacionCitaServicio.AsignarCitaServicio(citaServ);
        Test.stopTest();
    }
}