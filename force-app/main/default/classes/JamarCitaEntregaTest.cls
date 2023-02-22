@IsTest
public class JamarCitaEntregaTest {      
            @invocablevariable(Label='idOp' required=true)
                public string idOp;
            @invocablevariable(Label='tipoDoc' required=true)
                public string tipoDoc;
    		@invocablevariable(Label='fechaCita' required=true)
                public string citaEntrega;
    		@invocablevariable(Label='comprometeMercancia' required=true)
                public string comprMcia;
    		@invocablevariable(Label='usuarioOperacion' required=true)
                public string userOperacion;

    
            //public JamarCitaEntregaTest(){}
            public JamarCitaEntregaTest(){
                       this.idOp = 'JA_09_2021_345678';
                       this.tipoDoc = 'OP';
                       this.citaEntrega = 'Lunes,04-Noviembre-2021';
                       this.comprMcia = 'S';
                       this.userOperacion = 'daniela';  
            }
    
    @istest static void TestCitaEntregaFallo(){
        JamarCitaEntregaTest testeo = new JamarCitaEntregaTest();
        JamarCitaEntrega CitaEntrega = new JamarCitaEntrega(testeo.idOp,testeo.tipoDoc,testeo.citaEntrega,testeo.comprMcia,testeo.userOperacion);
        list<JamarCitaEntrega> citaEnt = new list<JamarCitaEntrega>();
            citaEnt.add(CitaEntrega);
        TestDataFactory.crearOportunityAndProducts('JA', testeo.idOp, '');
        List<Opportunity> identificacion= [Select Identificaci_n_del_cliente__c from Opportunity where IdOP__c = :testeo.idOp];
             String n_ide = identificacion[0].Identificaci_n_del_cliente__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarCitaEntregaMock());
                 HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://ctvbdjhq58.execute-api.us-east-1.amazonaws.com/prd/v1/JA/asignarCitaEntrega', '{"userOper":"Daniela","origenOper": "SALESFORCE","comprMcia": "S","citaEntrega": "15/10/2021","tipoDoc": "OP","numOp": "2824356","periodo": "2021","agencia": "01"}', 'POST',null);
                 String contentType = response.getHeader('Content-Type');
                System.assert(contentType == 'application/json');
                String actualValue = response.getBody();
                System.debug(response.getBody());
                 String expectedValue = '{ "ps_nucoderror": 20, "ps_vcmenserror": "La cita a asignar debe ser mayor al dia actual"}';
                System.assertEquals(actualValue, expectedValue);
                System.assertEquals(200, response.getStatusCode());
        JamarCitaEntrega.AsignarCitaEntrega(citaEnt);
        JamarCitaEntrega.meses('Noviembre');
        Test.stopTest();
    }
}