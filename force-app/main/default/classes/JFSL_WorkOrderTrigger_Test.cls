/*************************************************************************
Nombre de la Clase: JFSL_WorkOrderTrigger_Test
Versión : 1.0
Fecha de Creación :  20 Agosto 2022
Clase que cubre: JFSL_WorkOrderTrigger, JFSL_WorkOrderTriggerTrigger_Handler
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Brandon Toledo         20/08/2022       Versión Original
*************************************************************************/


@isTest
public with sharing class JFSL_WorkOrderTrigger_Test {
    @TestSetup
    static void makeData(){
        Account acc = New Account(LastName='Astro', Empresa__c='JA',Identificacion__c='12345',IdCliente__c='12345');
        insert acc;
        WorkOrder orden = New WorkOrder(AccountId=acc.Id);
        insert orden;
        WorkType tipoTrabajo = new WorkType(Name = 'Detalles de pintura',DurationType='Hours',EstimatedDuration=40);
        insert tipoTrabajo;
        WorkOrderLineItem partida = new WorkOrderLineItem(WorkTypeId=tipoTrabajo.Id, WorkOrderId = orden.Id);
        insert partida;
        FSL__Scheduling_Policy__c poliza = new FSL__Scheduling_Policy__c(Name='Customer First');
        insert poliza;
    }

    @IsTest
    static void testTrigger(){
        Account acc = [SELECT Id,Name FROM Account WHERE LastName = 'Astro'];
        WorkOrder orden = [SELECT Id,AccountId,JFSL_Generacion_Cita__c FROM WorkOrder WHERE AccountId=:acc.Id];
        orden.JFSL_GenerarCita__c = true;
        Test.startTest();
        update orden;
        Test.stopTest();
        ServiceAppointment cita = [SELECT Id, ParentRecordId FROM ServiceAppointment WHERE ParentRecordId =:orden.Id];
        System.assert(cita!=NULL);
    }
}