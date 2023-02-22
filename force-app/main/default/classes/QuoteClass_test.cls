@isTest
public class QuoteClass_test {
    
    @isTest
    public static void getQuoteWithId_test(){
        
        Test.startTest();
        QuoteClass.getQuoteWithId('A001');
        QuoteClass.getQuoteWithIdOpportunity('A001');
        Test.stopTest();
    }
    
    @isTest
    public static void createdQuote_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
        List<Opportunity> op = new List<Opportunity>();
        op = [SELECT Id, Name FROM Opportunity where Id_Cotizacion__c =: 'JP_001'];
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_001",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Quote" : {' +
								'"idCotizacion":"JP_001",' +
								'"empresa":"JP",' +
            					'"idProspectoInterno":"100",' +
            					'"fechaVencimiento":"2020-08-15",' +
            					'"fechaCreacion":"2020-08-15",' +
            					'"usuarioCreacion":"Brayan",' +
            					'"usuarioModificacion":"Brayan",' +
            					'"usuarioAnulacion":"Brayan",' +
            					'"usuarioCierre":"Brayan",' +
            					'"codigoAgencia":"JP_001",' +
            					'"numeroOrdenPedido":999999,' +
            					'"tipoCotizacion":"Contado",' +
            					'"tipoCierre":"Ganado",' +
            					'"vigencia":1,' +
            					'"facturasUnidas":true,' +
            					'"fechaCierre":"2020-08-15",' +
            					'"motivoCierre":"YA TIENE OP",' +
            					'"origenVenta":"GRUPO 5",' +
            					'"estado":"Inactivo"'+

							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        QuoteClass.createdQuote(middles, op[0]);
        Test.stopTest();
    }
    
    @isTest
    public static void updateQuote_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
        TestDataFactory.crearOportunityAndQuote('JA', 'Contactado');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_001",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Quote" : {' +
								'"idCotizacion":"JP_001",' +
								'"empresa":"JP",' +
            					'"idProspectoInterno":"100",' +
            					'"fechaVencimiento":"2020-08-15",' +
            					'"fechaCreacion":"2020-08-15",' +
            					'"usuarioCreacion":"Brayan",' +
            					'"usuarioModificacion":"Brayan",' +
            					'"usuarioAnulacion":"Brayan",' +
            					'"usuarioCierre":"Brayan",' +
            					'"codigoAgencia":"JP_001",' +
            					'"numeroOrdenPedido":999999,' +
            					'"tipoCotizacion":"Contado",' +
            					'"tipoCierre":"Ganado",' +
            					'"vigencia":1,' +
            					'"facturasUnidas":true,' +
            					'"fechaCierre":"2020-08-15",' +
            					'"motivoCierre":"YA TIENE OP",' +
            					'"origenVenta":"GRUPO 5",' +
            					'"estado":"Inactivo"'+

							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        QuoteClass.updateQuote(middles);
        Test.stopTest();
    }
    
    @isTest
    public static void syncQuoteAndUpdateOpportunity_test(){
        TestDataFactory.crearOportunityAndQuote('JP', 'Contactado');
        List<Opportunity> op = [SELECT Id From Opportunity where Id_Cotizacion__c =: 'JP_001'];
        List<Quote> qt = [SELECT Id, GrandTotal, IdQuote__c From Quote Where IdQuote__c =: 'JP_001'];
        
        Test.startTest();
        QuoteClass.syncQuoteAndUpdateOpportunity(op[0].id, qt[0].id);
        Test.stopTest();
        
    }
    

}