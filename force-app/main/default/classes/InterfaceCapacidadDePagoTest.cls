@IsTest
public  class InterfaceCapacidadDePagoTest {
    static testMethod void testParse() {
		String json = '{    \"data\": {'+
		'        \"nucuotasugerida\": 104000.0,'+
		'        \"nucuotasugtol\": 114400.0,'+
		'        \"nucuotasugdisp\": 104000.0,'+
		'        \"nucuotaconsumida\": null,'+
		'        \"nucuotaencartera\": 0.0,'+
		'        \"nucuotapagarnormal\": 0.0,'+
		'        \"nucuotapagarplanfinan\": 0.0,'+
		'        \"nucumplecuota\": 1.0,'+
		'        \"mensaje\": \"Cuota Ok\",'+
		'        \"nombreimagen\": null,'+
		'        \"visatribute\": \"NORMAL\",'+
		'        \"nucoderror\": null,'+
		'        \"menserror\": null'+
		'    },'+
		'    \"success\": true'+
		'}';
		InterfaceCapacidadDePago obj = InterfaceCapacidadDePago.parse(json);
		System.assert(obj != null);
	}
}