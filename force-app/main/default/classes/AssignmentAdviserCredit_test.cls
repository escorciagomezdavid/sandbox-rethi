@isTest
public class AssignmentAdviserCredit_test {
    
    @isTest
    public static void updateOpportunityIdOp(){
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
        list<Opportunity> op = [SELECT ID FROM Opportunity where IdOP__c =: 'JA_001'];
        Test.startTest();
        AssignmentAdviserCredit.processAdviserCredit(op[0].id);
        Test.stopTest();
    }

}