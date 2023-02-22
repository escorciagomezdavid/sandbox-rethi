@isTest
public class JamarDeleteApi_test {
    	static{
		TestDataFactory.createGeneralData();
	}
      @isTest static void testDeleteLead() {
          TestDataFactory.createLeadIndividual(1);
          TestDataFactory.mapLeads.get(0).Email = 'JamarDeleteApi_test@prueba.com';
	 	update TestDataFactory.mapLeads.values();
         List<Lead> variable = [SELECT Id FROM Lead WHERE Email = 'JamarDeleteApi_test@prueba.com'];
          String id = variable[0].id;
          JamarDeleteApi.MethodDeleteLead(id);
    }
    @isTest static void testDeleteLeadRecibe(){
        TestDataFactory.createLeadIndividual(1);
        TestDataFactory.mapLeads.get(0).Email = 'JamarDeleteApi_test@prueba.com';
	 	update TestDataFactory.mapLeads.values();
        List<Lead> variable = [SELECT Id FROM Lead WHERE Email = 'JamarDeleteApi_test@prueba.com'];
        String id = variable[0].id;
        list<JamarDeleteApi> listvar = new list<JamarDeleteApi>();
        JamarDeleteApi jamar = new JamarDeleteApi();
        jamar.id = id;
        listvar.add(jamar);
        JamarDeleteApi.RecibeDeleteLead(listvar);
        
    } 

}