@IsTest
public class ActualizarOpAuroraTest {      
    @invocablevariable(Label='numOp' required=true)
    public string numOp;
    @invocablevariable(Label='identificacion' required=true)
    public string identificacion;

    public ActualizarOpAuroraTest(){
        this.numOp = '2467883';
        this.identificacion = '91230949';
    }
    
    @istest static void TestActualizacionOp() {
        ActualizarOpAuroraTest testeo = new ActualizarOpAuroraTest();
        ActualizarOpAurora opActualizada = new ActualizarOpAurora(testeo.numOp, testeo.identificacion);
        list<ActualizarOpAurora> opRespuesta = new list<ActualizarOpAurora> ();
        opRespuesta.add(opActualizada);
        Test.startTest();
        String endPoint = Endpoint__mdt.getInstance('Validacion_Op').URL__c + '2467883';
        Test.setMock(HttpCalloutMock.class, new ActualizarOpAuroraMock());
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(endPoint, '{"identificacion": "91230949"}', 'POST');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"disponible": true}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        ActualizarOpAurora.ActualizarOp(opRespuesta);
        Test.stopTest();
    }
}