@IsTest
public class JamarInterfaceTest {
    static testMethod void testParse() {
		String json = '['+
		'    {'+
		'        \"id\": 69823362,'+
		'        \"month\": \"03/2022\"'+
		'    },'+
		'    {'+
		'        \"id\": 69823363,'+
		'        \"month\": \"01/2022\"'+
		'    }'+
		']';
		List<JamarInterfaceExtractoMeses> obj = JamarInterfaceExtractoMeses.parse(json);
		System.assert(obj != null);
	}

}