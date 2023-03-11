@IsTest
public class AsignarCompromisoPagoTest {
	@invocablevariable(Label = 'id cartera' required = true)
	public string idCartera;
	@invocablevariable(Label = 'fecha plazo' required = true)
	public date fechaPlazo;
	@invocablevariable(Label = 'valor compromiso' required = true)
	public integer valorCompromiso;
    @invocablevariable(Label = 'codigo causal' required = true)
	public String codigoCausal;
    @invocablevariable(Label = 'observacion' required = true)
	public String observacion;
    @invocablevariable(Label = 'usuario' required = true)
	public String usuario;
    
    public AsignarCompromisoPagoTest() {
        this.idCartera = 'JA_01_TJ_123456';
		this.fechaPlazo = Date.valueOf('2023-03-01');
		this.valorCompromiso = 30000;
        this.codigoCausal = '350';
        this.observacion = 'Prueba observacion';
        this.usuario = 'atarra';
    }
    
    @istest static void TestAsignacionCompromisoPago() {
        /*String identificacion = 'ID001';
        TestDataFactory.createAccount(identificacion);	
        TestDataFactory.createCarteras(1);
        Account getCuenta = [SELECT CreatedDate from Account where CreatedDate <> null order by CreatedDate desc limit 1];
		TestDataFactory.crearCaseGarantia(getCuenta.ID, 'SERVICIO DE GARANTIA', null, null, 'Abierto');
        Case caso = [select ID,CaseNumber from Case where AccountId =: getCuenta.ID];*/
        AsignarCompromisoPagoTest testeo = new AsignarCompromisoPagoTest();
        AsignarCompromisoPago compr = new AsignarCompromisoPago(testeo.idCartera, testeo.fechaPlazo, testeo.valorCompromiso, testeo.codigoCausal, testeo.observacion, testeo.usuario);
        list<AsignarCompromisoPago> compromisos = new list<AsignarCompromisoPago>();
        compromisos.add(compr);
        Test.startTest();
        String endPoint = Endpoint__mdt.getInstance('AsignacionCompromisoPago').URL__c;
        Test.setMock(HttpCalloutMock.class, new AsignarCompromisoPagoMock(200));
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"cod_causal":"350", "usuario":"ATARRA", "observacion":"Prueba observacion", "valor_compromiso":"30000", "fecha_plazo":"28-02-2023", "num_cuenta":"123456", "tipo_credito":"TJ", "agencia":"01", "empresa":"JA"}', 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"success": true, "message": "Compromiso de pago creado exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        AsignarCompromisoPago.AsignarCompromiso(compromisos);
        Test.stopTest();
    }
}