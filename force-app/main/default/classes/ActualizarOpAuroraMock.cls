@isTest
global class ActualizarOpAuroraMock implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
		response.setBody('{"disponible": true}');
		response.setStatusCode(200);
		return response;
	}
}