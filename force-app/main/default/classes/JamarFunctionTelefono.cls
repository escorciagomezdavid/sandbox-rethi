public class JamarFunctionTelefono {
    
    @invocablevariable(Label='company' required = true)
    public string company;
    @invocablevariable(Label='Phone' required = true)
    public string Phone;
    @invocablevariable(Label='NumberDoc' required = true)
    public string NumberDoc;
    @invocablevariable(Label='Process' required = true)
    public string Process;
    @invocablevariable(Label='User' required = true)
    public string User;
    @invocablevariable(Label='Origin' required = true)
    public string Origin;
    @invocablevariable(Label='Record' required = true)
    public string Record;
    
    
     @InvocableMethod(Label='Funcion Desactivar / Activar Telefono')
    public static void MethodEstablishLabelNog(list<JamarFunctionTelefono> variable){
        
        String company = variable[0].company;
        String Phone = variable[0].Phone;
        String NumberDoc = variable[0].NumberDoc;
        String Process = variable[0].Process;
        String User = variable[0].User;
        String Origin = variable[0].Origin;
        String Record = variable[0].Record;
		
        
        
        /*Creamos un Objeto Json Con los datos enviados desde el flow
         * 
         */
        
        Map<String, Object> telefono = new Map<String, Object>();
        telefono.put('phone', phone);
        telefono.put('num_doc', NumberDoc);
        telefono.put('process', Process);
        telefono.put('usuario', User);
        telefono.put('origin', Origin);
        telefono.put('record', Record);
        
        
        String result = String.valueOf(JSON.Serialize(telefono));
        System.debug('result ' + result);
     	sendRequest(result, company);
        
        
    }
     @future(callout=true)
    public static  void sendRequest(String Body, String Company){
        System.debug(JSON.Serialize(Body));
        
        String endPoint = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/' + company + '/phone/';
		
        try{
            
		Http http = new Http();
        HttpRequest request = new HttpRequest();
		request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(Body);
        HttpResponse response = http.send(request);
        System.debug('Requets' + request.toString());
        System.debug('Response ALLL' + response.toString());    
        System.debug('Response' +  response.getStatusCode()); 
            
            
        }catch(Exception e){
            System.debug(' ERROR  ----' + e.getMessage());
            datetime myDateTime = datetime.now();
            Log__c lg = new Log__c();
            lg.message__c = 'ERROR AL ENVIAR TELEFONO ' + endPoint;
            lg.type__c = 'Consumo en ws';
            lg.date__c = myDateTime;
            lg.ClassName__c = 'JamarFunctionTelefono';
            lg.JSON__c = JSON.Serialize(Body);
            insert(lg);
            System.debug('.....' + lg.Id);

        }
    }

}