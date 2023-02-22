@isTest
global class JamarConsultaFechaServicioMock implements HttpCalloutMock {
	Integer statusCode;
	global JamarConsultaFechaServicioMock(Integer strStatusCode) {
		statusCode = strStatusCode;
	}
	global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
		if (statusCode == 200) {
			response.setBody('{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}');
			response.setStatusCode(200);
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