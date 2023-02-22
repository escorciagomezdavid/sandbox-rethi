@isTest
global class JamarAsignacionCitaServicioMock implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
		response.setBody('{"success":true,"message":"Cita asignada exitosamente"}');
		response.setStatusCode(200);
		return response;
	}
}