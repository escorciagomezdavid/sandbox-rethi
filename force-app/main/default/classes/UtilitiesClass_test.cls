@isTest
public class UtilitiesClass_test {

    @isTest
    public static void validations_test(){
         String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
         
         
         
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        UtilitiesClass.validations(middles);
        Test.stopTest();
        
    }
    
     @isTest
    public static void validationsFailOrigen_test(){
         String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsAp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
         
         
         
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
       Test.startTest();
        Boolean exceptionOccurred = false;
        try{
            UtilitiesClass.validations(middles); 
        }catch(CustomException e) {
            exceptionOccurred = true;
        }
       	System.assertEquals(true, exceptionOccurred);
        Test.stopTest();
        
    }
     @isTest
    public static void validationsFailEmail_test(){
         String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartestñjamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
         
         
         
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        Boolean exceptionOccurred = false;
        try{
            UtilitiesClass.validations(middles); 
        }catch(CustomException e) {
            exceptionOccurred = true;
        }
       	System.assertEquals(false, exceptionOccurred);
        Test.stopTest();
        
    }
    
    @isTest
    public static void validationsOrigenOp_test(){
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
								'"idCliente":"",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"B-100000",' +
								'"tipoVenta":"CO",' +
								'"codigoVendedor":"BR-0101",' +
								'"nombreVendedor":"BRAYAN SILVERA",' +
								'"emisionOrdenPedido":null,' +
								'"cuotas":10,' +
								'"direccionDespacho":"San Pablo de Heredia",' +
								'"estadoOrdenPedido":"F",' +
								'"idEstudio":"JP_99_130411",' +
								'"completacionCredito":"OTROS",' +
								'"ordenPedidoAprobada":"Si",' +
								'"fechaEntrega":"2020-08-15",' +
								'"propuestaPago":"Pago Total",' +
								'"pedidoFactura":"Si",' +
								'"tipoOportunidad":"Crédito",' +
								'"origen":"Aplica_Credito",' +
								'"existeInventario":true,' +
								'"fechaFacturacion":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+

							'}' +
						'}';
         
         
         
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        UtilitiesClass.validations(middles);
        Test.stopTest();
        
    }

	@isTest static void crearLogJA(){
		UtilitiesClass.crearLog('Consumo en ws', 'JA', 'PRUEBA', 'HOLA', '');
	}

	@isTest static void crearLogJP(){
		UtilitiesClass.crearLog('Consumo en ws', 'JP', 'PRUEBA', 'HOLA', '');
	}
    
}