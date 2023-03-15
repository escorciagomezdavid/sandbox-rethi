/*************************************************************************
Nombre de la Clase:     lwcCitaOp
Versión :               1.0
Fecha de Creación :     13/02/2023
Funcionalidad :         Enviar informacion para ser usada en proceso de asignacion de cita.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez         13/02/2023     Versión Original
* Daniela Sanchez         13/03/2023     Metodos de entregas parciales

*************************************************************************/
public with sharing class lwcCitaOp {
    
    public lwcCitaOp() {}

       
    @AuraEnabled
    public static list<OpportunityLineItem> envioProductosEntrega(Id idOportunidad){

        try{
            List<OpportunityLineItem> op= [SELECT Product2.Description,Quantity,ProductCode, Product2.DisplayUrl,Product2.Armable__c from OpportunityLineItem where OpportunityId =: idOportunidad];
            System.debug(op);
            return op;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String aplicaArmado(String idOp){

        try{
            string armado = CitaOp.aplicaArmadoOp(idOp);
            return armado;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static CitaOp calendarioCitasEntrega(String idOp){
        try {
            System.debug('idOp: ' + idOp);
            CitaOp calendario = new CitaOp();
            calendario = CitaOp.calendarioEntregasParciales(idOp);
            return calendario;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String asignacionCitaEntregaOp(String idOp, String citaEntrega,String userOperacion,Boolean reasignacion){
        try {
            CitaOp.asignacionCitaOp(idOp, citaEntrega, userOperacion);
            String citaAsignada = CitaOp.validacionCitaEntrega(idOp, citaEntrega, userOperacion,reasignacion);
            return citaAsignada;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<CitaOp> calendarioArmado(String idOp, String fechaEntrega, String pais){
        try {
            list<CitaOp> calendario = new list<CitaOp>();
            calendario = CitaOp.calendarioCitaArmado(idOp, fechaEntrega, pais);
            System.debug(calendario);
            return calendario;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String AsignacionArmado(String idOp, String codigoPais, String citaArmado, String tecnico,
                                            String codRecurso, Boolean reasignacion,String usuario){

        try {
            String citaAsignada = CitaOp.asignacionCitaArmado(idOp, codigoPais, citaArmado, tecnico, codRecurso, reasignacion, usuario);
            return citaAsignada;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string asignacionCitaEntregaParcial(String idOp, List<String> grupos){
        try {
            String mensajeConfirmacion = CitaOp.asignacionCitaEntregaParcial(idOp, grupos);
            return mensajeConfirmacion;            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}