@isTest
global class AsignarCompromisoPagoMock implements HttpCalloutMock {
	Integer statusCode;
    
    global AsignarCompromisoPagoMock(Integer strStatusCode) {
        statusCode = strStatusCode;
    }
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if (statusCode == 200) {
            response.setBody('{"success": true, "message": "Compromiso de pago creado exitosamente"}');
            response.setStatusCode(200);
        } else {
            response.setBody('{"success": false, "message": "Internal server error"}');
            response.setStatusCode(500);
        }
        return response;
    }
}