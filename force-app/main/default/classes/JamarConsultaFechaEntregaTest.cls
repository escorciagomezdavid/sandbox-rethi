@IsTest
public class JamarConsultaFechaEntregaTest {
    @invocablevariable(Label='Empresa' required=true)
    public string empresa;
    @invocablevariable(Label='ID_OP' required=true)
    public string idOp;
    @invocablevariable(Label='tipo de Orden' required=true)
    public string tipo;
    
    public JamarConsultaFechaEntregaTest(){
        this.empresa = 'JA';
        this.idOp = 'JA_95_2021_2561402';
        this.tipo = 'OP';               
    }
    
    
    @istest static void TestConsultaCitaEntrega(){
        JamarConsultaFechaEntregaTest testeo = new JamarConsultaFechaEntregaTest();
        JamarConsultaFechasEntrega CitaEntrega = new JamarConsultaFechasEntrega(testeo.empresa,testeo.idOp,testeo.tipo);
        list<JamarConsultaFechasEntrega> citaEnt = new list<JamarConsultaFechasEntrega>();
        citaEnt.add(CitaEntrega);
        
        TestDataFactory.crearOportunityAndProducts(testeo.empresa,testeo.idOp,null);
        //JamarConsultaFechasEntrega.ConsultaEntrega(citaEnt);
        
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaEntregaMock());
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaEntrega').URL__c;
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint+'JA/delivery-date', '{"numOrden":"3184326","numCantCitas":"6","tipoDoc":"OP"}','POST',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarConsultaFechasEntrega.ConsultaEntrega(citaEnt);
        Test.stopTest();
        
        JamarConsultaFechasEntrega.dias('Sunday');
        JamarConsultaFechasEntrega.meses('November');
        
    }
    
}