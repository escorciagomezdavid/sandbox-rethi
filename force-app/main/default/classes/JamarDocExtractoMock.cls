@isTest
global class JamarDocExtractoMock implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"url": ["https://jamar-pdf-dev.s3.amazonaws.com/extractos_portal/202203_1129567580.PDF"]}');
    	response.setStatusCode(200);
        return response;
    }

}