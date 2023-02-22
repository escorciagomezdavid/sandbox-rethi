@isTest
public class EntryPoint_test {
    
    @isTest
    public static void createLead(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
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
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void createLeadWithOutPhone(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void createLeadEmailAndPhone(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void createLeadEmail(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
     @isTest
    public static void updateLeadEmail(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadEmail('jamartest@jamar.com');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void updateLeadEmailPhone(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadEmail('jamartest@jamar.com');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void updateLead(){
        String identify = '444444444';
        TestDataFactory.createLeadIdentify(identify);
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
    
    	RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();

    }
    
    @isTest
    public static void createAccountAdnOp(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();	
        TestDataFactory.crearProductos(1);
        TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.createPricebook();


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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
   
    
    @isTest
    public static void createAccountAdnOpWithOutPhone(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();	
        TestDataFactory.crearProductos(1);
        TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.createPricebook();


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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
    @isTest
    public static void updateAccount(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccount('444444444');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
    
     @isTest
    public static void failProcessor(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccount('444444444');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"jamartestjamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
    @isTest
    public static void failProcessorColombia(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccount('444444444');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"jamartestjamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
            					'"pais":"Colombia",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
     @isTest
    public static void convertProcessor(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccount('444444444');
        TestDataFactory.createLeadIdentify('444444444');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_444444444",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
    
     @isTest
    public static void opViejaLead(){
         TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
        TestDataFactory.createLeadIdentify('444444444');
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
     @isTest
    public static void opViejaAccount(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
        TestDataFactory.createAccount('444444444');
        
        List<Account> act = [SELECT ID, FirstName, LastName FROM ACCOUNT WHERE idcliente__c =: 'JP_444444444'];
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JP', 'Contactado');
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JP', 'Contactado');
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
     @isTest
    public static void updateOpportunityIdOp(){
         TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
    
    
     @isTest
    public static void updateOpportunityIdOpAndCreateQuote(){
         TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createPricebook();
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
         String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"ID001",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_001",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"v",' +
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
        
        
    }
   	
    @isTest
    public static void productTratament(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
								'"emisionOrdenPedido":"2022-08-15",' +
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
									'"idOP":"JA_001",' +
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
        
         RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
    }
    
    @isTest
    public static void createQuote(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadIdentify('444444444');
        TestDataFactory.createPricebook();
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
    }
    
   	
    @isTest
    public static void overWriteOpWithIdOp(){
        					/**
                             * Si existe una oportunidiad en etpa cotizacion, con una cotizacion ejemplo 001 e ingresa de nuestro sistema un OP con id cotizacion 001 esta se monta sobre la oportunidad abierta en cotizacion
                             * **/
     	TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.crearOportunityAndQuote('JP', 'Contactado');
        TestDataFactory.createPricebook();

        
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"ID001",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JA_001",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"ID001",' +
								'"idCliente":"JA_001",' +
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
                
        
    }
    
    
    
    @isTest
    public static void updateQuote(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.crearOportunityAndQuote('JP', 'Contactado');
        TestDataFactory.createLeadIdentify('44444444');
        TestDataFactory.createPricebook();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"ID001",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_001",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"v",' +
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

							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
    }
    
    @isTest
    public static void productTratamentQuote(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
        TestDataFactory.crearOportunityAndQuote('JA', 'Contactado');
        TestDataFactory.createLeadIdentify('44444444');
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
								'"identificacion":"44444444",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_44444444",' +
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
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
    }
    
    
    
    @istest
    public static void requestNull(){
        String JsonMsg = '';
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();
    }
    
   @isTest
    public static void accountSameEmailPhoneAndDiferenteIdentify(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountWithEmailAndPhone('444444444', 'bsilvera@jamar.com', '3207238250', 'JA');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"5555555555",' +
								'"correoElectronico":"bsilvera@jamar.com",' +
								'"celular":"3207238250",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JA_5555555555",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
    
    @isTest
    public static void accountRecordWithoutIdentifyAndOpportunitty(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountWithEmailAndPhone('444444444', 'bsilvera3@jamar.com', '32072382503', 'JA');
        list<Account> act = [SELECT ID, FirstName, LastName FROM Account where idCliente__C =: 'JA_444444444'];
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JA', 'Contactado');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"bsilvera3@jamar.com",' +
								'"celular":"32072382503",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
     @isTest
    public static void accountRecordWithoutIdentifyAndTwoOpportunitty(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountWithEmailAndPhone('444444444', 'bsilvera3@jamar.com', '32072382503', 'JA');
        list<Account> act = [SELECT ID, FirstName, LastName FROM Account where idCliente__C =: 'JA_444444444'];
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JA', 'Contactado');
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JA', 'Contactado');
        TestDataFactory.crearOportunityContactadoWithIdClient(act[0], 'JA', 'Contactado');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"bsilvera3@jamar.com",' +
								'"celular":"32072382503",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
    
     @isTest
    public static void accountRecordWithoutIdentifyAndNoNeOpportunitty(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountWithEmailAndPhone('444444444', 'bsilvera3@jamar.com', '32072382503', 'JA');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"bsilvera3@jamar.com",' +
								'"celular":"32072382503",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
    @isTest
    public static void accountMultAndSameEmailAndAccountOneOpportunity(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountWithEmailAndPhone('444444444', 'bsilvera3@jamar.com', '32072382503', 'JA');
        TestDataFactory.createAccountWithEmailAndPhone('555555555', 'bsilvera3@jamar.com', '32072382503', 'JA');
        
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"correoElectronico":"bsilvera3@jamar.com",' +
								'"celular":"32072382503",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Panama",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
    
     @isTest
    public static void leadSameEmailPhoneAndDiferenteIdentify(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadWithEmailAndPhone('114311111', 'bsilvera2@jamar.com', '32072382502', 'JP');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"11111555",' +
								'"correoElectronico":"bsilvera2@jamar.com",' +
								'"celular":"32072382502",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_11111555",' +
            					'"pais":"Colombia",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Panama",' +
                                '"latitudResidencia":"10",' +
                                '"longitudResidencia":"10",' +
            					'"calleResidencia":"10",' +
            					'"telefonoFijo":"102828282",' +
            					'"telefonoTrabajo":"102828282",' +
                                '"ciudadTrabajo":"PAN",' +
            					'"longitudTrabajo":"10",' +
                                '"latitudTrabajo":"10",' +
            					'"calleTrabajo":"10",' +
            					'"anioInicio":"10",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    
    @isTest
    public static void leadCreateBasic(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"departamento":"ATL",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"empresa":"JP",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
            					'"pais":"Colombia",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/v2/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		ResponseClass response = EntryPoint.entryPointAccess();
		Test.stopTest();  
    }
    	
}