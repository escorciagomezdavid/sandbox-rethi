@isTest
global class ProductosOpMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"id": 10242703,"company": "JA","sku": "7021603","assetid": "789620","public_url": "https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789620.jpeg","type":  '+ 
               '"PrimaryProductImage","uploaded": "2021-07-13 01:00:08"}]');
    	response.setStatusCode(200);
        return response;
    }

}