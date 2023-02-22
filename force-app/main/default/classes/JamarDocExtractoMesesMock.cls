@isTest
global class JamarDocExtractoMesesMock implements HttpCalloutMock  {
    
     global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"id":69833177,"month":"03/2022"},{"id":69833178,"month":"02/2022"},{"id":69833179,"month":"01/2022"}]');
    	response.setStatusCode(200);
        return response;
    }

}