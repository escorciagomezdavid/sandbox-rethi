global class JFSL_MyScheduler implements Schedulable{
    private final Id cita;
    public JFSL_MyScheduler(Id cita) {
        this.cita = cita;
    }

    global void execute(SchedulableContext sc){
        ID jobID = System.enqueueJob(new JFSL_QueueableScheduleAppointment(this.cita));
        // abort to execute it only once
        System.abortJob(sc.getTriggerId()); 
    }
}