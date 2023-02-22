@IsTest
public class JamarConsultaFechaServicioTest {
    @invocablevariable(Label = 'Empresa' required = true)
    public string empresa;
    @invocablevariable(Label = 'ID_OP' required = true)
    public string idOp;
    @invocablevariable(Label = 'tipo de solucion' required = true)
    public string tipoSol;
    @invocablevariable(Label = 'codigo producto' required = true)
    public string codProducto;
    @invocablevariable(Label = 'Proceso' required = true)
    public string Proceso;

    public JamarConsultaFechaServicioTest() {
        this.empresa = 'JA';
        this.idOp = 'JA_95_2021_2599399';
        this.tipoSol = 'CAMBIO';
        this.codProducto = '234567';
        this.proceso = 'AUTOMATICO';
    }
    @istest static void TestConsultaCalendario() {
        JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
        JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, testeo.tipoSol, testeo.codProducto, testeo.proceso);
        list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
        citaServ.add(citaServicio);
        TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
        JamarConsultaFechaServicio.dias('Sunday');
        JamarConsultaFechaServicio.meses('November');
    }
	@istest static void TestConsultaCalendarioCamParcial() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'CAM_PARCIAL', testeo.codProducto, testeo.proceso);
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
		JamarConsultaFechaServicio.dias('Sunday');
		JamarConsultaFechaServicio.meses('November');
	}

	@istest static void TestConsultaCalendarioTaller() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'TAL', testeo.codProducto, testeo.proceso);
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
		JamarConsultaFechaServicio.dias('Sunday');
		JamarConsultaFechaServicio.meses('November');
	}

	@istest static void TestConsultaCalendarioTallerReasignacion() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'TAL', testeo.codProducto, 'REASIGNACION');
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
		JamarConsultaFechaServicio.dias('Sunday');
		JamarConsultaFechaServicio.meses('November');
	}
	@istest static void TestConsultaCalendarioCambioReasignacion() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'CAM', testeo.codProducto, 'REASIGNACION');
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
		JamarConsultaFechaServicio.dias('Sunday');
		JamarConsultaFechaServicio.meses('November');
	}

	@istest static void TestConsultaCalendarioCodigo400() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'CAM', testeo.codProducto, 'REASIGNACION');
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(400));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success":False,"message":"No se encuentra la bodega rda"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(400, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
	}
    
    	@istest static void TestConsultaCalendarioCodigo500() {
		JamarConsultaFechaServicioTest testeo = new JamarConsultaFechaServicioTest();
		JamarConsultaFechaServicio citaServicio = new JamarConsultaFechaServicio(testeo.empresa, testeo.idOp, 'CAM', testeo.codProducto, 'REASIGNACION');
		list<JamarConsultaFechaServicio> citaServ = new list<JamarConsultaFechaServicio> ();
		citaServ.add(citaServicio);
		TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
		String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(500));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
		String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"message":"Internal server error"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(500, response.getStatusCode());
        JamarConsultaFechaServicio.ConsultaEntrega(citaServ);
        Test.stopTest();
	}
}