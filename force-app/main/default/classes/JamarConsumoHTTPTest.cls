@Istest
public class JamarConsumoHTTPTest {
    
    @isTest static  void testGetCallout(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternal('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET',null);
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testGetCalloutWithTimeOutExternal(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternal('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET','25000');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testGetCalloutWithTimeOutAndToken(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternalWithTokenAndTimeOut('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET','25000','ajsjsjs');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testGetCalloutWithTimeOut(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternalWithTimeOut('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET','25000');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testGetCalloutBasic(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternalBasic('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testGetCalloutWithToken(){
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = JamarConsumoHTTP.callServiceExternalWithToken('https://th-apex-http-callout.herokuapp.com/animals', '', 'GET','25000');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
                            result.getHeader('Content-Type'),
                            'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');
        
    }
    
    @isTest static  void testPostCallout(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternal('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST',null);
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    } 
    
    @isTest static void testPostCalloutwithTimeOutAndToken(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTokenAndTimeOut('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST','25000','aqrujdkdi');
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    } 
    
    @isTest static  void testPostCalloutWithTimeoutExternal(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternal('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST','25000');
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    } 
    
    @isTest static  void testPostCalloutWithTimeout(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST','25000');
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    } 
    
    @isTest static  void testPostCalloutBasic(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST');
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    } 
    
    @isTest static  void testPostCalloutWithToken(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithToken('https://th-apex-http-callout.herokuapp.com/animals', '{"name":"mighty moose"}', 'POST','25000');
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}