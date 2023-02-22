@isTest
global class Generic_response_mock implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{ "ps_nucoderror": 20, "ps_vcmenserror": "La cita a asignar debe ser mayor al dia actual"}');
    	response.setStatusCode(200);
        return response;
    }

}