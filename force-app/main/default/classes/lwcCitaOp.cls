/*************************************************************************
Nombre de la Clase:     lwcCitaOp
Versión :               1.0
Fecha de Creación :     24/10/2022
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
            List<OpportunityLineItem> op= [SELECT Product2.Description,Quantity,ProductCode, Display_Url__c,Product2.Armable__c from OpportunityLineItem where OpportunityId =: idOportunidad];
            return op;
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
    public static String asignacionCitaEntregaOp(String idOp, String citaEntrega,String userOperacion){
        System.debug('asignacionCitaEntregaOp: ' + idOp + ' ' + citaEntrega + ' ' + userOperacion);
        try {
            CitaOp.asignacionCitaOp(idOp, citaEntrega, userOperacion);
            String citaAsignada = CitaOp.validacionCitaEntrega(idOp, citaEntrega, userOperacion);
            return citaAsignada;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}