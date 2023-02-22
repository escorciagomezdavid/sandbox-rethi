@isTest
public class CaseClass_test {

	@IsTest
	public static void ValidacionCliente_test()
	{
		String identificacion = '1043434561';
		TestDataFactory.createAccount(identificacion);
		Test.startTest();
		CaseClass.ValidacionCliente(identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void ValidacionClienteempty_test()
	{
		String identificacion = '1043434561';
		Test.startTest();
		CaseClass.ValidacionCliente(identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantia_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		System.debug(producto.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();
	}
	@IsTest
	public static void validacionGarantiaSinCaso_Test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();

	}

	@IsTest
	public static void validacionGarantiaSinOP_Test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.createAccount(identificacion);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.ID, 'SERVICIO DE GARANTIA', null, null, 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();

	}
	@IsTest
	public static void validacionGarantiaCasoCerrado_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		System.debug(producto.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantiaOpDiferente_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		System.debug(producto.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		CaseClass.validacionGarantia('2345678', '25993998', identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantiaMasDeUnCaso_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		System.debug(producto.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		CaseClass.validacionGarantia('2345678', '25993998', identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantiaMasDeUnCasoOp_y_producto_igual_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		System.debug(producto.ID);
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantiaMasDeUnCasoMasDeUnPrd_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		TestDataFactory.crearProductosOPEspecifica(3, getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void validacionGarantiaMasDeUnCasoMasDeUnPrdYOpDiferente_test() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		System.debug(getIdOpp.Id);
		TestDataFactory.crearProductosOPEspecifica(3, getIdOpp.Id);
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Cerrado');
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.validacionGarantia('1235689', '12345678', identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void createCase_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "234567",' +
		'"numeroOp" : "2599399",' +
		'"causalPrincipal" : "SERVICIO DE GARANTIA",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145",' +
		'"direccion": "CL  45SUR  41  80  BL  6  AP  423",' +
    	'"ciudad": "ENVIGADO",' +
    	'"departamento": "ANTIOQUIA",' +
    	'"pais": "Colombia"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCaseSinOpEncontrada_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "234567",' +
		'"numeroOp" : "25993995",' +
		'"causalPrincipal" : "SERVICIO DE GARANTIA",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCaseSinProductoEncontrado_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "2345678",' +
		'"numeroOp" : "2599399",' +
		'"causalPrincipal" : "SERVICIO DE GARANTIA",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCaseCausalAsignacionOp_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "234567",' +
		'"numeroOp" : "2599399",' +
		'"causalPrincipal" : "ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP",' +
		'"subTipoGestion" : "OP-Asignación de cita",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCasSinOrigen_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "234567",' +
		'"numeroOp" : "2599399",' +
		'"causalPrincipal" : "ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCasSinOp_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "",' +
		'"numeroOp" : "",' +
		'"causalPrincipal" : "ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void createCasSinCausal_Test() {
		String jsonmsg = '{' +
		'"Caso" : {' +
		'"identificacion" : "ID001",' +
		'"codigoProducto" : "234567",' +
		'"numeroOp" : "2599399",' +
		'"causalPrincipal" : "",' +
		'"subTipoGestion" : "Reservicio",' +
		'"origenCaso" : "portal cliente",' +
		'"descripcion" : "Hola como van",' +
		'"urlImagen" : "https://es.wikipedia.org/wiki/Salesforce.com#/media/Archivo:Salesforce.com_logo.svg;",' +
		'"tipoSolicitud" : "RECLAMO",' +
		'"email" : "dsanchez@jamar.com",' +
		'"telefono" : "573006780145"' +
		'}' +
		'}';
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		middlwareCase middles = new middlwareCase();
		middles = (middlwareCase) JSON.deserialize(jsonmsg, middlwareCase.class);
		Test.startTest();
		CaseClass.CrearCaso(middles);
		Test.stopTest();
	}

	@IsTest
	public static void GetCasessinOp() {
		String identificacion = 'ID001';
		String codigoProducto = '2345679';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		System.debug(getCuenta.ID);
		TestDataFactory.crearCaseGarantiaSinOp(getCuenta.Id, 'SERVICIO DE GARANTIA', 'Abierto');
		CaseClass.validacionGarantia(codigoProducto, numeroOp, identificacion);
		Test.stopTest();
	}

	@IsTest
	public static void trackingcasetest() {
		String identificacion = 'ID001';
		String codigoProducto = '234567';
		String numeroOp = '2599399';
		Test.startTest();
		TestDataFactory.crearOportunityAndProducts('JA', 'JA_2599399', null);
		Account getCuenta = [Select ID from Account where Identificacion__c = :identificacion];
		Opportunity getIdOpp = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
		OpportunityLineItem producto = [Select ID from OpportunityLineItem where ProductCode = :codigoProducto AND OpportunityId = :getIdOpp.ID];
		TestDataFactory.crearCaseGarantia(getCuenta.Id, 'SERVICIO DE GARANTIA', getIdOpp.Id, producto.ID, 'Abierto');
		CaseClass.DatosTrackingCaso(identificacion);
		Test.stopTest();
	}

}