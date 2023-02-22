public with sharing class AssignmentAdviserCredit {
    public AssignmentAdviserCredit() {

    }
    @AuraEnabled()
    public static String processAdviserCredit(String idOportunity) {
        List<OpportunityTeamMember> member = [SELECT Id FROM OpportunityTeamMember WHERE OpportunityId =: idOportunity AND TeamMemberRole =: 'Credit Rep'];
        String outputvar = '';
        if(member.size() == 0){
            OpportunityTeamMember opMember = new OpportunityTeamMember();
            opMember.OpportunityId = idOportunity;
            opMember.OpportunityAccessLevel = 'Edit';
            opMember.TeamMemberRole = 'Credit Rep';
            opMember.UserId = UserInfo.getUserId();
            insert opMember;
            List<Opportunity> op = [SELECT ID, Assigned__c FROM Opportunity WHERE Id =:idOportunity];
            op[0].Assigned__c = True;
            op[0].Asesor_de_credito__c = UserInfo.getName();
            update op[0];
            outputvar = ' Asignado Correctamente';
        }else{
            outputvar = ' Existe Representante de Credito Asignado';
        }
        return outputvar;
    }
}