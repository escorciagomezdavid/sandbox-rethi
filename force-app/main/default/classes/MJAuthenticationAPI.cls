public class MJAuthenticationAPI{

    public static Authentication getAccessToken(string username, string password, string endPoint){
        
       //Primero valida si ya hay un token existente y lo devuelve
      	List<SEUSAuthToken__c> token;
		SEUSAuthToken__c MyToken;
       	If(endpoint == label.SEUSWSToken){
			token = [Select id,FechaDeExpiracion__c,Token__c from SEUSAuthToken__c where Name = 'Token Actual' AND Propiedad__c = 'SEUS' limit 1];
		}
		
        IF(token != null && token.size() != 0){
			system.debug('TOKEN: Existe un registro de Token');
			MyToken = token.get(0);
			if(MyToken.FechaDeExpiracion__c!=null){
				Long dt1Long  = MyToken.FechaDeExpiracion__c.getTime();
				Long dt2Long  = datetime.now().getTime();
				Long milliseconds = dt1Long - dt2Long;
				Long minutos = milliseconds / 1000 / 60 ;
				If(minutos >= 0 ){// diferencia de más 0 minutos entre fechas indica que es todavía valido.
					system.debug('TOKEN: El Token aún es válido...Le quedan '+minutos+' minutos.');
					Authentication auth = new Authentication();
					auth.token = MyToken.Token__c;
					auth.needsUpdate = false;				
					return auth;
				}else{
					system.debug('TOKEN: El Token no es válido , se debe actualizar.');
				}
			}
        }else{
			system.debug('TOKEN: Aun no hay un Token, crearlo.');
			MyToken = new SEUSAuthToken__c(Name='Token Actual',Propiedad__c='SEUS');
		}
        
        //si se necesita generar un nuevo token...
		
		Authentication auth = new Authentication();			
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		req.setEndpoint(endPoint);
		req.setHeader('Content-Type','application/json');
		req.setMethod('POST');
		requestBody model = new requestBody();
		model.user 	= username;
		model.c_emp	= 'JA';
		model.password	= password;	
		req.setbody(JSON.serialize(model));
		system.debug('TOKEN: El Body es '+req.getBody());
		req.setTimeout(120000);

		try{
			res = http.send(req);
			auth = parseAuthentication(res.getBody());
			auth.NeedsUpdate = true;
			//Se inserta/actualiza el token
			Integer minutos = 1800000 / 1000 / 60;
			DateTime myDateTime = datetime.now();
            MyToken.FechaDeExpiracion__c = myDateTime.addMinutes(minutos);
			MyToken.Token__c = auth.token;
			/**Upsert MyToken;**/		
			system.debug('TOKEN: La respuesta es ' + auth);
		}catch(Exception e){
			System.debug('TOKEN: Hubo un error. Causa: '+e.getCause() + ' Mensaje: '+ e.getMessage()); 
			MJEmailManager.sendError('**Hubo un error en el metodo getAccessToken - AUTHORIZATION ERROR: '+auth+', Response: '+res+', Endpoint: '+endPoint+', Error Exception: '+e.getMessage());
			//registrar error en bitacora
			Log__c logError=new Log__c(type__c=LABEL.LogTypeConsumo ,success__c=auth.success, message__c=auth.message,ClassName__c='MJAuthenticationAPI');
			//insert logError;
		}
        return auth;		
    }
    
    public static Authentication parseAuthentication(String json) {
       return (Authentication) System.JSON.deserialize(json, Authentication.class);
   	}
       
    public class Authentication{
		public boolean success;
		public string message;
		public string messageLog;
		public Data data;
        public String token;
        public String token_time;        
        public boolean needsUpdate; // indicador que indica a la última funcion si necesita hacer update al token en la base de datos. Osea es nuevo.
        	
        public void upsertToken(){
            SEUSAuthToken__c MyToken = [Select id,FechaDeExpiracion__c,Token__c from SEUSAuthToken__c where Name = 'Token Actual' AND Propiedad__c = 'SEUS' limit 1];
            MyToken.Token__c = token;
			//agregar la cantidad de milisegundos de duracion del token , 1800 milisegundos segun definicion			
			Integer minutos = 1800000 / 1000 / 60;
			DateTime myDateTime = datetime.now();
            MyToken.FechaDeExpiracion__c = myDateTime.addMinutes(minutos);
			system.debug('TOKEN: El token necesitaba actualizarse :D');
            Upsert MyToken;
        }		
	}
	
	public class Data {
		public Usuario usuario;
	}
	
	public class Usuario {
		public String NOMBRE;
		public String USUARIO;
	}

	public class requestBody{
		public String user;
		public String c_emp;
		public String password;			
	}
    
    
}