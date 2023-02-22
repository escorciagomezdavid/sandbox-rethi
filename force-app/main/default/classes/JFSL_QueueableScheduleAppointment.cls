/*************************************************************************
* Nombre de la Clase:     JFSL_QueueableScheduleAppointment
* Versión :               1.0
* Fecha de Creación :     15 Septiembre 2022
* Funcionalidad :         Handler en conjunto que agenda una cita a partir del campo checkbox
* Clase de Prueba:        JFSL_WorkOrderTrigger_Test
* Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Brandon Toledo         15/09/2022       Versión Original
*************************************************************************/

public with sharing class JFSL_QueueableScheduleAppointment implements Queueable, Database.AllowsCallouts {
    Id idCita;

    public JFSL_QueueableScheduleAppointment(Id idCita) {
        this.idCita = idCita;
    }

    public void execute(QueueableContext context) {
        JFLS_asignacionCita_ctr.agendarCita(this.idCita);
    }
}