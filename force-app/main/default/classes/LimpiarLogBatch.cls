global class LimpiarLogBatch implements Database.Batchable<sObject>, Schedulable, Database.Stateful {

    //Variable Section
    global FINAL String query;
	global Integer contador = 0;
    global List<String> errorMessages = new List<String>();
    
    global LimpiarLogBatch(){
    }

    //Se consultan los Closing con fecha de proxima alerta el dia de hoy
    global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([SELECT ID FROM Log__c WHERE dias_registro__c >= 0 Order by dias_registro__c DESC Limit 9999]);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scopeList) {
    /* 
	//Programar esta tarea
	LimpiarLogBatch  m = new LimpiarLogBatch ();
	String sch = '0 0 00 * * ?';
	String jobID = system.schedule('Eliminacion de registros de Log', sch, m);
	*/    
        List<Log__c> LogRecords = (List<Log__c>) scopeList;
		
        if(!LogRecords.isEmpty()){
			contador = contador + LogRecords.size();           
			Delete LogRecords;
        }
    }  

    global void finish(Database.BatchableContext BC) {
        AsyncApexJob aaj = [Select Id, Status, NumberOfErrors, JobItemsProcessed, MethodName, TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //String[] toAddresses = new String[] {aaj.CreatedBy.Email};
		String[] toAddresses = new String[] {'bsilvera@jamar.com'};        
		mail.setToAddresses(toAddresses);
        mail.setSubject('JOB Salesforce - Eliminacion de registros de LOG: ' + aaj.Status);
        String bodyText='<b>Lotes totales : </b>' + aaj.TotalJobItems + '<br/><b>Procesados : </b>' + aaj.JobItemsProcessed + '<br/><b>Errores : </b>'+ aaj.NumberOfErrors + '.<br/>';
        bodyText += '<b>Total registros eliminados : </b>' + contador + '<br/>';
        mail.setHtmlBody(bodyText);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    //Method which schedules the ProductDownloadBatch
    global void execute(SchedulableContext sc) {
        LimpiarLogBatch snInstance = new LimpiarLogBatch();
        ID batchprocessid = Database.executeBatch(snInstance);
    }
}