@isTest
public class endpointCase2_Test {
    
    @isTest
    public static void EndpointsCase(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1140849709', 'JA');
        String JsonMsg = '{' +
            '"Caso" : {' +
            '"identificacion":"1140849709",' +
            '"codigoProducto":"7018728",' +
            '"numeroOp":"25993995",' +
            '"proceso":"VALIDACION GARANTIA"' +
            '}' +
            '}';
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v2/Case/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseCase response = EndpointsCase2.crearCaso();
		Test.stopTest();
        
    }
    
    
     @isTest
    public static void EndpointsCaseWithOutCodigoProducto(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1140849709', 'JA');
        String JsonMsg = '{' +
            '"Caso" : {' +
            '"identificacion":"1140849709",' +
            '"numeroOp":"25993995",' +
            '"proceso":"VALIDACION GARANTIA"' +
            '}' +
            '}';
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v2/Case/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
       Test.startTest();
		ResponseCase response = EndpointsCase2.crearCaso();
		Test.stopTest();
        
    }
    @isTest
    public static void EndpointsCasClientNotFound(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1140849709', 'JA');
        String JsonMsg = '{' +
            '"Caso" : {' +
            '"identificacion":"1140849701",' +
            '"numeroOp":"25993995",' +
            '"proceso":"VALIDACION GARANTIA"' +
            '}' +
            '}';
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v2/Case/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseCase response = EndpointsCase2.crearCaso();
		Test.stopTest();
        
    }
    
     @isTest
    public static void EndpointsWithOutObjectCasos(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1140849709', 'JA');
        String JsonMsg = '{' +
            '"Case" : {' +
            '"identificacion":"1140849709",' +
            '"numeroOp":"25993995",' +
            '"proceso":"VALIDACION GARANTIA"' +
            '}' +
            '}';
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v2/Case/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseCase response = EndpointsCase2.crearCaso();
		Test.stopTest();
        
    }
    
     @isTest
    public static void EndpointFail(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1140849709', 'JA');
        String JsonMsg = '{' +
            '"Case" : {' +
            '"identificacion":"1140849709",' +
            '"numeroOp":"25993995",' +
            '"proceso":"VALIDACION GARANTIA"' +
            '' +
            '}';
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v2/Case/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseCase response = EndpointsCase2.crearCaso();
		Test.stopTest();
        
    }

}