@isTest
global class JamarConsultaFechaEntregaMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"erroCode": null, "errorMessage": null, "response": { "success": true, "message": "Ok", "data": [ { "Fechas": [ { "Fecha": "2022-10-03", "Estado": "S" }, { "Fecha": "2022-10-04", "Estado": "S" }, { "Fecha": "2022-10-05", "Estado": "S" }, { "Fecha": "2022-10-06", "Estado": "S" }, { "Fecha": "2022-10-07", "Estado": "S" }, { "Fecha": "2022-10-08", "Estado": "S" } ] } ] } }');
    	response.setStatusCode(200);
        return response;
    }

}