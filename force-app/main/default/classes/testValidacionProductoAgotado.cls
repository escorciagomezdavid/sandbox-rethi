@IsTest
public class testValidacionProductoAgotado {
    @invocablevariable(Label='IdOp' required=true)
    public string Id_Op;
    @invocablevariable(Label='AccountId' required=true)
    public string AccountId;
    @invocablevariable(Label='OpportunityId' required=true)
    public string OpportunityId;
    @invocablevariable(Label='OwnerId' required=true)
    public string OwnerId;
    public testValidacionProductoAgotado(){
        this.Id_Op='JA_09_2930494';
        this.AccountId='0012D00000bCp4zQAC';
        this.OpportunityId='0062D00000HamezQAB';
        this.OwnerId='0054O00000A2vcqQAB';
    }
    @isTest 
    public static void TestCertAlDia(){          
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_09_2021_345678', '');
        list<Opportunity> op = [select Id,AccountId from Opportunity where IdOP__c = 'JA_09_2021_345678'];
        TestDataFactory.crearCase('0054O00000A2vcqQAB',op[0].AccountId,op[0].Id);
        Test.startTest();
        testValidacionProductoAgotado testeo = new testValidacionProductoAgotado();
        ValidacionSinProductosDisp testAlDia = new ValidacionSinProductosDisp('JA_09_2021_345678',op[0].AccountId, 
                                                                              op[0].Id,'0054O00000A2vcqQAB');
        list<ValidacionSinProductosDisp> lista = new list<ValidacionSinProductosDisp>();
        lista.add(testAlDia);  
        ValidacionSinProductosDisp.Sinproductosdisponible(lista);    
        Test.stopTest();
    }
    
}