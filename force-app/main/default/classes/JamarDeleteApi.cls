public class JamarDeleteApi {
	@invocablevariable(Label='id')
    public string id;
    
    @InvocableMethod(Label='Delete Lead')
    public static void RecibeDeleteLead(list<JamarDeleteApi> variable){
    	 String id = variable[0].id;
         MethodDeleteLead(id);
		
    }
    @future (callout=true)
    public static void MethodDeleteLead(String id){
        
        List<Lead> leadToDel = [SELECT Name FROM Lead WHERE Id = :id];
            if ( leadToDel != null && !leadToDel.isEmpty() ){
               try{
                     delete leadToDel;
                     System.debug('Si se encontro datos');
              }
        Catch(DmlException e){
        // handle exception
        	System.debug(e.getMessage());
        	}
        }
    }
}