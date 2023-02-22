@isTest
global class JamarConsultaFechaServicioMock_v2 implements HttpCalloutMock {
    Integer statusCode;
    global JamarConsultaFechaServicioMock_v2(Integer strStatusCode) {
        statusCode = strStatusCode;
    }
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if (statusCode == 200) {
            response.setBody('{"success": True, "message": "Cita asignada exitosamente"}');
            response.setStatusCode(200);
        } else if (statusCode == 400) {
            response.setBody('{"success":False, "message": "Ocurrio un error al asignar su cita"}');
            response.setStatusCode(400);
        } else {
            response.setBody('{"success":False, "message": "Internal server error"}');
            response.setStatusCode(500);
        }
        return response;
    }
}