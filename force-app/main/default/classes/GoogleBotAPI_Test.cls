/*
  Creado por David Leon
  Fecha creacion: 04/08/2020
  Descripcion: Clase Test para el web service GoogleBotAPI
*/

@isTest
private class GoogleBotAPI_Test {
	
	static{
		TestDataFactory.createGeneralData();
	}
	
	//Metodo para testear la validacion de un request null
	@isTest
	private static void peticionNull() {
		String JsonMsg = '{}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		//RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear el origen del registro
	@isTest
	private static void validarOrigenMalo() {
		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Prueba",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"444444444",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panamá",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear la creacion de un prospecto nuevo
	@isTest
	private static void crearProspectoNuevo() {
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
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}
	
	//Metodo para testear la actualizacion de un prospecto nuevo, busqueda por medio de la cedula
	@isTest
	private static void actualizarProspecto() {
		TestDataFactory.createLeadIndividual(1);
		TestDataFactory.mapLeads.get(0).Identificacin__c = '444444444';
		update TestDataFactory.mapLeads.values();

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
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"123456",' +
								'"longitudResidencia":"123456",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"123456",' +
								'"longitudTrabajo":"123456",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear la actualizacion de un prospecto nuevo, busqueda por medio del correo
	@isTest
	private static void actualizarProspectoEmail() {
		TestDataFactory.createLeadIndividual(1);
		TestDataFactory.mapLeads.get(0).Email = 'prueba@prueba.com';
		update TestDataFactory.mapLeads.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"0.0000",' +
								'"longitudResidencia":"0.0000",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"0.0000",' +
								'"longitudTrabajo":"0.0000",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear  la validacion cuando existe mas de 1 lead con la misma cedula
	@isTest
	private static void actualizarProspectoError() {
		TestDataFactory.createLeadIndividual(2);
		TestDataFactory.mapLeads.get(0).Identificacin__c = '444444444';
		TestDataFactory.mapLeads.get(1).Identificacin__c = '444444444';
		update TestDataFactory.mapLeads.values();

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
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear la validacion cuando existe mas de 1 lead con el mismo correo
	@isTest
	private static void actualizarProspectoError2() {
		TestDataFactory.createLeadIndividual(2);
		TestDataFactory.mapLeads.get(0).Email = 'prueba@prueba.com';
		TestDataFactory.mapLeads.get(1).Email = 'prueba@prueba.com';
		update TestDataFactory.mapLeads.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para testear el error al tratar de crear un prospecto nuevo
	@isTest
	private static void actualizarProspectoError3() {
		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"estrategia":"error"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para validar si existe el cliente por medio del idCliente
	@isTest
	private static void validarIdCliente() {
		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo crear una cuenta nueva
	@isTest
	private static void crearCuenta() {
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
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"0.0000",' +
								'"longitudResidencia":"0.00000",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"0.0000",' +
								'"longitudTrabajo":"0.0000",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama",' +
								'"ciudadResidencia":"prueba",' +
								'"telefonoTrabajo":"88888888",' +
								'"anioInicio":"2020",' +
								'"fechaNacimiento":"2020-01-01",' +
								'"telefonoDomicilio":"88888888",' +
								'"sexo":"MASCULINO",' +
								'"estadoCivil":"SOLTERO",' + 
								'"tieneCuentaActiva":"SI",' +
								'"tipoPagoUltimaCompraContado":"efectivo",' +
            					'"pais":"Colombia",' +
								'"aceptoContactoWhatsapp":' + true + ',' +
								'"ofertaEspecial":' + true + ',' +
            					'"tipoGestion": "Venta"' +
							'},' +
							'"Oportunidad" : {' +
								'"idOP":"JP_0202",' +
								'"origen":"Aplica_Credito",' +
								'"etapa":"Contactado",' +
            					'"listoFacturarFecha":"2020-08-15",' +
            					'"fechaDespacho":"2020-08-15",' +
            					'"citaEntrega":"2020-08-15",' +
            					'"listoFacturar":' + true + ',' +
            					'"opDeTercero":' + true + ',' +
								'"fechaCierre":"2020-08-15",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+
							'}' +
						'}';
		System.debug(JsonMsg);
		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}
    
    //Metodo crear una cuenta nueva
	@isTest
	private static void crearCuentaBoll() {
        TestDataFactory.createLeadIndividual(1);
		TestDataFactory.mapLeads.get(0).Identificacin__c = '444444444';
		update TestDataFactory.mapLeads.values();
        
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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"0.0000",' +
								'"longitudResidencia":"0.00000",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"0.0000",' +
								'"longitudTrabajo":"0.0000",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama",' +
								'"ciudadResidencia":"prueba",' +
								'"telefonoTrabajo":"88888888",' +
								'"anioInicio":"2020",' +
								'"fechaNacimiento":"2020-01-01",' +
								'"telefonoDomicilio":"88888888",' +
								'"sexo":"MASCULINO",' +
								'"estadoCivil":"SOLTERO",' + 
								'"tieneCuentaActiva":"SI",' +
								'"tipoPagoUltimaCompraContado":"efectivo",' +
								'"aceptoContactoWhatsapp":' + true + ',' +
								'"ofertaEspecial":' + true + ',' +
            					'"tipoGestion": "Venta"' +
							'},' +
							'"Oportunidad" : {' +
								'"idOP":"JP_0202",' +
								'"origen":"Aplica_Credito",' +
								'"etapa":"Contactado",' +
								'"fechaCierre":"2020-08-15",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+

							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
        Boolean createOpOld=True;
        GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo crear una cuenta nueva, oportunidad con origen incorrecto
	@isTest
	private static void crearCuenta2() {
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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"0.0000",' +
								'"longitudResidencia":"0.00000",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"0.0000",' +
								'"longitudTrabajo":"0.0000",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama"' +
							'},' +
							'"Oportunidad" : {' +
								'"idOP":"JP_0202",' +
								'"origen":"AplicasCredito",' +
								'"etapa":"Contactado",' +
								'"fechaCierre":"2020-08-15",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}
	
	//Metodo actualizar una cuenta
	@isTest
	private static void actualizarCuenta() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_444444444';
		update TestDataFactory.mapAccounts.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
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
								'"quieroQueLlamen":"SI",' +
								'"tipoCredito":"CR",' +
								'"etapa":"Nuevo",' +
								'"telefonoFijo":"77777777",' +
								'"whatsapp":"88888888",' +
								'"latitudResidencia":"0.0000",' +
								'"longitudResidencia":"0.0000",' +
								'"calleResidencia":"prueba",' +
								'"ciudadTrabajo":"prueba",' +
								'"paisTrabajo":"panama",' +
								'"latitudTrabajo":"0.0000",' +
								'"longitudTrabajo":"0.0000",' +
								'"calleTrabajo":"prueba",' +
								'"cupoDisponible":"55",' +
								'"productoInteres":"prueba producto",' +
								'"cuantosContactosTenido":"2",' +
								'"lineaLlamada":"Telefono",' +
								'"cuotaDisponible":"55000",' +
								'"viabilidad":"VERDE",' +
								'"estrategia":"AZUL",' +
								'"segmento":"CLIENTE NUEVO",' +
								'"ocupacion":"COMERCIANTE FORMAL",' +
								'"ingresos":"150000",' +
								'"tipoReferencia":"-AGREGADO",' +
								'"tipoRelacion":"CLIENTE",' +
								'"paisResidencia":"panama",' +
								'"ciudadResidencia":"prueba",' +
								'"telefonoTrabajo":"88888888",' +
								'"anioInicio":"2020",' +
								'"fechaNacimiento":"2020-01-01",' +
								'"telefonoDomicilio":"88888888",' +
								'"sexo":"MASCULINO",' +
								'"estadoCivil":"SOLTERO",' + 
								'"tieneCuentaActiva":"SI",' +
								'"tipoPagoUltimaCompraContado":"efectivo",' +
								'"aceptoContactoWhatsapp":' + true + ',' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo actualizar una cuenta nueva, se envia la identificacion vacia
	@isTest
	private static void actualizarCuenta3() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"Aplica_Credito",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"",' +
								'"correoElectronico":"prueba@prueba.com",' +
								'"celular":"44444444",' +
								'"agencia":"JP_00",' +
								'"pais":"Panama",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para actualizar una oportunidad existente
	@isTest
	private static void actualizarOportunidad() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_444444444';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);

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

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para actualizar una oportunidad existente con idOP
	@isTest
	private static void actualizarOportunidadIdOP() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);
		TestDataFactory.mapOpportunities.get(0).IdOP__c = 'JP_0101';
		update TestDataFactory.mapOpportunities.values();

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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para tratar de crear una segunda oportunidad sin idOP
	@isTest
	private static void crearSegundaOportunidad() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);

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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo crear una cuenta nueva y una oportunidad nueva
	@isTest
	private static void crearCuentaOP() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para crear un producto
	@isTest
	private static void actualizarProducto() {
        //TestDataFactory.createGeneralData();
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);
		TestDataFactory.mapOpportunities.get(0).IdOP__c = 'JP_0101';
		update TestDataFactory.mapOpportunities.values();
		
        
		TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);
		TestDataFactory.crearProductosOP(1);



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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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
								'"fechaAprobacion":"2020-08-04"' +
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

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para actualizar una oportunidad existente con idOP
	@isTest
	private static void actualizarOportunidadIdOPAppVendedor() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);
		//TestDataFactory.mapOpportunities.get(0).IdOP__c = 'JP_0101';
		//update TestDataFactory.mapOpportunities.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"App Vendedor",' +
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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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
								'"origen":"App Vendedor",' +
								'"existeInventario":true,' +
								'"fechaFacturacion":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"Cerrada":"Perdida",' +
                        		'"tipoPago":"Contado",' +
                                '"fechaCompletacionCredito":"2020-08-15"' +


							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para actualizar una oportunidad existente con idOP
	@isTest
	private static void actualizarOportunidadIdOPAppVendedor2() {
		TestDataFactory.createAccountIndividual(1);
		TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		update TestDataFactory.mapAccounts.values();

		TestDataFactory.createOpportunities(1);
		TestDataFactory.mapOpportunities.get(0).IdOP__c = 'JP_0101';
		update TestDataFactory.mapOpportunities.values();

		String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"App Vendedor",' +
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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
           						'"ultimaFechaPrecalificacion":"2020-08-15",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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
								'"origen":"App Vendedor",' +
								'"existeInventario":true,' +
								'"fechaFacturacion":"2020-08-15",' +
								'"fechaCierre":"2020-08-15",' +
								'"fechaAprobacion":"2020-08-04"' +
							'}' +
						'}';

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo error producto
	@isTest
	private static void errorProducto() {
		//TestDataFactory.createAccountIndividual(1);
		//TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		//update TestDataFactory.mapAccounts.values();

		TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);

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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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
								'"fechaAprobacion":"2020-08-04"' +
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

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}

	//Metodo para crear un producto
	@isTest
	private static void crearProducto() {
		//TestDataFactory.createAccountIndividual(1);
		//TestDataFactory.mapAccounts.get(0).IdCliente__c = 'JP_0101';
		//update TestDataFactory.mapAccounts.values();

		TestDataFactory.crearProductos(1);
		TestDataFactory.createPriceBookEntries(1);

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
								'"idCliente":"JP_0101",' +
								'"tipoEnvioDocumentacion":"Fisico",' +
								'"quieroQueLlamen":"SI"' +
							'},' +
							'"Oportunidad" : {' +
								'"cliente":"11-700-375",' +
								'"idCliente":"JP_0101",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
								'"periodo":"2020",' +
								'"numeroOrdenPedido":1010101,' +
								'"idOP":"JP_0101",' +
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
								'"fechaAprobacion":"2020-08-04"' +
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

		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();

		req.requestURI = '/services/apexrest/googleBootAPI/';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JsonMsg);

		RestContext.request = req;
		RestContext.response = res;

		Test.startTest();
		GoogleBotAPI.classResponse results = GoogleBotAPI.upsertInfo();
		Test.stopTest();
	}
}