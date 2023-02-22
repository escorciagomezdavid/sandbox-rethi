@isTest
public class ProductQuoteClass_test {

    
    @isTest
    public static void createdProductQuote_test(){
        
        TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.crearOportunityAndQuote('JA', 'Contactado');
        List<Quote> qt = new List<Quote>();
        qt = [Select id, IdQuote__c, OpportunityId From Quote Where IdQuote__c =: 'JP_001'];
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
								'"agencia":"JP_00",' +
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
            					'"motivoCierre":"F",' +
            					'"origenVenta":"Chat de ventas",' +
            					'"estado":"Inactivo"'+
							'},' +
							'"ProductosQuote" : [' +
								'{' +
									'"idCotizacionDetalle":"JP_1001_1",' +
									'"idCotizacion":"JP_001",' +
									'"cantidad":5,' +
            						'"numeroCuotas":5,' +
            						'"valorCuotas":5,' +
									'"empresa":"JA",' +
									'"estadoCotizacion":"Activo",' +
									'"usuarioAnulacion":"Brayan Silvera",' +
									'"fechaAnulacion":"2020-08-15",' +
									'"idDetalleOP":"JP_99_2020_3550104_1",' +
									'"codigoProducto":"JP_0001",' +
									'"valor":247' +
								'}' +
							']' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        ProductQuoteClass.createdProductQuote(middles, qt[0]);
        Test.stopTest();
        
    }
    
}