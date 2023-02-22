@isTest
public class JamarDocExtractoTest {
    @invocablevariable(Label='Empresa' required=true)
    public string empresas;
    @invocablevariable(Label='Identificacion' required=true)
    public string identificacion;
    @invocablevariable(Label='period')
    public string period;
    
    public JamarDocExtractoTest(){
        this.empresas = 'JA';
        this.identificacion = '1043434567';
        this.period = '2';
    }
    
    @isTest static void TestExtracto(){
        JamarDocExtractoTest testeo = new JamarDocExtractoTest();
        JamarDocExtracto listExtracto= new JamarDocExtracto(testeo.empresas, testeo.identificacion, testeo.period);
        list<JamarDocExtracto> extracto = new list<JamarDocExtracto>();
        extracto.add(listExtracto);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarDocExtractoMock());
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/JA/extracto/1129567580/2022-03', '', 'GET', '');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"url": ["https://jamar-pdf-dev.s3.amazonaws.com/extractos_portal/202203_1129567580.PDF"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarDocExtracto.GeneracionExtracto(extracto);
        Test.stopTest();
    }
    @isTest static void TestExtractoMes_fail(){
        JamarDocExtractoTest testeo = new JamarDocExtractoTest();
        JamarDocExtracto listExtracto= new JamarDocExtracto(testeo.empresas, testeo.identificacion, testeo.period);
        list<JamarDocExtracto> extracto = new list<JamarDocExtracto>();
        extracto.add(listExtracto);
        JamarDocExtracto.GeneracionExtracto(extracto);
    }
    
}