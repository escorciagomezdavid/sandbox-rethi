@isTest
public class EndpointsCase_test {

	@isTest
	public static void EndpointsCase() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		String JsonMsg = '{' +
		'"Caso" : {' +
		'"identificacion":"1140849709",' +
		'"codigoProducto":"7018728",' +
		'"numeroOp":"25993995",' +
		'"proceso":"VALIDACION GARANTIA"' +
		'}' +
		'}';


		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/v1/Case/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseCase response = EndpointsCase.validarTipoGarantia();
		Test.stopTest();

	}

	@isTest
	public static void EndpointsCaseWithOutCodigoProducto() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		String JsonMsg = '{' +
		'"Caso" : {' +
		'"identificacion":"1140849709",' +
		'"numeroOp":"25993995",' +
		'"proceso":"VALIDACION GARANTIA"' +
		'}' +
		'}';


		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/v1/Case/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseCase response = EndpointsCase.validarTipoGarantia();
		Test.stopTest();

	}
	@isTest
	public static void EndpointsCasClientNotFound() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		String JsonMsg = '{' +
		'"Caso" : {' +
		'"identificacion":"1140849701",' +
		'"numeroOp":"25993995",' +
		'"proceso":"VALIDACION GARANTIA"' +
		'}' +
		'}';


		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/v1/Case/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseCase response = EndpointsCase.validarTipoGarantia();
		Test.stopTest();

	}

	@isTest
	public static void EndpointsWithOutObjectCasos() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		String JsonMsg = '{' +
		'"Case" : {' +
		'"identificacion":"1140849709",' +
		'"numeroOp":"25993995",' +
		'"proceso":"VALIDACION GARANTIA"' +
		'}' +
		'}';


		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/v1/Case/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseCase response = EndpointsCase.validarTipoGarantia();
		Test.stopTest();

	}

	@isTest
	public static void EndpointFail() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		String JsonMsg = '{' +
		'"Case" : {' +
		'"identificacion":"1140849709",' +
		'"numeroOp":"25993995",' +
		'"proceso":"VALIDACION GARANTIA"' +
		'' +
		'}';


		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/v1/Case/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseCase response = EndpointsCase.validarTipoGarantia();
		Test.stopTest();

	}

	@isTest
	public static void EnpointCaseGetEmpty() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		RestRequest request = new RestRequest();
        request.requestUri =
            'v1/Case/1140849709';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
		Test.startTest();
        ResponseTrackingCase response = EndpointsCase.TrackingCaso();
		Test.stopTest();
	}

	@isTest
	public static void EnpointCaseGet() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		RestRequest request = new RestRequest();
        request.requestUri =
            'v1/Case/1140849709';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
		Test.startTest();
		Account getCuenta = [Select ID from Account where Identificacion__c = '1140849709'];
		TestDataFactory.crearCaseGarantiaSinOp(getCuenta.Id, 'SERVICIO DE GARANTIA', 'Abierto');
        ResponseTrackingCase response = EndpointsCase.TrackingCaso();
		Test.stopTest();
	}

	@isTest
	public static void EnpointCaseGetFail() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		RestRequest request = new RestRequest();
        request.requestUri =
            'v1/Case/**';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
		Test.startTest();
        ResponseTrackingCase response = EndpointsCase.TrackingCaso();
		Test.stopTest();
	}
	@isTest
	public static void EnpointCaseGetSinidentificacion() {
		TestDataFactory.createAgencia();
		TestDataFactory.createDepartamento();
		TestDataFactory.createAccountCustom('1140849709', 'JA');
		RestRequest request = new RestRequest();
		String identificacion;
        request.requestUri =
            'v1/Case/' + identificacion;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
		Test.startTest();
        ResponseTrackingCase response = EndpointsCase.TrackingCaso();
		Test.stopTest();
	}
}