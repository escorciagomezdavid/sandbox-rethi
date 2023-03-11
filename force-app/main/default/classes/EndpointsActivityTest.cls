@isTest
public class EndpointsActivityTest {
	@isTest
    public static void createTaskTest(){
        String jsonmsg = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Open",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(jsonmsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseActivity response = EndpointsActivity.createTask();
		Test.stopTest();
    }
    
    @isTest
    public static void createTaskSinBodyTest(){
        String jsonmsg = '';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(jsonmsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseActivity response = EndpointsActivity.createTask();
		Test.stopTest();
    }
    
    @isTest
    public static void updateTaskTest(){
        String jsonCrear = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Open",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonCrear, MiddlewareActivity.class);
        ActivityClass.CrearTarea(middles);
        
        String jsonActualizar = '{' +
        '"Actividad":{' +
        '"usuario":"BOT",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"estado":"Closed"' +
        '}' +
        '}';
        String numOp = '2599399';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'PATCH';
        req.requestBody = Blob.valueof(jsonActualizar);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseActivity response = EndpointsActivity.updateTask();
		Test.stopTest();
    }
    
    @isTest
    public static void updateTaskSinBodyTest(){
        String jsonCrear = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Open",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonCrear, MiddlewareActivity.class);
        ActivityClass.CrearTarea(middles);
        
        String jsonActualizar = '';
        String numOp = '2599399';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'PATCH';
        req.requestBody = Blob.valueof(jsonActualizar);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseActivity response = EndpointsActivity.updateTask();
		Test.stopTest();
    }
    
    @isTest
    public static void updateTaskSinResultadoTest(){
        String jsonCrear = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Closed",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonCrear, MiddlewareActivity.class);
        ActivityClass.CrearTarea(middles);
        
        String jsonActualizar = '{' +
        '"Actividad":{' +
        '"usuario":"BOT",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"estado":"Closed"' +
        '}' +
        '}';
        String numOp = '2599399';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'PATCH';
        req.requestBody = Blob.valueof(jsonActualizar);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseActivity response = EndpointsActivity.updateTask();
		Test.stopTest();
    }
    
    @isTest
    public static void getTaskTest(){
        String jsonCrear = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Open",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonCrear, MiddlewareActivity.class);
        ActivityClass.CrearTarea(middles);
        
        String numOp = '2599399';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseTareasCitaEntregaOp response = EndpointsActivity.tareasCitaEntregaOp();
		Test.stopTest();
    }
    
    @isTest
    public static void getTaskSinOpTest(){
        String jsonCrear = '{' +
        '"Actividad":{' +
        '"identificacion":"ID001",' +
        '"usuario":"0054O00000A10KNQAZ",' +
        '"numeroOp":"2599399",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"comentario":"Tarea enviada por petición API",' +
        '"estado":"Open",' +
        '"fechaVencimiento":"2023-02-27"' +
        '}' +
        '}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonCrear, MiddlewareActivity.class);
        ActivityClass.CrearTarea(middles);
        
        String numOp = '';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseTareasCitaEntregaOp response = EndpointsActivity.tareasCitaEntregaOp();
		Test.stopTest();
    }
    
    @isTest
    public static void getTaskSinTareaTest(){
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        
        String numOp = '2599399';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/v1/Activity/' + numOp;
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
		ResponseTareasCitaEntregaOp response = EndpointsActivity.tareasCitaEntregaOp();
		Test.stopTest();
    }
}