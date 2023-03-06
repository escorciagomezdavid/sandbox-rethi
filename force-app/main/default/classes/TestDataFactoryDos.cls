/**

*
* See the Apex Language Reference for more information about Testing and Code Coverage.
* @AUTOR: David Escorcia Gomez
* @FECHA: Mar 06 23
* @PROPÓSITO: Common Test Utility Classes for Test Data Creation.
*/
@isTest
public class TestDataFactoryDos {
    
    public static EmailTemplate validEmailTemplate;
    public static OrgWideEmailAddress orgEmail;
    public static List<EmailTemplate> listEmailTemplate = new List<EmailTemplate>();
    
    public static Map<String,RecordType> mapRecordType = new Map<String,RecordType>();
    public static Map<Integer, Lead> mapLeads;
    public static List<lead> listLeads;
    
    public static list<Case> listIdRequestCases; 
    public static List<Case> caseToInsert;
    public static Map<Integer, Case> mapIdRequestCases;
    
    public static list<Case> listInactivationCases; 
    public static Map<Integer, Case> mapInactivationCases;
    
    
    
    public static Map<Integer, Account> mapAccounts;
    public static List<Account> listAccounts;
    
    public static Map<Integer, Account> mapAccountsBusiness;
    public static List<Account> listAccountsBusiness;
    
    public static Map<Integer, Opportunity> mapOpportunities;
    public static List<Opportunity> listOpportunities;
    
    public static PriceBook2 newP2B;
    
    public static Map<Integer, Contact> mapOrphanContacts;
    public static List<Contact> listOrphanContacts;
    
    public static Map<Integer, Cartera__c> mapCarteras;
    public static List<Cartera__c> listCarteras;
    
    
    public static Map<Integer, Cobro_a_domicilio__c> mapCobrosDomicilio;
    public static List<Cobro_a_domicilio__c> listCobrosDomicilio;
    
    public static Map<Integer, Product2> mapProductos;
    public static List<Product2> listProductos;
    
    public static Map<Integer, PricebookEntry> MapPriceEntries;
    
    public static Map<Integer, OpportunityLineItem> MapOpItems;
    
    public static void createGeneralData() {
        
        //Seleccionar tipos de registros.
        for (RecordType r: [Select Id,DeveloperName,SObjectType From RecordType]) {
            if (!mapRecordType.containsKey(r.SObjectType+'-'+r.DeveloperName)) {mapRecordType.put(r.SObjectType+'-'+r.DeveloperName,r);}            
        }
        
        Id pricebookId = Test.getStandardPricebookId();
        
        newP2B =  new Pricebook2(Name = 'Standard Price Book', Description = 'Price Book 2009 Products', IsActive = true );
        insert newP2B;    
             
        
        
        
        //Seleccionar o insertar emailtemplate.
        listEmailTemplate = [Select Id, Name From EmailTemplate Where isActive=:true order by CreatedDate desc limit 1];
        if(listEmailTemplate.Size()==0){
            //Crear email template.
            validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.DeveloperName = 'EnvioSolicitudAfiliacionContrato';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
            validEmailTemplate.Subject = 'Your Subject Here';
            insert validEmailTemplate;
            listEmailTemplate.add(validEmailTemplate);  
            insert listEmailTemplate;
            
        }
        
        //Seleccionar Id Org.
        orgEmail = [Select o.Id From OrgWideEmailAddress o order by DisplayName limit 1];
        
        Pais__c Pais = new Pais__c(Name = 'Colombia' , Codigo__c='JA');
        Insert Pais;	
        
        Agencia__c agencia = new Agencia__c(
            Name = 'Prueba',
            IdAgencia__c = 'JP_00',
            Codigo_de_agencia__c = '00',
            Nombre_comercial__c = 'Prueba',
            Empresa__c = 'JP'
        );
        insert agencia;
        
        Departamento__c depart = new Departamento__c(
            Name = 'Prueba',
            Pais__c = Pais.Id
        );
        insert depart;
    }
    
    public static void createAccountWithIdentification(String identification){
        //RecordType recordType = MapRecordType.get('Account-'+LABEL.AccountRecordTypeIndividualDeveloperName);
        
        listAccounts = new List<Account>(); 
        mapAccounts = new Map<Integer, Account>();
        //CoverageType__c ct= new CoverageType__c(isActive__c=true,CoverageId__c='1',Description__c='hl');
        //insert ct;
        
        Account a = new Account
            (                
                //RecordTypeId = recordType.Id,
                //Name='Test Individual ' + x,
                FirstName = 'Prueba',
                LastName = 'Prueba ',
                Empresa__c = 'JP',
                IdCliente__c = 'JP_' + identification,
                Identificacion__c = identification,
                PersonMobilePhone = '50744444444',
                PersonEmail = 'jamartest@jamar.com'
            );
        listAccounts.add(a);
        // mapAccounts.put(x,a);
        
        
        if (listAccounts.size()>0) {
            // TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
            insert listAccounts;
            // TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
        } 
    }

    public static void createAgencia(){
        Agencia__C ag = new Agencia__C();
        ag.IdAgencia__c = 'JP_001';
        ag.Codigo_de_agencia__c = '001';
        ag.Empresa__c = 'JP';
        ag.Nombre_comercial__c = 'OTRO';
        ag.Name = 'OTRO';
        insert ag;
    }

    public static void createDepartamento(){
        Departamento__C dep = new Departamento__C();
        dep.Name = 'ATL';
        insert dep;
    }

    public static void createLeadWithIdentification(String identification){
        Lead lead = new Lead();
        lead.FirstName = 'Jamar';
        lead.LastName  = 'Test';
        lead.Status = 'Unqualified';
        lead.Empresa__c = 'JP';
        lead.Identificacin__c = identification;
        lead.Email = 'jamartest@jamar.com';
        lead.Ultima_Fecha_Ingreso__c = DateTime.now();
        lead.MobilePhone = '50744444444';
        
        insert lead;
    }

    public static void createLeadWithOutIdentification(){
        Lead lead = new Lead();
        lead.FirstName = 'Jamar';
        lead.LastName  = 'Test';
        lead.Status = 'Unqualified';
        lead.Empresa__c = 'JP';
        lead.Email = 'jamartest@jamar.com';
        lead.Ultima_Fecha_Ingreso__c = DateTime.now();
        lead.MobilePhone = '50744444444';
        
        insert lead;
    }
    
}