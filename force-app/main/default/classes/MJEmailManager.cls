public with sharing class MJEmailManager{
    
    private static OrgWideEmailAddress getOrgWEAddress(){
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress 
                                    /** where Address =: LABEL.OrgWideEmailAddress ***/ limit 1];
        
        return owea;
    }       
    
    public static void sendError(string errorMessage){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setOrgWideEmailAddressId(getOrgWEAddress().Id);
        
        Date tDay = Date.today();        
        string day, month, year;
        
        day     =   (tDay.day()<10?'0'+tDay.day():tDay.day().format()).remove(',');
        month   =   (tDay.month()<10?'0'+tDay.month():tDay.month().format()).remove(',');
        year    =   tDay.year().format().remove(',');
        
        email.setToAddresses(new string[]{'lespinoza@fastcloudconsulting.com'});
        email.setSubject('Error: ' +year+'-'+month+'-'+day);        
        email.setHtmlBody(errorMessage);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });  
    }

    
}