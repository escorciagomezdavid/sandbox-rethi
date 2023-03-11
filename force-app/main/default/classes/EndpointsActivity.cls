/*
  Name: EndpointsActivity
  Proposito: Endpoints a consultar del API Activity
  Author: Andres Tarra
  Fecha: 9/03/2023
*/
@RestResource(UrlMapping = '/v1/Activity/*')
global class EndpointsActivity {
    @HttpPost
	global static ResponseActivity createTask() {
		ResponseActivity rt = new ResponseActivity();
        MiddlewareActivity mw = new MiddlewareActivity();
        String jsonInput = '';
        try{
            RestRequest requestBody = RestContext.request;
            jsonInput = requestBody.requestBody.toString();
            mw = (MiddlewareActivity)JSON.deserialize(jsonInput, MiddlewareActivity.class);
            if(mw.Actividad != null){       
                List<TaskResponse> task = ActivityClass.CrearTarea(mw);
                rt.message = 'Exitoso';
                rt.statusCode = 200;
                rt.success = True;
                rt.data = task;                                
                return rt;            
            }else{
                rt.message = 'Error procesando el body.';
                rt.statusCode = 400;
                rt.success = False;
                return rt;
            }
        } catch(Exception e) {
            Log__c log = new Log__c();
            log.ClassName__c = 'EndpointsActivity createTask';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en WS';
            log.JSON__c = null;
            log.Empresa__c = 'Colombia';
            insert log;
            
            rt.message = 'Fallo en la peticion.';
            rt.statusCode = 400;
            rt.success = False;
            return rt;
        }
    }
    
	@HttpGet
	global static ResponseTareasCitaEntregaOp tareasCitaEntregaOp() {
		ResponseTareasCitaEntregaOp rt = new ResponseTareasCitaEntregaOp();
		RestRequest req = RestContext.request;
		try {
			String numOp = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
            List<TareaCitaOp> datos = ActivityClass.ObtenerTareasOp(numOp);
            if (datos.isEmpty()) {
                rt.message = 'No se encontraro resultado.';
                rt.statusCode = 200;
                rt.success = True;
                rt.data = datos;
                return rt;
            } else {
                rt.message = 'Exitoso';
                rt.statusCode = 200;
                rt.success = True;
                rt.data = datos;
                return rt;
            }
		}catch(Exception e) {
            Log__c log = new Log__c();
            log.ClassName__c = 'EndpointsActivity tareasCitaEntregaOp';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en WS';
            log.JSON__c = null;
            log.Empresa__c = 'Colombia';
            insert log;
            
			rt.message = 'Fallo en la peticion.';
			rt.statusCode = 400;
			rt.success = False;
			return rt;
		}
    }
    
    @HttpPatch
    global static ResponseActivity updateTask() {
        RestRequest req = RestContext.request;
        ResponseActivity rt = new ResponseActivity();
        MiddlewareActivity mw = new MiddlewareActivity();
        String numOp = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        String jsonInput = '';
        try {
            jsonInput = req.requestBody.toString();
        	mw = (MiddlewareActivity) JSON.deserialize(jsonInput, MiddlewareActivity.class);
            List<TaskResponse> datos = ActivityClass.ActualizarTarea(numOp, mw.Actividad.estado, mw.Actividad.usuario, mw.Actividad.asunto);
            if (datos.isEmpty()) {
                rt.message = 'No se encontró resultado';
                rt.statusCode = 200;
                rt.success = False;
                rt.data = null;
                return rt;
            } else {
                rt.message = datos[0].mensaje;
                rt.statusCode = 200;
                rt.success = True;
                rt.data = datos;
                return rt;
            }
        } catch(Exception e) {
            Log__c log = new Log__c();
            log.ClassName__c = 'EndpointsActivity updateTask';
            log.date__c = Datetime.now();
            log.message__c = 'Error al intentar actualizar: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en WS';
            log.JSON__c = null;
            log.Empresa__c = 'Colombia';
            insert log;
            
        	rt.message = 'Fallo en la peticion';
			rt.statusCode = 400;
            rt.data = null;
			rt.success = False;
            return rt;
		}
    }
}