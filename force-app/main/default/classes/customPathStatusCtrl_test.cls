@isTest
public class customPathStatusCtrl_test {
	public static testMethod void TestSOQL() 
	{
		Opportunity OP = new Opportunity();
		// Add all required field
		OP.Name='demo';
		OP.CompletionStages__c = 'VALIDACION_IDENTIDAD';
        OP.StageName = 'Completación de Crédito';
        OP.CloseDate = Date.newInstance(2022, 12, 12);
        OP.ForecastCategoryName = 'Pipeline';
        OP.Probability = 40;
		insert OP;
        
        Opportunity OP2 = new Opportunity();
        OP2 = [Select Id, Name From Opportunity Where Name=:'demo'];
        
        String ID = OP2.Id;
		
        Opportunity testOP = new Opportunity();
        testOP = customPathStatusCtrl.stageNamePath(ID);
		System.assert( testOP  != null);
	}
    
    public static testMethod void TestSOQL2() 
	{
        Opportunity OP = new Opportunity();
		// Add all required field
		OP.Name='demo';
		OP.CompletionStages__c = 'ACCION_SUGERIDA';
        OP.StageName = 'Completación de Crédito';
        OP.CloseDate = Date.newInstance(2022, 12, 12);
        OP.ForecastCategoryName = 'Pipeline';
        OP.Probability = 40;
		insert OP;
        
       	Opportunity OP2 = new Opportunity();
        OP2 = [Select Id, Name From Opportunity Where Name=:'demo'];
        
        String ID = OP2.Id;
        
        Opportunity opp = [Select Id, Name, CompletionStages__c, StageName, CloseDate, ForecastCategoryName, Probability From Opportunity Where Id=:ID];
        opp.CompletionStages__c = 'VALIDACION_IDENTIDAD';
        
        System.test.startTest();
        update opp;
        Opportunity testOP = new Opportunity();
        testOP = customPathStatusCtrl.saveOpportunitty(ID, 'VALIDACION_IDENTIDAD');
		System.assert( testOP  != null);
        System.test.stopTest();
    }
}