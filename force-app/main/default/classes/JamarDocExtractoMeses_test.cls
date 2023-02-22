@isTest
public class JamarDocExtractoMeses_test {
	@invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    
    public JamarDocExtractoMeses_test(){
        this.empresas = 'JA';
        this.identificacion = '1043434567';
    }
    
     @isTest static void TestExtractoMes(){
            
        JamarDocExtractoMeses_test testeo = new JamarDocExtractoMeses_test();
		JamarDocExtractoMeses listExtracto= new JamarDocExtractoMeses(testeo.empresas, testeo.identificacion);
        List<jamarDocExtractoMeses> jamarDocExtractoMesesList = new List<jamarDocExtractoMeses>();
        jamarDocExtractoMesesList.add(listExtracto);
        System.debug(jamarDocExtractoMesesList);
         
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarDocExtractoMesesMock());
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://59o1es3b63.execute-api.us-east-1.amazonaws.com/api/v1/JA/users/xx/sumaries?NoIdentificacion=1013596562', '', 'GET', '');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
      	String expectedValue = '[{"id":69833177,"month":"03/2022"},{"id":69833178,"month":"02/2022"},{"id":69833179,"month":"01/2022"}]';
   		System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarDocExtractoMeses.MesesExtractos(jamarDocExtractoMesesList);
        Test.stopTest();
     }
    @isTest static void TestExtractoMes_fail(){
        JamarDocExtractoMeses_test testeo = new JamarDocExtractoMeses_test();
		JamarDocExtractoMeses listExtracto= new JamarDocExtractoMeses(testeo.empresas, testeo.identificacion);
        List<jamarDocExtractoMeses> jamarDocExtractoMesesList = new List<jamarDocExtractoMeses>();
        jamarDocExtractoMesesList.add(listExtracto);
        System.debug(jamarDocExtractoMesesList);
        JamarDocExtractoMeses.MesesExtractos(jamarDocExtractoMesesList);
    }
}