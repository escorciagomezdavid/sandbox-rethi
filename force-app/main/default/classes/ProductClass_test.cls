@isTest
public class ProductClass_test {
    
    @isTest
    public static void producTratamentCreate_test(){
        
        TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
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
							'"Oportunidad" : {' +
								'"cliente":"444444444",' +
								'"idCliente":"JP_444444444",' +
            					'"agenciaPedido":"JP_001",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JA_001",' +
								'"tipoVenta":"CO",' +
								'"codigoVendedor":"BR-0101",' +
								'"nombreVendedor":"BRAYAN SILVERA",' +
								'"emisionOrdenPedido":"2020-08-15",' +
								'"cuotas":10,' +
								'"direccionDespacho":"San Pablo de Heredia",' +
								'"estadoOrdenPedido":"F",' +
								'"idEstudio":"JP_99_130411",' +
            					'"etapaCredito":"JP_99_130411",' +
								'"completacionCredito":"OTROS",' +
								'"ordenPedidoAprobada":"Si",' +
								'"fechaEntrega":"2020-08-15",' +
								'"propuestaPago":"Pago Total",' +
            					'"cotizacionPedidoEnviada":"SI",' +
								'"pedidoFactura":"Si",' +
            					'"motivoPerdida":"Oportunidad Abierta Mas de 30 dias",' +	
								'"tipoOportunidad":"Crédito",' +
            					'"tipoPago":"efectivo",' +
								'"origen":"Aplica_Credito",' +
            					'"pin":"23232",' +
            					'"cerrada":"Ganada",' +
								'"existeInventario":true,' +
            					'"opDeTercero":true,' +
            					'"listoFacturar":true,' +
								'"fechaFacturacion":"2020-08-15",' +
            					'"fechaCreacionOP":"2020-08-15",' +
            					'"tipoGestion":"Ventas",' +
            					'"fechaCompletacionCredito":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
            					'"fechaDespacho":"2020-08-15",' +
            					'"citaEntrega":"2020-08-15",' +
            					'"idCotizacion":"JP_001",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"listoFacturarFecha":"2020-08-04",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+
							'},' +
							'"Productos" : [' +
								'{' +
									'"idProducto":"JP_0001",' +
									'"idOP":"JP_0101",' +
									'"cantidad":5,' +
									'"precioSinDescuento":500,' +
									'"porcDCTO":15,' +
									'"diasGarantia":120,' +
									'"aplicaCambio":"No",' +
									'"obsequio":"Si",' +
									'"valor":20000,' +
									'"idDetalleOP":"JP_99_2020_000001_1",' +
									'"valorDCTO":247' +
								'}' +
							']' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        ProductClass.producTratament(middles);
        Test.stopTest();
    }
    
    @isTest
    public static void producTratamentDelete_test(){
        
        TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
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
							'"Oportunidad" : {' +
								'"cliente":"444444444",' +
								'"idCliente":"JP_444444444",' +
            					'"agenciaPedido":"JP_001",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JA_001",' +
								'"tipoVenta":"CO",' +
								'"codigoVendedor":"BR-0101",' +
								'"nombreVendedor":"BRAYAN SILVERA",' +
								'"emisionOrdenPedido":"2020-08-15",' +
								'"cuotas":10,' +
								'"direccionDespacho":"San Pablo de Heredia",' +
								'"estadoOrdenPedido":"F",' +
								'"idEstudio":"JP_99_130411",' +
            					'"etapaCredito":"JP_99_130411",' +
								'"completacionCredito":"OTROS",' +
								'"ordenPedidoAprobada":"Si",' +
								'"fechaEntrega":"2020-08-15",' +
								'"propuestaPago":"Pago Total",' +
            					'"cotizacionPedidoEnviada":"SI",' +
								'"pedidoFactura":"Si",' +
            					'"motivoPerdida":"Oportunidad Abierta Mas de 30 dias",' +	
								'"tipoOportunidad":"Crédito",' +
            					'"tipoPago":"efectivo",' +
								'"origen":"Aplica_Credito",' +
            					'"pin":"23232",' +
            					'"cerrada":"Ganada",' +
								'"existeInventario":true,' +
            					'"opDeTercero":true,' +
            					'"listoFacturar":true,' +
								'"fechaFacturacion":"2020-08-15",' +
            					'"fechaCreacionOP":"2020-08-15",' +
            					'"tipoGestion":"Ventas",' +
            					'"fechaCompletacionCredito":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
            					'"fechaDespacho":"2020-08-15",' +
            					'"citaEntrega":"2020-08-15",' +
            					'"idCotizacion":"JP_001",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"listoFacturarFecha":"2020-08-04",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+
							'},' +
							'"Productos" : [' +
								'{' +
									'"idProducto":"JP_0001",' +
									'"idOP":"JP_0101",' +
									'"cantidad":5,' +
									'"precioSinDescuento":500,' +
									'"porcDCTO":15,' +
									'"diasGarantia":120,' +
									'"aplicaCambio":"No",' +
									'"obsequio":"Si",' +
									'"valor":20000,' +
									'"idDetalleOP":"JP_99_2020_000001_1",' +
									'"valorDCTO":247' +
								'}' +
							']' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        ProductClass.producTratament(middles);
        Test.stopTest();
    }
    
     @isTest
    public static void producTratamentUpdate_test(){
        
        TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
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
							'"Oportunidad" : {' +
								'"cliente":"444444444",' +
								'"idCliente":"JP_444444444",' +
            					'"agenciaPedido":"JP_001",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JA_001",' +
								'"tipoVenta":"CO",' +
								'"codigoVendedor":"BR-0101",' +
								'"nombreVendedor":"BRAYAN SILVERA",' +
								'"emisionOrdenPedido":"2020-08-15",' +
								'"cuotas":10,' +
								'"direccionDespacho":"San Pablo de Heredia",' +
								'"estadoOrdenPedido":"F",' +
								'"idEstudio":"JP_99_130411",' +
            					'"etapaCredito":"JP_99_130411",' +
								'"completacionCredito":"OTROS",' +
								'"ordenPedidoAprobada":"Si",' +
								'"fechaEntrega":"2020-08-15",' +
								'"propuestaPago":"Pago Total",' +
            					'"cotizacionPedidoEnviada":"SI",' +
								'"pedidoFactura":"Si",' +
            					'"motivoPerdida":"Oportunidad Abierta Mas de 30 dias",' +	
								'"tipoOportunidad":"Crédito",' +
            					'"tipoPago":"efectivo",' +
								'"origen":"Aplica_Credito",' +
            					'"pin":"23232",' +
            					'"cerrada":"Ganada",' +
								'"existeInventario":true,' +
            					'"opDeTercero":true,' +
            					'"listoFacturar":true,' +
								'"fechaFacturacion":"2020-08-15",' +
            					'"fechaCreacionOP":"2020-08-15",' +
            					'"tipoGestion":"Ventas",' +
            					'"fechaCompletacionCredito":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
            					'"fechaDespacho":"2020-08-15",' +
            					'"citaEntrega":"2020-08-15",' +
            					'"idCotizacion":"JP_001",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"listoFacturarFecha":"2020-08-04",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+
							'},' +
							'"Productos" : [' +
								'{' +
									'"idProducto":"JA_234567",' +
									'"idOP":"JP_0101",' +
									'"cantidad":5,' +
									'"precioSinDescuento":500,' +
									'"porcDCTO":15,' +
									'"diasGarantia":120,' +
									'"aplicaCambio":"No",' +
									'"obsequio":"Si",' +
									'"valor":20000,' +
									'"idDetalleOP":"JP_99_2020_000001_1",' +
									'"valorDCTO":247' +
								'}' +
							']' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        ProductClass.producTratament(middles);
        Test.stopTest();
    }
    
    
    @isTest
    public static void getOpportunityLineItemWithId_test(){
        TestDataFactory.crearOportunityAndProducts('JA', 'JA001', 'NA');
        List<Opportunity> op = new List<Opportunity>();
        op = [SELECT Id FROM Opportunity Where IdOP__c =: 'JA001'];
        
        Test.startTest();
        ProductClass.getOpportunityLineItemWithId(op[0]);
        Test.stopTest();
        
        
    }

}