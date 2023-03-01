/*************************************************************************
Nombre de la Clase:     TestsClass
Versión :               1.0
Fecha de Creación :     01/03/2023
Funcionalidad :         Realizar simulacion de consultas a servicios en entorno de pruebas.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador            - Fecha –        Descripción
* -----------------------------------------------------------------------
* David Escorcia Gómez     01/03/2023     Version para lwc asignacionCitaEntrega
* 

*************************************************************************/
public with sharing class TestsClass {
    
    public TestsClass() {}

       
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
            List<Opportunity> op= [SELECT id FROM Opportunity];
            List<Product2> op2= [select IdProducto__c, ProductCode, CreatedDate from Product2 where IdProducto__c like '%JP%' order by CreatedDate DESC];
            System.debug('Desde aplicaArmado: ' + op2);
            return 'NO ARMABLE';
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static list<string> calendarioCitasEntrega(String empresa, String idOp){
        try {
            List<OpportunityLineItem> op= [SELECT id FROM OpportunityLineItem];
            list<string> calendario = new list<String>();
            calendario.add('2023-02-01');
            calendario.add('2023-03-05');
            calendario.add('2023-04-07');
            return calendario;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String asignacionCitaEntregaOp(String idOp, String citaEntrega,String userOperacion,Boolean reasignacion){
        try {
            List<Opportunity> op= [SELECT id FROM Opportunity];
            System.debug('Desde asignacionCitaEntregaOp: ' + op);
            String citaAsignada = 'CITA ASIGNADA EXITOSAMENTE';
            return citaAsignada;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<CitaOp> calendarioArmado(String idOp, String fechaEntrega, String pais){
        try {
            List<OpportunityLineItem> op= [SELECT id FROM OpportunityLineItem];
            CitaOp citaOp = new CitaOp();
            List<CitaOp> lstCitaOp = new List<CitaOp>();
            list<string> calendario = new list<String>();
            calendario.add('2023-04-01');
            calendario.add('2023-04-05');
            calendario.add('2023-04-07');
            citaOp.fechas = calendario;
            citaOp.tecnico = '1033692657';
            citaOp.mensaje = 'CALENDARIO EXITOS';
            citaOp.recurso = '03';
            lstCitaOp.add(citaOp);

            return lstCitaOp;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String AsignacionArmado(String idOp, String codigoPais, String citaArmado, String tecnico,
                                            String codRecurso, Boolean reasignacion,String usuario){

        try {
            List<Opportunity> op= [SELECT id FROM Opportunity];
            System.debug('Desde AsignacionArmado: ' + op);
            String citaAsignada = 'CITA ASIGNADA EXITOSAMENTE';
            return citaAsignada;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}