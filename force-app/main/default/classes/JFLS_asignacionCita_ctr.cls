/*************************************************************************
* Nombre de la Clase:         JFLS_asignacionCita_ctr
* Versión :                   1.0
* Fecha de Creación :         08 Agosto 2022
* Funcionalidad :             Controlador de componente para asignacion de citas autiomaticas
* Clase de Prueba:            JFSL_WorkOrderTrigger_Test
*
* Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Brandon Toledo         08/08/2022       Versión Original
* Carlos Bolívar         29/08/2022       Optimización de proceso de ejecución general de la clase (Se omitieron llamadas a métodos no necesarios)
*************************************************************************/
public without sharing class JFLS_asignacionCita_ctr implements Database.AllowsCallouts {

    /********************************************************************************
    * Valida que la orden de trabajo tenga partidas relacionadas. 
    *
    * param {String} RecordId - realiza consulta mediante el id del registro actual
    *
    * return {Integer} - Devuelve un entero con el numero de partidas 
    **********************************************************************************/
    @AuraEnabled
    public static Integer validacionPartidas(String RecordId){
        WorkOrder numPartidas = [SELECT LineItemCount FROM WorkOrder WHERE Id = :recordId];
        Integer conteoPartidas = numpartidas.LineItemCount;
        if(conteoPartidas<1){
            throw new AuraHandledException('No hay partidas asignadas a esta orden');          
        }
        return conteoPartidas;
    }


    /********************************************************************************
    * Obtiene la fecha de asignacion proxima al dia de ejecución
    * return {List<Datetime>} - Devuelve una lista con la fecha proxima y el horario 
    **********************************************************************************/
    @AuraEnabled
    public static List<Datetime> datosHorario(){
        Datetime tomorrow = Date.TODAY().addDays(2); //Obtiene la fecha del dia siguiente
       
        Date fechaInicioAsignacion = tomorrow.date();
        String diaInicio = tomorrow.format('EEEE');
        fechaInicioAsignacion = obtenerFechaAsignacion(fechaInicioAsignacion, diaInicio); //Si el dia siguiente es sabado, cambia a lunes
        diaInicio = obtenerDiaSemana(diaInicio); // Cambia texto de dia de inicio de semana 
        
        Datetime fechaHoraFinAsignacion = fechaInicioAsignacion.addDays(8); // se agrega un día para la fecha de finalización
        String diaFin = fechaHoraFinAsignacion.format('EEEE');
        Date fechaFinAsignacion = obtenerFechaAsignacion(fechaInicioAsignacion.addDays(8), diaFin);
        Time min = Time.newInstance(6, 0, 0, 0);
        Time max = Time.newInstance(23, 59, 0, 0);
        
        //System.debug(fechaSalto);
        List<Datetime> lstFechas = new List<Datetime>();
        lstFechas.add(DateTime.newInstanceGMT(fechaInicioAsignacion, min));
        lstFechas.add(DateTime.newInstanceGMT(fechaFinAsignacion, max));
        
        return lstFechas;
    }


    /********************************************************************************
    * Genera la creacion de la cita a partir de la fecha y horas obtenidas, previo a la
    * agenda de la misma. 
    *
    * param {String} RecordId - realiza consultas mediante el id del registro actual
    * param {List<Datetime>} horas - Fecha y horas en las que se busca crear la cita
    * return {Id} - Devuelve el Id de la cita creada
    **********************************************************************************/
    @AuraEnabled
    public static Id generacionCita(WorkOrder orden, List<Datetime> horas){
        System.debug('Horas de trabajo '+horas);
        Account addr = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry 
                        FROM Account 
                        WHERE Id=:orden.AccountId];
        FSL__Scheduling_Policy__c poliza = [SELECT Id,Name 
                                            FROM FSL__Scheduling_Policy__c 
                                            WHERE Name = 'Customer First' 
                                            LIMIT 1];

        ServiceAppointment cita = New ServiceAppointment(ParentRecordId=orden.Id, ContactId =orden.ContactId, Status = 'Ninguno', //creacion de cita
        FSL__Scheduling_Policy_Used__c =poliza.Id, ArrivalWindowStartTime = horas[0]
        ,ArrivalWindowEndTime = horas[1],EarliestStartTime = horas[0],DueDate = horas[1]
        ,Street=addr.BillingStreet,City=addr.BillingCity,Country=addr.BillingCountry,PostalCode=addr.BillingPostalCode,geocodeAccuracy = 'Street');
        
        insert cita;
        return cita.Id;
    }


    /********************************************************************************
    * Generacion de la cita de servicio a partir de el id de la cita
    *
    * param {Id} citaId - Id de la cita con campos llenos
    **********************************************************************************/
    @AuraEnabled
    public static void agendarCita(Id citaId){
        
        System.debug(' desde agendarCita=> Id de la cita: '+citaId);

        ServiceAppointment citaT = [SELECT Id,ServiceTerritoryId,FSL__Scheduling_Policy_Used__c 
                                        FROM ServiceAppointment 
                                        WHERE id=:citaId];
		System.debug(' Territorio de la cita de servicio: '+citaT.ServiceTerritoryId);
        
        FSL.ScheduleResult myResult = new FSL.ScheduleResult();
         myResult = FSL.ScheduleService.schedule( citaT.FSL__Scheduling_Policy_Used__c, citaT.Id);
 
         System.debug(myResult);
    }

    /********************************************************************************
    * Valida cual es la fecha proxima de asignación con respecto al dia de ejecución
    * si el dia proximo es fin de semana (domingo), la cambiará a lunes
    * param {Date} fechaAsignacion - Fecha 
    * param {String} dia - Fecha y horas en las que se busca crear la cita
    * return {Date} - fechaAsignacion - Devuelve un entero con el numero de partidas 
    **********************************************************************************/
    public static Date obtenerFechaAsignacion(Date fechaAsignacion, String dia){
        //fechaAsignacion = dia == 'Saturday' ? fechaAsignacion.addDays(2):fechaAsignacion;
        fechaAsignacion = dia == 'Sunday' ? fechaAsignacion.addDays(1):fechaAsignacion;
        return fechaAsignacion;
    }


    /********************************************************************************
    * Valida cual el el dia proximo de asignación con respecto al dia de ejecución
    * si el dia proximo es fin de semana, lo cambiará a lunes
    * param {Date} fechaAsignacion - Fecha 
    * param {String} dia - Fecha y horas en las que se busca crear la cita
    * return {Date} - fechaAsignacion - Devuelve un entero con el numero de partidas 
    **********************************************************************************/
    public static String obtenerDiaSemana(String dia){
        //dia = dia == 'Saturday' ? 'Monday' : dia;
        dia = dia == 'Sunday' ? 'Monday' : dia;
        return dia;
    }

}