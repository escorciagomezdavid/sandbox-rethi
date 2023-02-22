@isTest
global class HttpMock implements HttpCalloutMock{
    Integer statusCode;
    String body1;

	global HttpMock(Integer strStatusCode,String body) {
		statusCode = strStatusCode;
        body1 = body;
	}
    global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
            if (statusCode == 200) {
                System.debug(body1);
                response.setBody(body1);
                response.setStatusCode(200);
            } else if (statusCode == 400) {
                response.setBody(body1);
                response.setStatusCode(400);
            } else {
                response.setBody('{"message":"Internal server error"}');
                response.setStatusCode(500);
            }

		return response;
	}
}