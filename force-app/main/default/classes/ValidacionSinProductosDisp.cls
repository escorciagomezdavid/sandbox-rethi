public class ValidacionSinProductosDisp {
    @invocablevariable(Label='IdOp' required=true)
    public string Id_Op;
    @invocablevariable(Label='AccountId' required=true)
    public string AccountId;
    @invocablevariable(Label='OpportunityId' required=true)
    public string OpportunityId;
    @invocablevariable(Label='OwnerId' required=true)
    public string OwnerId;
    
    public ValidacionSinProductosDisp(){}
    public ValidacionSinProductosDisp(String Id_Op, String AccountId, String OpportunityId, String OwnerId){
        this.Id_Op=Id_Op;
        this.AccountId=AccountId;
        this.OpportunityId=OpportunityId;
        this.OwnerId=OwnerId;
    }
    @InvocableMethod (label='Sin Producto disponible')
    public static void Sinproductosdisponible (list<ValidacionSinProductosDisp> productos){
        String idop=productos[0].id_Op;
        String AccountId= productos[0].AccountId;
        String OpportunityId = productos[0].OpportunityId;
        String OwnerId=productos[0].OwnerId;
        List<AggregateResult> count = [SELECT count(Product2.Estado_de_producto__c)total from OpportunityLineItem where IdOP__c = :idop and Product2.Estado_de_producto__c ='INACTIVO'];
        Integer cantidad=(Integer)count[0].get('total');
        if(cantidad > 0){ 
            Case caso= new Case();
            caso.Causal_Principal__c = 'ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP';
            caso.SubTipodeGestion__c='OP-Asignación de cita';
            caso.RecordTypeId='0124O000000EMRf';
            caso.Origin='Llamadas';
            caso.Reason='Sin Productos disponible';
            caso.SLA_Dias_de_Vida__c=10;
            caso.Priority='Medium';
            caso.OwnerId=ownerId;
            caso.Tipo_Solicitud__c='SERVICIO';
            caso.Description='Orden de pedido con productos agotados';
            caso.AccountId= AccountId;
            caso.Oportunidad__c = opportunityId;
            insert caso;       
        }
        
    }
    
}