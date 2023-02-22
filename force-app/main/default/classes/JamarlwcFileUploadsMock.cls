@isTest
global class JamarlwcFileUploadsMock implements HttpCalloutMock{
Integer statusCode;
	global JamarlwcFileUploadsMock(Integer strStatusCode) {
		statusCode = strStatusCode;
	}
	global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
		if (statusCode == 201) {
			response.setBody('{"success": true,"urls": "https://portal-cliente-garantia-fotos-prd.s3.amazonaws.com/1110009_12112_122121_1668052815110_0.png"}');
			response.setStatusCode(201);
		} else if (statusCode == 400) {
			response.setBody('{"success":False,"message":"No se encuentra la bodega rda"}');
			response.setStatusCode(400);
		} else {
			response.setBody('{"message":"Internal server error"}');
			response.setStatusCode(500);
		}
		return response;
	}
}