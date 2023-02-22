@isTest
public class LimpiarLogBatch_Test {  
    
    public static testmethod void testBatch(){

		Date fecha = system.today();
		fecha = fecha.addDays(-8);
        Log__c LogRecord = new Log__c(message__c='test' , type__c='Registro' , date__c=fecha);
		Insert LogRecord;
		
        test.startTest();
		LimpiarLogBatch  m = new LimpiarLogBatch ();
		String sch = '0 0 17 * * ?';
		String jobID = system.schedule('Limpiar Log', sch, m);
		
		Id batchInstanceId = Database.executeBatch(new LimpiarLogBatch(),1);
        test.stopTest();
	}
}