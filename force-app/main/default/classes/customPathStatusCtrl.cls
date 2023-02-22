public class customPathStatusCtrl {
  
    @AuraEnabled
    public static Opportunity stageNamePath(String recId){
        Opportunity stageList = [Select Id, Name, CompletionStages__c, StageName, CloseDate, ForecastCategoryName, Probability From Opportunity Where Id=:recId];
        system.debug('stageList ' + stageList);
        return stageList;
    }
     
    @AuraEnabled
    public static Opportunity saveOpportunitty(String OpportunityId, String stageName){
        Opportunity Opportunity = [Select Id, Name, CompletionStages__c, StageName, CloseDate, ForecastCategoryName, Probability From Opportunity Where Id=:OpportunityId];
        system.debug('Opportunity ' + Opportunity);
        Opportunity.CompletionStages__c = stageName;
        
        update Opportunity;
        return Opportunity;
    }
}