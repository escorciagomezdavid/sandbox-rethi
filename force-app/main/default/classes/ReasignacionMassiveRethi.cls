public class ReasignacionMassiveRethi {
    
    public List<Opportunity> ordenesPedido{get;set;}
    public string codAsesor{get;set;}
    private Set < Id > opIds = new Set < Id >();
    
    public ReasignacionMassiveRethi(ApexPages.StandardSetController standardController ){
        System.debug('StandartController');
        System.debug(standardController);
        for (Opportunity op : ( List < Opportunity > )standardController.getSelected() ){ 
            opIds.add( op.Id );
 
        }
        ordenesPedido = [ SELECT Name, IdOp__c FROM Opportunity WHERE ID IN: opIds ];
    }

}