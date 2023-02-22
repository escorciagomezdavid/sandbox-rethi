@isTest
public with sharing class JFSL_MyScheduler_Test {
    @isTest
    static void running() {
        Account addr = New Account(LastName='Astro', Empresa__c='JA',Identificacion__c='12345',IdCliente__c='12345');
        insert addr;
        WorkOrder orden = New WorkOrder(AccountId=addr.Id);
        insert orden;
        FSL__Scheduling_Policy__c poliza = new FSL__Scheduling_Policy__c(Name='Customer First');
        insert poliza;

        List<Datetime> fechas = JFLS_asignacionCita_ctr.datosHorario();
        

        ServiceAppointment cita = New ServiceAppointment(ParentRecordId=orden.Id, ContactId =orden.ContactId, Status = 'Ninguno', //creacion de cita
        FSL__Scheduling_Policy_Used__c =poliza.Id, ArrivalWindowStartTime = fechas[0]
        ,ArrivalWindowEndTime = fechas[1],EarliestStartTime = fechas[0],DueDate = fechas[1]
        ,Street=addr.BillingStreet,City=addr.BillingCity,Country=addr.BillingCountry,PostalCode=addr.BillingPostalCode,geocodeAccuracy = 'Street');
        
        insert cita;
        
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute() + 1); 
        String ss = String.valueOf(Datetime.now().second());
                    if(min=='60'){
                        Integer intVal = Integer.ValueOf(hour)+1;
                        min = '00';
                        hour = String.valueOf(intVal);
                    }
                    //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        JFSL_MyScheduler sc = new JFSL_MyScheduler(cita.Id);
        System.schedule('Test', nextFireTime, sc);
        orden.JFSL_GenerarCita__c = TRUE;
        update orden;


    }
}