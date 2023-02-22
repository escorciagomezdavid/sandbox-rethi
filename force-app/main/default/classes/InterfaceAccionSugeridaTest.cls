@IsTest
public with sharing class InterfaceAccionSugeridaTest {
    static testMethod void testParse() {
		String json = '{'+
		'    \"success\": true,'+
		'    \"data\": {'+
		'        \"accion_sugerida\": \"G1\",'+
		'        \"segmento\": \"ORO\",'+
		'        \"saldo_cartera\": 0.0,'+
		'        \"total\": 0.0,'+
		'        \"saldo\": 0.0,'+
		'        \"cod_error\": null,'+
		'        \"mensj_error\": null'+
		'    }'+
		'}';
		InterfaceAccionSugerida obj = InterfaceAccionSugerida.parse(json);
		System.assert(obj != null);
	}
}