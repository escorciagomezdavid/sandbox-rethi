public class JamarEtiquetaNOG {
    
    Public Class Variables {
    @invocablevariable(Label='company' required = true)
    public string company;
    @invocablevariable(Label='NumberDoc' required = true)
    public string NumberDoc;
    @invocablevariable(Label='Agency' required = true)
    public string Agency;
    @invocablevariable(Label='typeCredit' required = true)
    public string typeCredit;
    @invocablevariable(Label='Account' required = true)
    public string Account;
    @invocablevariable(Label='Process' required = true)
    public string Process;
    @invocablevariable(Label='Code' required = true)
    public string Code;
    @invocablevariable(Label='User' required = true)
    public string User;
    @invocablevariable(Label='Origin' required = true)
    public string Origin;
    @invocablevariable(Label='Record' required = true)
    public string Record;
    }
  
    @InvocableMethod(Label='Etiqueta NOG')
    public static void MethodEstablishLabelNog(list<Variables> variable){
        
        String company = variable[0].company;
        String NumberDoc = variable[0].NumberDoc;
        String Agency = variable[0].Agency;
        String typeCredit = variable[0].typeCredit;
        String Account = variable[0].Account;
        String Process = variable[0].Process;
        String Code = variable[0].Code;
        String User = variable[0].User;
        String Origin = variable[0].Origin;
        String Record = variable[0].Record;
        datetime myDateTime = datetime.now();
		
        
        
        /*Creamos un Objeto Json Con los datos enviados desde el flow
         * 
         */
        
        Map<String, Object> objNOG = new Map<String, Object>();
        objNOG.put('num_doc', NumberDoc);
        objNOG.put('agencia', Agency);
        objNOG.put('t_cre', typeCredit);
        objNOG.put('cuenta', Account);
        objNOG.put('process', Process);
        objNOG.put('code', Code);
        objNOG.put('usuario', User);
        objNOG.put('origin', Origin);
        objNOG.put('record', Record);
        
        
        
        String result = String.valueOf(JSON.Serialize(objNOG));
        System.debug('result ' + result);
     	sendRequest(result, company);
        
        
    }
    @future(callout=true)
    public static  void sendRequest(String Body, String Company){
        System.debug(JSON.Serialize(Body));
        /*
        String endPoint = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/' + company + '/TagNog/'
			*/
        try{
            
		Http http = new Http();
        HttpRequest request = new HttpRequest();
		request.setEndpoint('https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/JA/TagNog/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(Body);
        HttpResponse response = http.send(request);
        System.debug('Requets' + request.toString());
        System.debug('Response ALLL' + response.toString());    
        System.debug('Response' +  response.getStatusCode()); 
            
            
        }catch(Exception e){
            System.debug(' ERROR  ----' + e.getMessage());
            /*
            Log__c lg = new Log__c();
            lg.message__c = 'ERROR AL ENVIAR ETIQUETA NOG ' + endpoint;
            lg.type__c = 'Consumo en ws';
            lg.date__c = myDateTime;
            lg.ClassName__c = 'JamarEtiquetaNOG';
            lg.JSON__c = JSON.Serialize(objNOG);
            insert(lg);
            System.debug('.....' + lg.Id);
*/
        }
    }
    
    

}