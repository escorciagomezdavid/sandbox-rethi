/**

*
* See the Apex Language Reference for more information about Testing and Code Coverage.
* @AUTOR: Jonathan Parrales
* @FECHA: 18 Feb 20
* @PROPÓSITO: Common Test Utility Classes for Test Data Creation.
*/
@isTest
public class TestDataFactory {
    
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

    public String empresa;
    public String id_oportunidad;
    public String proceso;
    public String codigoVendedor;

    
    public static void createGeneralData() {
        
        //Seleccionar tipos de registros.
        for (RecordType r: [Select Id,DeveloperName,SObjectType From RecordType]) {
            if (!mapRecordType.containsKey(r.SObjectType+'-'+r.DeveloperName)) {mapRecordType.put(r.SObjectType+'-'+r.DeveloperName,r);}            
        }
        
        Id pricebookId = Test.getStandardPricebookId();
        
        newP2B =  new Pricebook2(Name = 'Standard Price Book', Description = 'Price Book 2009 Products', IsActive = true );
        insert newP2B;    
        
        /*        WSCasosValorCamposLookup__c  item = new WSCasosValorCamposLookup__c (Name = 'CreatedById',Campo_deseado__c= 'CreatedBy.Name');
WSCasosValorCamposLookup__c  item2 = new WSCasosValorCamposLookup__c    (Name = 'LastModifiedById',Campo_deseado__c= 'LastModifiedBy.Name');
WSCasosValorCamposLookup__c  item3 = new WSCasosValorCamposLookup__c    (Name = 'OwnerId',Campo_deseado__c= 'Owner.Name');
WSCasosValorCamposLookup__c  item4 = new WSCasosValorCamposLookup__c    (Name = 'NombreClienteTitulares__c',Campo_deseado__c= 'NombreClienteTitulares__r.Name');
insert item; insert item2 ; insert item3; insert item4;

MapeoParaProspectoIndividual__c mapeo1 = new MapeoParaProspectoIndividual__c(Name = 'Name', Campo_en_Cuenta__c='Name');
MapeoParaProspectoIndividual__c mapeo2 = new MapeoParaProspectoIndividual__c(Name = 'NumeroCedula__c',Campo_en_Cuenta__c='Numero_de_Cedula__c');
insert mapeo1; insert mapeo2;
*/      
        
        
        
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
    
    public static void createLeadIndividual(Integer iTotReg){
        
        //RecordType recordType = MapRecordType.get('Lead-'+label.LeadRecordTypePersonDeveloperName);
        
        listLeads = new List<Lead>(); 
        mapLeads = new Map<Integer, Lead>();
        for (Integer x=0;x<iTotReg;x++) {
            Lead l = new Lead
                (
                    //RecordTypeId = recordType.Id,
                    //TipoIdentificacion__c = 'Pasaporte',
                    //NumeroCedula__c = '12345678'+x,
                    Phone='88888888',
                    LastName = 'LASTNAME',
                    //Venta_Cerrada__c = 'Si',
                    Status = 'Nuevo',
                    Company = 'FCC'
                    //EstadoSeguimiento1__c = 'Interesado',
                    //EstadoSeguimiento2__c = 'Interesado',
                    //EstadoSeguimiento3__c = 'Interesado',
                    //EstadoSeguimiento4__c = 'Interesado',
                    //TipoCliente__c = 'Individual',
                    //VendedorAsignado__c = userinfo.getUserId()
                );
            
            listLeads.add(l);
            mapLeads.put(x,l);
        }
        
        if (listLeads.size()>0) {insert listLeads;} 
    }
    
    public static void createLeadBusiness(Integer iTotReg){
        
        //RecordType recordType = MapRecordType.get('Lead-'+label.LeadRecordTypeBusinessDeveloperName);
        
        listLeads = new List<Lead>(); 
        mapLeads = new Map<Integer, Lead>();
        for (Integer x=0;x<iTotReg;x++) {
            Lead l = new Lead
                (
                    //RecordTypeId = recordType.Id,
                    //TipoIdentificacion__c = 'Juridica',
                    //NumeroCedula__c = '12545454545'+x,
                    Phone='88888888',
                    LastName = 'LASTNAME',
                    //Venta_Cerrada__c = 'Si',
                    Status = 'Calificado',
                    //CanalVentas__c = 'ITS',
                    //Campana__c  =   'Chat',
                    Company = 'FCC'
                    
                );
            
            listLeads.add(l);
            mapLeads.put(x,l);
        }
        
        if (listLeads.size()>0) {insert listLeads;} 
    }
    
 
    public static void createCases(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Case-MSAsignacionCitaMedica');
        //RecordType recordType2 = MapRecordType.get('Case-HMAsignacionCitaMedica');
        caseToInsert = new List<Case>(); 
        for (Integer x=0;x<iTotReg;x++) {
            
            
            Case c = new Case
                (
                    Status='Abierto',
                    
                    OwnerId = Userinfo.getUserId()
                );
            
            caseToInsert.add(c);
        }
        if (caseToInsert.size()>0) {insert caseToInsert;} 
        
        
    }
    
    /* 
public static void createAccountInactivationCases(Integer iTotReg){
RecordType recordType = MapRecordType.get('Case-'+LABEL.CaseRecordTypeAccountInactivation);
listInactivationCases = new List<Case>(); 
mapInactivationCases = new Map<Integer, Case>();
for (Integer x=0;x<iTotReg;x++) {
Case c = new Case
(
Subject = LABEL.CaseRecordTypeAccountInactivation,
Status='Abierta',
NombreClienteTitulares__c =listAccounts[0].Id,
RazonInactivacion__c= 'FUERA DEL PAIS',
FechaSolicitudInactivacion__c =Date.today(),
FechaInactivacion__c  =Date.today(),
AccountId = listAccounts[0].Id,
RecordTypeId=  recordType.Id
);

listInactivationCases.add(c);
mapInactivationCases.put(x,c);
}

if (listInactivationCases.size()>0) {insert listInactivationCases;} 
}

public static void createIdRequestCases(Integer iTotReg){
RecordType recordType = MapRecordType.get('Case-'+LABEL.CaseRecordTypeIdRequest);
listIdRequestCases = new List<Case>(); 
mapIdRequestCases = new Map<Integer, Case>();
for (Integer x=0;x<iTotReg;x++) {
Case c = new Case
(
Subject = LABEL.CaseRecordTypeIdRequest,
Status='Abierta',
NombreClienteTitulares__c = listAccounts[0].Id,
RazonSolicitudCarnet__c= 'Carnet Virtual - Perdida de Carnet',
AccountId = listAccounts[0].Id,
RecordTypeId=  recordType.Id
);

listIdRequestCases.add(c);
mapIdRequestCases.put(x,c);
}

if (listIdRequestCases.size()>0) {insert listIdRequestCases;} 
}

public static void createPaymentCases(Integer iTotReg){
RecordType recordType = MapRecordType.get('Case-'+LABEL.CaseRecordTypePayment);
listIdRequestCases = new List<Case>(); 
mapIdRequestCases = new Map<Integer, Case>();
for (Integer x=0;x<iTotReg;x++) {
Case c = new Case
(
Subject = LABEL.CaseRecordTypePayment,
Status='Abierta',
NumeroAutorizacion__c = '1234',
ActualizarProximoCobro__c = date.today(),
CantidadMesesAdelantados__c = 2,
AccountId = listAccounts[0].Id,
NombreClienteTitulares__c = listAccounts[0].Id,
RecordTypeId=  recordType.Id
);

listIdRequestCases.add(c);
mapIdRequestCases.put(x,c);
}

if (listIdRequestCases.size()>0) {insert listIdRequestCases;} 
}

*/
    public static void createToken(){
        SEUSAuthToken__c token = new SEUSAuthToken__c(Name='Token Actual',Propiedad__c = 'SEUS', FechaDeExpiracion__c = System.today().AddDays(1));
        insert token;
    }
    
    public static void createAccountIndividual(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Account-'+LABEL.AccountRecordTypeIndividualDeveloperName);
        
        listAccounts = new List<Account>(); 
        mapAccounts = new Map<Integer, Account>();
        //CoverageType__c ct= new CoverageType__c(isActive__c=true,CoverageId__c='1',Description__c='hl');
        //insert ct;
        for (Integer x=0;x<iTotReg;x++) {
            Account a = new Account
                (                
                    //RecordTypeId = recordType.Id,
                    //Name='Test Individual ' + x,
                    FirstName = 'Prueba',
                    LastName = 'Prueba ' + String.valueOf(x),
                    Empresa__c = 'JA',
                    IdCliente__c = 'JA'+String.valueOf(x),
                    Identificacion__c = 'ID' + String.valueOf(x)
                    //Tipo_de_Identificacion__c = 'Nacio,nal',
                    //Numero_de_cedula__c = '12345678'+x,
                    //Correo_Electronico__c='hola@hola.com',
                    //Campana__c='TV',
                    //CanalVentas__c='ITS',
                    //TipoCobertura__c=cobertura01.Id,
                    //RebajoDias__c='30',
                    //Estado_del_Cliente__c=LABEL.EstadoProcesoVenta,
                    //FormaPago__c='Tarjeta Empresarial',
                    //FrecuenciaPago__c='Mensual',
                    //FechaProximoCobro__c=system.today(),
                    //FechaUltimoCobro__c = system.today(),
                    //Vendedor__c = UserInfo.getUserId(),
                    //FechaCreacionTitular__c= Date.today()
                    
                );
            //a.FechaUltimoCobro__c= a.FechaProximoCobro__c.addMonths(-1);
            listAccounts.add(a);
            mapAccounts.put(x,a);
        }
        
        if (listAccounts.size()>0) {
            // TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
            insert listAccounts;
            // TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
        } 
    }
    
    public static void createChildBussinessAccount(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Account-'+LABEL.AccountRecordTypeIndividualDeveloperName);
        
        listAccounts = new List<Account>(); 
        mapAccounts = new Map<Integer, Account>();
        //CoverageType__c ct= new CoverageType__c(isActive__c=true,CoverageId__c='1',Description__c='hl');
        //insert ct;
        for (Integer x=0;x<iTotReg;x++) {
            Account a = new Account
                (                
                    //RecordTypeId = recordType.Id,
                    Name='TEST',
                    //Tipo_de_Identificacion__c = 'Nacional',
                    //Numero_de_cedula__c = '12345678'+x,
                    //Correo_Electronico__c='hola@hola.com',
                    //Campana__c='TV',
                    //CanalVentas__c='ITS',
                    //TipoCobertura__c=cobertura01.Id,
                    //RebajoDias__c='30',
                    //Estado_del_Cliente__c=LABEL.EstadoProcesoVenta,
                    //FormaPago__c='Tarjeta Empresarial',
                    //FrecuenciaPago__c='Mensual',
                    // FechaProximoCobro__c=system.today(),
                    ParentId = listAccountsBusiness[0].Id,
                    Empresa__c = 'JA',
                    IdCliente__c = String.valueOf(x),
                    Identificacion__c = 'ID' + String.valueOf(x)
                    //Vendedor__c = UserInfo.getUserId()
                    //FechaCreacionTitular__c= Date.today()
                    
                );
            //a.FechaUltimoCobro__c= a.FechaProximoCobro__c.addMonths(-1);
            listAccounts.add(a);
            mapAccounts.put(x,a);
        }
        
        if (listAccounts.size()>0) {
            // TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
            insert listAccounts;
            // TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
        } 
    }
    
    public static void createAccountBusiness(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Account-'+LABEL.AccountRecordTypeBusinessDeveloperName);
        
        listAccountsBusiness = new List<Account>(); 
        mapAccountsBusiness = new Map<Integer, Account>();
        for (Integer x=0;x<iTotReg;x++) {
            Account a = new Account
                (                
                    //RecordTypeId = recordType.Id,
                    Name = 'TEST',
                    Empresa__c = 'JA',
                    IdCliente__c = String.valueOf(x),
                    Identificacion__c = 'ID' + String.valueOf(x)
                    //FechaCreacionTitular__c= Date.today(),
                    //Tipo_de_Identificacion__c = 'Juridica',
                    //Numero_de_cedula__c = '12345678901'+x,
                    //Correo_Electronico__c='hola@hola.com',
                    //Campana__c='TV',
                    //CanalVentas__c='ITS',
                    //TipoCobertura__c=cobertura01.Id,
                    //Estado_del_Cliente__c=LABEL.EstadoProcesoVenta,
                    //FormaPago__c='Tarjeta Empresarial',
                    //FrecuenciaPago__c='Mensual',
                    //FechaProximoCobro__c=system.today(),
                    //Vendedor__c = UserInfo.getUserId()
                    
                );
            //a.FechaUltimoCobro__c= a.FechaProximoCobro__c.addMonths(-1);
            
            listAccountsBusiness.add(a);
            mapAccountsBusiness.put(x,a);
        }
        
        if (listAccountsBusiness.size()>0) {
            TriggerHandler.byPass(LABEL.TriggerHandlerAccount);
            insert listAccountsBusiness;
            //TriggerHandler.clearbyPass(LABEL.TriggerHandlerOpportunity);
            
        } 
    }
    
    public static void createOpportunities(Integer iTotReg){
        mapOpportunities = new Map<Integer, Opportunity>();
        listOpportunities = new list<Opportunity>();
        for (Integer x=0;x<iTotReg;x++) {
            Opportunity opp = new Opportunity(
                Name = 'TEST',
                AccountId=listAccounts[0].Id,
                StageName='Nueva',
                CloseDate = date.today()
            );
            listOpportunities.add(opp);
            mapOpportunities.put(x,opp);
        }
        
        if (listOpportunities.size()>0) {insert listOpportunities;} 
    }
    
    public static void createTempOpportunities(Integer iTotReg){
        mapOpportunities = new Map<Integer, Opportunity>();
        listOpportunities = new list<Opportunity>();
        for (Integer x=0;x<iTotReg;x++) {
            Opportunity opp = new Opportunity(
                Name = 'TEST',
                AccountId=listAccounts[0].Id,
                //StageName=label.OPStageTemporal,
                CloseDate = date.today()
            );
            listOpportunities.add(opp);
            mapOpportunities.put(x,opp);
        }
        
        if (listOpportunities.size()>0) {insert listOpportunities;} 
    }
    
    public static void createOrphanContacts(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Account-'+LABEL.AccountRecordTypeIndividualDeveloperName);
        
        listOrphanContacts = new List<Contact>(); 
        mapOrphanContacts = new Map<Integer, Contact>();
        //CoverageType__c ct= new CoverageType__c(isActive__c=true,CoverageId__c='1',Description__c='hl');
        //insert ct;
        for (Integer x=0;x<iTotReg;x++) {
            Contact a = new Contact
                (                
                    //RecordTypeId = recordType.Id,
                    FirstName='Joe ' + String.valueOf(x),
                    LastName='Contact',
                    Phone='415.555.1212'
                    //AccountId=acctID
                );
            
            //a.FechaUltimoCobro__c= a.FechaProximoCobro__c.addMonths(-1);
            listOrphanContacts.add(a);
            mapOrphanContacts.put(x,a);
        }
        
        if (listOrphanContacts.size()>0) {
            // TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
            insert listOrphanContacts;
            // TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
        } 
    }
    
    public static void createCarteras(Integer iTotReg){
        if (listAccounts== null || listAccounts.size() == 0) TestDataFactory.createAccountIndividual(iTotReg);
        
        listCarteras = new List<Cartera__c>(); 
        mapCarteras = new Map<Integer, Cartera__c>();
        for (Integer x=0;x<iTotReg;x++) {
            Cartera__c a = new Cartera__c
                (                
                    idcartera__C='idCartera' + String.valueOf(x),
                    Name = '10114521'+x,
                    AccountId__c = listAccounts[0].Id
                );
            
            //a.FechaUltimoCobro__c= a.FechaProximoCobro__c.addMonths(-1);
            listCarteras.add(a);
            mapCarteras.put(x,a);
        }
        
        if (listCarteras.size()>0) {
            // TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
            insert listCarteras;
            // TriggerHandler.ClearByPass(LABEL.TriggerHandlerAccount);
        } 
    }
    
    public static void createCobrosDomicilio(Integer iTotReg){
        //RecordType recordType = MapRecordType.get('Case-MSAsignacionCitaMedica');
        //RecordType recordType2 = MapRecordType.get('Case-HMAsignacionCitaMedica');
        if (listCarteras== null || listCarteras.size() == 0) TestDataFactory.createCarteras(iTotReg);
        List<Cobro_a_domicilio__c> cobrosToInsert = new List<Cobro_a_domicilio__c>(); 
        for (Integer x=0;x<iTotReg;x++) {
            
            
            Cobro_a_domicilio__c c = new Cobro_a_domicilio__c
                (
                    //Name = 'Cobro'+ String.valueOf(x)
                    Numero_cartera__c = listCarteras[0].Id,
                    Numero_caso__c = caseToInsert[0].Id
                );
            
            cobrosToInsert.add(c);
        }
        system.debug('listCarteras[0]');system.debug(listCarteras[0]);
        if (cobrosToInsert.size()>0) {insert cobrosToInsert;} 
    }
    
    public static void crearProductos(Integer iTotReg){
        listProductos = new List<Product2>();
        mapProductos = new Map<Integer, Product2>();
        
        for (Integer x=0;x<iTotReg;x++) {   
            Product2 c = new Product2
                (
                    Name = 'Prueba',
                    ProductCode = '0001',
                    IdProducto__c = 'JP_0001',
                    IsActive = true
                );
            
            listProductos.add(c);
            mapProductos.put(x, c);
        }
        
        if (listProductos.size()>0) {
            insert listProductos;
        } 
    }
    
    //Crear Registros en lista de precios standard
    public static void createPriceBookEntries(Integer iTotReg){
        MapPriceEntries = new Map<Integer, PricebookEntry>();
        List<PricebookEntry> listPreciosProductos = new List<PricebookEntry>();
        
        for (Integer x=0;x<iTotReg;x++) {
            PricebookEntry standardPrice2 = new PricebookEntry(
                Pricebook2Id = Test.getStandardPricebookId(), 
                Product2Id = mapProductos.get(x).Id,
                UnitPrice = 59900, 
                IsActive = true
            );
            
            MapPriceEntries.put(x,standardPrice2);
            listPreciosProductos.add(standardPrice2);
        }
        if(listPreciosProductos.size()>0){
            insert listPreciosProductos;
        }  
    }
    
    public static void crearProductosOP(Integer iTotReg){
        list<OpportunityLineItem> listOpItems = new list<OpportunityLineItem>();
        MapOpItems = new Map<Integer, OpportunityLineItem>();
        
        for (Integer x=0;x<iTotReg;x++){
            OpportunityLineItem item = new OpportunityLineItem(
                PriceBookEntryId = MapPriceEntries.get(x).Id,
                OpportunityId = mapOpportunities.get(x).Id,
                Quantity = 1,
                TotalPrice = MapPriceEntries.get(x).UnitPrice,
                IdProducto__c = 'JP_0001',
                IdOP__c = 'JP_0001'
            );
            
            listOpItems.add(item);
            MapOpItems.put(x, item);
        }
        
        if(MapOpItems.size()>0) insert MapOpItems.values();
    }
    
    
    public static void crearOportunityAndProducts(String empresa, String id_oportunidad, String proceso){
        
        Account ac = new Account();
        ac.FirstName = 'Prueba';
        ac.LastName = 'Prueba';
        ac.Empresa__c = empresa;
        ac.IdCliente__c = 'JA_001';
        ac.Identificacion__c = 'ID001';
        insert ac;
        
        System.debug('---------------- SE CREA LA CUENTA -------------------------');
        System.debug(ac.FirstName);
        
        Opportunity op = new  Opportunity();
		op.Numero_OP__c = '2599399';
        op.AccountId = ac.Id;
        op.Name = ac.FirstName + '_' + ac.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.IdOP__c = id_oportunidad;
        op.StageName = 'Propuesta';
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);
        
        
        List<OpportunityLineItem> alm_prod_op = new List<OpportunityLineItem>();        
        OpportunityLineItem opProduct = new OpportunityLineItem();
        Product2 product = new Product2();
        PricebookEntry standardPrice2 = new PricebookEntry();
        
        
        
        
        product.Name = 'Product 001';
        product.ProductCode = '234567';
        product.IsActive = true;
        product.Estado_de_producto__c='INACTIVO';
        product.IdProducto__c = empresa +'_234567';
        if(proceso == 'SinUrl'){
            product.Armable__c = false;
            product.Aplica_garantia__c ='SI';
        }else{
            product.Armable__c = true;
            product.Aplica_garantia__c = 'SI';
            product.DisplayUrl = 'https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }    
        insert product;
        
        System.debug('---------------- SE CREA EL PRODUCTO NUMERO: ');
        System.debug(product.Name);
        System.debug(product.ProductCode);
        System.debug(product.IdProducto__c);
        
        
        standardPrice2.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice2.Product2Id = product.Id;
        standardPrice2.UnitPrice = 59900;
        standardPrice2.IsActive = true;
        insert standardPrice2;
        
        System.debug('---------------- SE CREA EL PRICEBOOK PARA EL PRODUCTO NUMERO: ');
        System.debug(standardPrice2.Pricebook2Id);
        System.debug(standardPrice2.Product2Id);
        System.debug(standardPrice2.UnitPrice);
        
        opProduct.IdOP__c = id_oportunidad;
        opProduct.OpportunityId = op.Id;
        opProduct.PricebookEntryId = standardPrice2.id;
        opProduct.IdProducto__c = product.IdProducto__c;
        opProduct.Product2Id = product.Id;
        opProduct.Quantity = 1;
        opProduct.TotalPrice = 59900;
        if(proceso == 'SinArmado'){
            opProduct.Display_Url__c = 'https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }else if(proceso == 'SinGarantia'){
            opProduct.Armable__c = true;
            opProduct.Display_Url__c ='https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }
        insert opProduct;
        
        System.debug('---------------- SE CREA EL PRODUCTO DE OPORTUNIDAD NUMERO: ');
        System.debug(opProduct.IdOP__c = id_oportunidad);
        System.debug(opProduct.OpportunityId);
        System.debug(opProduct.IdProducto__c);
        System.debug(opProduct.Product2Id);
        System.debug(opProduct.Quantity);
        
        
    }
    
    
    public static void crearOportunityAndQuoteAndProductQuote(String empresa, String id_oportunidad){
        
        Account ac = new Account();
        ac.FirstName = 'Prueba';
        ac.LastName = 'Prueba';
        ac.Empresa__c = empresa;
        ac.IdCliente__c = 'JA_001';
        ac.Identificacion__c = 'ID001';
        insert ac;
        
        System.debug('---------------- SE CREA LA CUENTA -------------------------');
        System.debug(ac.FirstName);
        
        Opportunity op = new  Opportunity();
        op.AccountId = ac.Id;
        op.Name = ac.FirstName + '_' + ac.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.IdOP__c = id_oportunidad;
        op.StageName = 'Propuesta';
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);
        
        Quote qt = new Quote();
        qt.OpportunityId = op.Id;
        qt.Name = op.Name;
        qt.Empresa__c = 'JA';
        qt.IdQuote__c = 'JP_001';
        insert qt;
        
        
        QuoteLineItem qtProduct = new QuoteLineItem();
        Product2 product = new Product2();
        PricebookEntry standardPrice2 = new PricebookEntry();
        
        
        
        
        product.Name = 'Product 001';
        product.ProductCode = '234567';
        product.IsActive = true;
        product.IdProducto__c = empresa +'_234567';
        product.Armable__c = true;
        insert product;
        
        System.debug('---------------- SE CREA EL PRODUCTO NUMERO: ');
        System.debug(product.Name);
        System.debug(product.ProductCode);
        System.debug(product.IdProducto__c);
        
        
        standardPrice2.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice2.Product2Id = product.Id;
        standardPrice2.UnitPrice = 59900;
        standardPrice2.IsActive = true;
        insert standardPrice2;
        
        System.debug('---------------- SE CREA EL PRICEBOOK PARA EL PRODUCTO NUMERO: ');
        System.debug(standardPrice2.Pricebook2Id);
        System.debug(standardPrice2.Product2Id);
        System.debug(standardPrice2.UnitPrice);
        
        
        
        qtProduct.Empresa__c = empresa;
        qtProduct.PricebookEntryId = standardPrice2.id;
        qtProduct.Product2Id = product.Id;
        qtProduct.Id_Cotizacion__c = 'JP_001';
        qtProduct.QuoteId = qt.Id;
        qtProduct.Quantity = 2;
        insert qtProduct; 
        
        
    }
    
    public static void crearOportunityContactado(String empresa, String stage){
        
        Account ac = new Account();
        ac.FirstName = 'Prueba';
        ac.LastName = 'Prueba';
        ac.Empresa__c = empresa;
        ac.Identificacion__c = '444444444';
        ac.IdCliente__c = 'JP_444444444';
        ac.Identificacion__c = 'ID001';
        insert ac;
        
        System.debug('---------------- SE CREA LA CUENTA -------------------------');
        System.debug(ac.FirstName);
        
        Opportunity op = new  Opportunity();
        op.AccountId = ac.Id;
        op.Name = ac.FirstName + '_' + ac.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.StageName = stage;
        op.Pricebook2Id = Test.getStandardPricebookId();
        op.Id_Cotizacion__c = 'JP_001';
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);        
        
    }
    
    
    
    public static void crearOportunityContactadoWithIdClient(Account act, String empresa, String stage){
        
        
        Opportunity op = new  Opportunity();
        op.AccountId = act.Id;
        op.Name = act.FirstName + '_' + act.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.StageName = stage;
        op.Pricebook2Id = Test.getStandardPricebookId();
        op.Id_Cotizacion__c = 'JP_001';
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);        
        
    }
    
    public static void crearOportunityAndQuote(String empresa, String stage){
        
        Account ac = new Account();
        ac.FirstName = 'Prueba';
        ac.LastName = 'Prueba';
        ac.Empresa__c = empresa;
        ac.Identificacion__c = '444444444';
        ac.IdCliente__c = 'JP_444444444';
        ac.Identificacion__c = 'ID001';
        insert ac;
        
        System.debug('---------------- SE CREA LA CUENTA -------------------------');
        System.debug(ac.FirstName);
        
        Opportunity op = new  Opportunity();
        op.AccountId = ac.Id;
        op.Name = ac.FirstName + '_' + ac.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.StageName = stage;
        op.Id_Cotizacion__c = 'JP_001';
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);
        
        Quote qt = new Quote();
        qt.OpportunityId = op.Id;
        qt.Name = op.Name;
        qt.Pricebook2Id = Test.getStandardPricebookId();
        qt.Empresa__c = 'JA';
        qt.IdQuote__c = 'JP_001';
        insert qt;
        
        
    }
    
    
    
    public static void createAccount(String identify){
        Account ac = new Account();
        ac.FirstName = 'Jamar';
        ac.LastName  = 'Test';
        ac.Identificacion__c = identify;
        ac.Empresa__c = 'JP';
        ac.Ultima_Fecha_Ingreso__c = DateTime.now();
        ac.IdCliente__c = 'JP_' + identify;
        insert ac;
    }
    public static void createAccountCustom(String identify, String empresa){
        Account ac = new Account();
        ac.FirstName = 'Jamar';
        ac.LastName  = 'Test';
        ac.Identificacion__c = identify;
        ac.Empresa__c = empresa;
        ac.Ultima_Fecha_Ingreso__c = DateTime.now();
        ac.IdCliente__c = empresa + '_' + identify;
        insert ac;
    }
    
    public static void createLeadEmail(String email){
        Lead lead = new Lead();
        lead.FirstName = 'Jamar';
        lead.LastName  = 'Test';
        lead.Status = 'Unqualified';
        lead.Empresa__c = 'JP';
        lead.Ultima_Fecha_Ingreso__c = DateTime.now();
        lead.Email = email;
        insert lead;
    }
    
    public static void createLeadIdentify(String identify){
        Lead lead = new Lead();
        lead.FirstName = 'Jamar';
        lead.LastName  = 'Test';
        lead.Empresa__c = 'JP';
        lead.Identificacin__c = identify;
        lead.State = 'Unqualified';
        lead.cancelarWorkFlow__c  = True;
        lead.Ultima_Fecha_Ingreso__c = DateTime.now();
        lead.Convertido__c = True;
        lead.IdCliente__c = 'JP_' + identify;
        insert lead;
    }
    
    public static void createLeadIdentifyOld(String identify){
        Lead lead = new Lead();
        lead.FirstName = 'Jamar';
        lead.LastName  = 'Test';
        lead.Empresa__c = 'JP';
        lead.Identificacin__c = identify;
        lead.State = 'Unqualified';
        lead.cancelarWorkFlow__c  = True;
        lead.Ultima_Fecha_Ingreso__c = DateTime.newInstanceGmt(2020, 01, 01);
        lead.Convertido__c = True;
        lead.IdCliente__c = 'JP_' + identify;
        insert lead;
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
    
    public static void createPricebook(){
        Pricebook2 pb = new Pricebook2();
        pb.IsActive = True;
        pb.Name = 'myPrice';
        insert pb;
        
    }
    
    public static void createAllSize(){
        
        Pricebook2 pb = new Pricebook2();
        pb.IsActive = True;
        pb.Name = 'myPrice2';
        insert pb;
        
        Product2 c = new Product2
            (
                Name = 'Prueba',
                ProductCode = '0001',
                IdProducto__c = 'JP_0001',
                IsActive = true
            );
        insert c;
        
        PricebookEntry standardPrice2 = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = c.id,
            UnitPrice = 59900, 
            IsActive = true
        );
        insert standardPrice2;
        
    }
    
    public static void crearCase(string ownerId, String AccountId, String OpportunityId){
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

	public static void crearCaseGarantia(string identificacion, String causalCaso, String idOportunidad, String idProducto, String statuscaso){
        Case caso= new Case();
            caso.Causal_Principal__c = causalCaso;
			caso.Status = statuscaso;
            caso.SubTipodeGestion__c='Reservicio';
            caso.RecordTypeId='0124O000000EMTD';
            caso.Origin='Llamadas';
            caso.Reason='Sin Productos disponible';
            caso.SLA_Dias_de_Vida__c=10;
            caso.Priority='Medium';
            //caso.OwnerId='2F0012D00000bCp4zQAC';
            caso.Tipo_Solicitud__c='PETICION';
            caso.Description='Orden de pedido con productos agotados';
			caso.AccountId= identificacion;
            caso.Oportunidad__c = idOportunidad;
			caso.Opportunity_Product__c = idProducto;
            insert caso;
    }

	public static void crearCaseGarantiaSinOp(string identificacion, String causalCaso, String statuscaso){
        Case caso= new Case();
            caso.Causal_Principal__c = causalCaso;
			caso.Status = statuscaso;
            caso.SubTipodeGestion__c='Reservicio';
            caso.RecordTypeId='0124O000000EMTD';
            caso.Origin='Llamadas';
            caso.Reason='Sin Productos disponible';
            caso.SLA_Dias_de_Vida__c=10;
            caso.Priority='Medium';
            //caso.OwnerId='2F0012D00000bCp4zQAC';
            caso.Tipo_Solicitud__c='PETICION';
            caso.Description='Orden de pedido con productos agotados';
			caso.AccountId= identificacion;
            insert caso;
    }

	public static void crearProductosOPEspecifica(Integer iTotReg,String idOportunidad){
        list<OpportunityLineItem> listOpItems = new list<OpportunityLineItem>();
        MapOpItems = new Map<Integer, OpportunityLineItem>();
		Product2 product = new Product2();
		product.Name = 'Product 001';
        product.ProductCode = '23456789';
        product.IsActive = true;
        product.Estado_de_producto__c='INACTIVO';
        product.IdProducto__c = 'JA' +'_23456789';
		insert product;
        PricebookEntry standardPrice2 = new PricebookEntry();
        standardPrice2.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice2.Product2Id = product.Id;
        standardPrice2.UnitPrice = 59900;
        standardPrice2.IsActive = true;
        insert standardPrice2;
        for (Integer x=0;x<iTotReg;x++){
            OpportunityLineItem item = new OpportunityLineItem(
                PriceBookEntryId = standardPrice2.id,
                OpportunityId = idOportunidad ,
                Quantity = 1,
                TotalPrice = 59900,
                IdProducto__c = 'JP_0001',
                IdOP__c = 'JP_0001'
            );
            
            listOpItems.add(item);
            MapOpItems.put(x, item);
        }
        if(MapOpItems.size()>0) insert MapOpItems.values();
    }

    public static void crearOrdenPedido(TestDataFactory value){
        List<String> datosOp = new List<String>();
        for(String st : value.id_oportunidad.split('_')){         
            datosOp.add(st);
        }
        String empresa = datosOp[0];
        String agencia = datosOp[1];
        String periodo = datosOp[2];
        String Ordenpedido = datosOp[3];
        Account ac = new Account();
        ac.FirstName = 'Prueba';
        ac.LastName = 'Prueba';
        ac.Empresa__c = value.empresa;
        ac.IdCliente__c = 'JA_001';
        ac.Identificacion__c = 'ID001';
        insert ac;
        
        System.debug('---------------- SE CREA LA CUENTA -------------------------');
        System.debug(ac.FirstName);
        
        Opportunity op = new  Opportunity();
		op.Numero_OP__c = Ordenpedido;
        op.AccountId = ac.Id;
        op.Name = ac.FirstName + '_' + ac.LastName;
        op.CloseDate = Date.newInstance(2020, 01, 01);
        op.IdOP__c = value.id_oportunidad;
        op.StageName = 'Propuesta';
        op.CodigoVendedor__c=value.codigoVendedor;
        insert op;
        System.debug('---------------- SE CREA LA OPORTUNIDAD DE VENTA -------------------------');
        System.debug(op.Name);
        System.debug(op.IdOP__c);
        
        
        List<OpportunityLineItem> alm_prod_op = new List<OpportunityLineItem>();        
        OpportunityLineItem opProduct = new OpportunityLineItem();
        Product2 product = new Product2();
        PricebookEntry standardPrice2 = new PricebookEntry();
        
        
        
        
        product.Name = 'Product 001';
        product.ProductCode = '234567';
        product.IsActive = true;
        product.Estado_de_producto__c='INACTIVO';
        product.IdProducto__c = value.empresa +'_234567';
        if(value.proceso == 'SinUrl'){
            product.Armable__c = false;
            product.Aplica_garantia__c ='SI';
        }else{
            product.Armable__c = true;
            product.Aplica_garantia__c = 'SI';
            product.DisplayUrl = 'https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }    
        insert product;
        
        System.debug('---------------- SE CREA EL PRODUCTO NUMERO: ');
        System.debug(product.Name);
        System.debug(product.ProductCode);
        System.debug(product.IdProducto__c);
        
        
        standardPrice2.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice2.Product2Id = product.Id;
        standardPrice2.UnitPrice = 59900;
        standardPrice2.IsActive = true;
        insert standardPrice2;
        
        System.debug('---------------- SE CREA EL PRICEBOOK PARA EL PRODUCTO NUMERO: ');
        System.debug(standardPrice2.Pricebook2Id);
        System.debug(standardPrice2.Product2Id);
        System.debug(standardPrice2.UnitPrice);
        
        opProduct.IdOP__c = value.id_oportunidad;
        opProduct.OpportunityId = op.Id;
        opProduct.PricebookEntryId = standardPrice2.id;
        opProduct.IdProducto__c = product.IdProducto__c;
        opProduct.Product2Id = product.Id;
        opProduct.Quantity = 1;
        opProduct.TotalPrice = 59900;
        if(value.proceso == 'SinArmado'){
            opProduct.Display_Url__c = 'https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }else if(value.proceso == 'SinGarantia'){
            opProduct.Armable__c = true;
            opProduct.Display_Url__c ='https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789630.jpeg';
        }
        insert opProduct;
        
        System.debug('---------------- SE CREA EL PRODUCTO DE OPORTUNIDAD NUMERO: ');
        System.debug(opProduct.IdOP__c = value.id_oportunidad);
        System.debug(opProduct.OpportunityId);
        System.debug(opProduct.IdProducto__c);
        System.debug(opProduct.Product2Id);
        System.debug(opProduct.Quantity);
        
        
    }
    
    
}