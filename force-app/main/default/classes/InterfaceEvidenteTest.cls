@IsTest
public with sharing class InterfaceEvidenteTest {
    static testMethod void testParse() {
		String json = '{'+
		'    \"success\": true,'+
		'    \"message\": \"OK\",'+
		'    \"data\": {'+
		'        \"id_evidente\": 281619,'+
		'        \"id_auditoria\": 3948948,'+
		'        \"reg_validacion\": 305824928,'+
		'        \"ident_numero\": \"1043434561\",'+
		'        \"ident_tipo\": \"1\",'+
		'        \"resultado\": \"01\"'+
		'    }'+
		'}';
		InterfaceEvidente obj = InterfaceEvidente.parse(json);
		 obj = InterfaceEvidente.parse(json);
		System.assert(obj != null);
	}
}