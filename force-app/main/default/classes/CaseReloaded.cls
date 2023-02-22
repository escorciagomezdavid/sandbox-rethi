public class CaseReloaded {
    @AuraEnabled   
    public static RecordType getRecordTypeId(string recordTypeName)
    {
        return [select id From RecordType where sobjectType='Case' And Name =: recordTypeName limit 1];
    }
    
}