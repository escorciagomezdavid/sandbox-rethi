public class UtilitiesClass {
    
    
    
    public static Boolean validations(MiddlewareClass middleware ){
        
        validateOrigenes(middleware.Record.origen);
        if(middleware.Oportunidad != null){
             validateOrigenes(middleware.Oportunidad.origen);
        }
        if(!validateEmail(middleware.Record.correoElectronico)){
            middleware.Record.correoElectronico = '';
        }
        return True;
        
    }
    public static Boolean validateEmail(String email) {
        Boolean res = true;
        
        
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: http://www.regular-expressions.info/email.html
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        
        if (!MyMatcher.matches()){
            res = false;
            //throw new CustomException('Error al intentar procesar la solicitud. Email incorrecto. ');
        }
        return res;	
    }
    
    public static Boolean validateOrigenes(String origen){
     	String origenes = System.Label.Origen;
        List<String> setOrigenes = origenes.split(';');
        if(!setOrigenes.contains(origen)){
            throw new CustomException('Error al intentar procesar la solicitud. Origen incorrecto.' + origen + ':' + origenes);
        }
        
        return True;
    }

    public static void crearLog(string type, string empresa, String className, String mensaje, String body){
            Log__c log = new Log__c();
            log.ClassName__c = className;
            log.date__c = Datetime.now();
            log.message__c = mensaje;
            log.success__c = false;
            log.type__c = type;
            log.JSON__c = body;
            if(empresa =='JA'){
                log.Empresa__c = 'Colombia';
            }else if(empresa =='JP'){
                log.Empresa__c = 'Panamá';
            } 
            insert log;               
    }
    
}