@isTest
global class JamarAsignacionEntregaCambioMock implements HttpCalloutMock {
	Integer statusCode;
    global JamarAsignacionEntregaCambioMock(Integer strStatusCode) {
        statusCode = strStatusCode;
    }
    global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
        if (statusCode == 200) {
            response.setBody('{"success": True, "message": "Cita asignada exitosamente"}');
			response.setStatusCode(200);
        } else if (statusCode == 400) {
            response.setBody('{"success": False, "message": "No se encuentra la orden de pedido con ese producto"}');
            response.setStatusCode(400);
        } else {
            response.setBody('{"success": False, "message": "Internal server error"}');
            response.setStatusCode(500);
        }
		return response;
	}
}