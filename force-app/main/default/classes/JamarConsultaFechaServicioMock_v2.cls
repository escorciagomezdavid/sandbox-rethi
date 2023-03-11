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
            response.setBody('{"success": true,"TIPO_CALENDARIO": "N", "COD_BOD_ENTRADA": "14", "COD_BOD_SALIDA": "72","fechasCalendario": [{"FECHA_PICKING_E": "2022-06-29","FECHA_ENTREGA": "2022-06-30"}]}');
            response.setStatusCode(200);
        } else if (statusCode == 400) {
            response.setBody('{"success": False, "message": "No se encuentra la bodega rda"}');
            response.setStatusCode(400);
        } else {
            response.setBody('{"success": False, "message": "Internal server error"}');
            response.setStatusCode(500);
        }
        return response;
    }
}