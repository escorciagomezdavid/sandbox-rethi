@isTest
public class ReasignacionMassiveRethi_test {
    
     @isTest
    public static void getOpportunityWithIdOp_test(){
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_OP_1', 'SinUrl');
        
        List<Opportunity> op = [SELECT Id FROM Opportunity WHERE IdOp__c =: 'JA_OP_1'];
        
        
  
        
        
      Test.startTest();
      Test.setCurrentPage(Page.ReAssignedOportunities);
      ApexPages.StandardSetController standardController = new ApexPages.StandardSetController(op);
      standardController.setSelected(op);
      ReasignacionMassiveRethi ow = new ReasignacionMassiveRethi(standardController);
      Test.stopTest();
        
    }

}