//is used to help test MJAuthenticationAPI with MJAuthenticationAPI_Test class
global class SEUSWSToken_Mock implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"success":true, "message":"Exitoso!", "needsUpdate":true,"status":"SUCCESS","msg":"Usuario verificado!","Errors":[{"error":"testerror"}],"APPtoken":"apptoken","Usuario":{"vName":"Medismart","vLastName":"WebService","vRol":"6","vMail":"e@mail.com" ,"vAvatar":"test"}}');
        response.setStatusCode(200);
        return response; 
    }
}