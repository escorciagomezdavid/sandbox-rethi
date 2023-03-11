/*************************************************************************
Nombre de la Clase:     lwcCitaOp
Versión :               1.0
Fecha de Creación :     24/10/2023
Funcionalidad :         Enviar informacion para ser usada en proceso de asignacion de cita.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez         13/02/2023     Versión Original
* 

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
            List<OpportunityLineItem> op= [SELECT id FROM OpportunityLineItem WHERE Product2.Armable__c = true and IdOP__c =: idOp];
            if(!op.isEmpty()){
                return 'ARMABLE';
            }else{
                return 'NO ARMABLE';
            }
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static list<string> calendarioCitasEntrega(String empresa, String idOp){
        try {
            list<string> calendario = new list<String>();
            calendario = CitaOp.calendarioCitaEntrega(empresa, idOp, 'OP');
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
}