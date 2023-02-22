/*************************************************************************
Nombre de la Clase:     JFSL_WorkOrderTrigger_Handler
Versión :               1.0
Fecha de Creación :     19 Agosto 2022
Funcionalidad :         Handler en conjunto que agenda una cita a partir del campo checkbox
Clase de Prueba:        JFSL_WorkOrderTrigger_Test

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Brandon Toledo         08/08/2022       Versión Original
* Carlos Bolívar         29/08/2022       Optimización de proceso de ejecución general de la clase (Se omitieron llamadas a métodos no necesarios)

*************************************************************************/
public with sharing class JFSL_WorkOrderTrigger_Handler {
    public List<WorkOrder> newListWorkOrder;
    public List<WorkOrder> oldListWorkOrder;
    Map<Id,WorkOrder> newMapWorkOrder;
    Map<Id,WorkOrder> oldMapWorkOrder;
    /********************************************************************************
    * Obtiene los datos del trigger para utilizarlos desde esta clase
    * @param {List<WorkOrder>} newListWorkOrder - Contexto trigger.new 
    * @param {List<WorkOrder>}  oldListWorkOrder - Contexto trigger.old
    * @param {Map<Id,WorkOrder>} newMapWorkOrder - Contexto trigger.newMap
    * @param {Map<Id,WorkOrder>}  oldMapWorkOrder - Contexto trigger.oldMap
    * @param {System.TriggerOperation}  tipoTrigger - tipo de trigger que se ejecuta
    **********************************************************************************/
    public void workOrderHandlerTrigger(List<WorkOrder> newListWorkOrder,List<WorkOrder> oldListWorkOrder,Map<Id,WorkOrder> newMapWorkOrder,Map<Id,WorkOrder> oldMapWorkOrder, System.TriggerOperation tipoTrigger){
        this.newListWorkOrder = newListWorkOrder;
        this.oldListWorkOrder = oldListWorkOrder;
        this.newMapWorkOrder = newMapWorkOrder;
        this.oldMapWorkOrder = oldMapWorkOrder;
        switch on tipoTrigger {
            when AFTER_UPDATE {
                handlerAfterUpdate();
            }
        }
    }
    /********************************************************************************
    * Corre cada uno de los metodos de la clase JFLS_asignacionCita_ctr cuando se desen
    *cadena el Trigger
    **********************************************************************************/
    public void handlerAfterUpdate(){
        for(Workorder oneOrder: newListWorkOrder){
            if(oneOrder.JFSL_GenerarCita__c== TRUE && oldMapWorkOrder.get(oneOrder.Id).JFSL_GenerarCita__c != oneOrder.JFSL_GenerarCita__c){
                //Integer partidas = JFLS_asignacionCita_ctr.validacionPartidas(oneOrder.Id);
                    List<Datetime> fechas = JFLS_asignacionCita_ctr.datosHorario();
                    Id idCita = JFLS_asignacionCita_ctr.generacionCita(oneOrder, fechas);
                    String nextFireTime= Datetime.now().minute()==59 ? Datetime.now().second()<=54 ? String.valueOf(Datetime.now().second()+5) + ' ' + String.valueOf(Datetime.now().minute()) + ' ' + String.valueOf(Datetime.now().hour()) + ' * * ?': String.valueOf(Datetime.now().second()-54) + ' ' + '00' + ' ' + String.valueOf(Datetime.now().hour()+1) + ' * * ?': Datetime.now().second()<=54 ? String.valueOf(Datetime.now().second()+5) + ' ' + String.valueOf(Datetime.now().minute()) + ' ' + String.valueOf(Datetime.now().hour()) + ' * * ?': String.valueOf(Datetime.now().second()-54) + ' ' + String.valueOf(Datetime.now().minute()+1) + ' ' + String.valueOf(Datetime.now().hour()) + ' * * ?';
                    JFSL_MyScheduler sc = new JFSL_MyScheduler(idCita);
                    System.schedule('Asignacion cita'+nextFireTime, nextFireTime, sc); 
            }
        }
    } 
}