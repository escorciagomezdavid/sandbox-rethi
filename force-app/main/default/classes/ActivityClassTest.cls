@isTest
public class ActivityClassTest {
	@IsTest
    public static void CrearTareaTest() {
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
		MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonmsg, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.CrearTarea(middles);
		Test.stopTest();
    }
    
    @IsTest
    public static void CrearTareaSinOpTest() {
        String identificacion = 'ID001';
		TestDataFactory.createAccount(identificacion);
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
		MiddlewareActivity middles = new MiddlewareActivity();
		middles = (MiddlewareActivity) JSON.deserialize(jsonmsg, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.CrearTarea(middles);
		Test.stopTest();
    }
    
    @IsTest
    public static void CrearTareaParametrosFaltanTest() {
        String jsonmsg = '{' +
        '"Actividad":{' +
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
		middles = (MiddlewareActivity) JSON.deserialize(jsonmsg, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.CrearTarea(middles);
		Test.stopTest();
    }
    
    @IsTest
    public static void ActualizarTareaTest() {
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
        MiddlewareActivity middles2 = new MiddlewareActivity();
		middles2 = (MiddlewareActivity) JSON.deserialize(jsonActualizar, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.ActualizarTarea(numOp, middles2.Actividad.estado, middles2.Actividad.usuario, middles2.Actividad.asunto);
		Test.stopTest();
    }
    
    @IsTest
    public static void ActualizarTareaSinOpTest() {
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
        String numOp = '';
        MiddlewareActivity middles2 = new MiddlewareActivity();
		middles2 = (MiddlewareActivity) JSON.deserialize(jsonActualizar, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.ActualizarTarea(numOp, middles2.Actividad.estado, middles2.Actividad.usuario, middles2.Actividad.asunto);
		Test.stopTest();
    }
    
    @IsTest
    public static void ActualizarTareaSinTareaTest() {
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
        String jsonActualizar = '{' +
        '"Actividad":{' +
        '"usuario":"BOT",' +
        '"asunto":"Asignación de Cita de Entrega y Armado de OP",' +
        '"estado":"Closed"' +
        '}' +
        '}';
        String numOp = '2599399';
        MiddlewareActivity middles2 = new MiddlewareActivity();
		middles2 = (MiddlewareActivity) JSON.deserialize(jsonActualizar, MiddlewareActivity.class);
		Test.startTest();
		ActivityClass.ActualizarTarea(numOp, middles2.Actividad.estado, middles2.Actividad.usuario, middles2.Actividad.asunto);
		Test.stopTest();
    }
    
    @IsTest
    public static void ObtenerTareasOpTest() {
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
		Test.startTest();
		ActivityClass.ObtenerTareasOp(numOp);
		Test.stopTest();
    }
}