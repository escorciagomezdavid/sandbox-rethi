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

    // public class responseProductos{
    //     public Boolean success;
    //     public list<OpportunityLineItem> productosOp;
    // }
       
    // @AuraEnabled
    // public static list<responseProductos> envioProductosEntrega(Id idOportunidad){
    //     System.debug(idOportunidad);
    //     responseProductos rp = new responseProductos();
    //     list<responseProductos> value = new list<responseProductos>();
    //     try{
    //         List<OpportunityLineItem> op= [SELECT Product2.Description,Quantity,ProductCode, Display_Url__c,Product2.Armable__c from OpportunityLineItem where OpportunityId =: idOportunidad];
    //         if(!op.isEmpty()){
    //             rp.success=true;
    //             rp.productosOp = op;
    //             value.add(rp);
    //             system.debug('value if: ' + value);
    //             return value;
    //         }else{
    //             rp.success=false;
    //             value.add(rp);
    //             system.debug('value else: ' + value);
    //             return value;
    //         }
    //     }catch(Exception e){
    //         throw new AuraHandledException(e.getMessage());
    //     }
    // }

    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> envioProductosEntrega(Id idOportunidad) {
        return [
            SELECT Product2.Description,Quantity,ProductCode, Display_Url__c,Product2.Armable__c from OpportunityLineItem where OpportunityId =: idOportunidad
        ];
    }

    @AuraEnabled
    public static list<string> calendarioCitasEntrega(String empresa, String idOp){
        System.debug('empresa: ' + empresa);
        System.debug('idOp: ' + idOp);
        try {
            list<string> calendario = new list<String>();
            calendario = CitaOp.calendarioCitaEntrega(empresa, idOp, 'OP');
            return calendario;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}