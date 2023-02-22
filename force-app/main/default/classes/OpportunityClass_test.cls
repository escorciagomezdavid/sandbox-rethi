@isTest
public class OpportunityClass_test {
    
    @isTest
    public static void getOpportunityWithIdOp_test(){
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
            					'"etapaEntrega":"VIAJANDO",' +
            					'"recogerTienda":"SI",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
            					'"causalDesiste":"HOLA",' +
								'"seguro":40000,' +
								'"agenciaPedido":"JP_00",' +
            					'"agenciaVendedor":"JP_00",' +
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
            					'"accionSugerida":"G3",' +
								'"fechaAprobacion":"2020-08-04",' +
            					'"ultimaFechaIngreso":"2021-09-23T08:00:00Z"'+

							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.getOpportunityWithIdOp(middles);
        Test.stopTest();
    }
    
     @isTest
    public static void getOpportunity_test(){
        Test.startTest();
        OpportunityClass.getOpportunity('JA_001_001');
        Test.stopTest();
    }
    
    @isTest
    public static void getOpportunityId_test(){
        Test.startTest();
        OpportunityClass.getOpportunityId('JA_001_001');
        Test.stopTest();
    }
     @isTest
    public static void getOpportunityContactado_test(){
        Account act =  new Account();
        Test.startTest();
        OpportunityClass.getOpportunityContactado(act);
        Test.stopTest();
    }
    
     @isTest
    public static void getOpportunityOtherStage_test(){
        Account act =  new Account();
        Test.startTest();
        OpportunityClass.getOpportunityOtherStage(act);
        Test.stopTest();
    }
    @isTest
    public static void getOpportunityCotizacion_test(){
        Account act =  new Account();
        Test.startTest();
        OpportunityClass.getOpportunityCotizacion(act);
        Test.stopTest();
    }
    
    
    @isTest
    public static void updateOpportunity_test(){
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
            					'"agenciaVendedor":"JP_001",' +
								'"etapaEntrega":"VIAJANDO",' + 
            					'"recogerTienda":"SI",' +
								'"etapa":"Aprobación",' +
            					'"causalDesiste":"HOLA",' +
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
            					'"accionSugerida":"G3",' +
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
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunity(middles);
        Test.stopTest();

    }
    
    
     @isTest
    public static void updateOpportunityWithId_test(){
        TestDataFactory.crearOportunityAndProducts('JA', 'JA_001', 'NA');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
            					'"agenciaVendedor":"JP_001",' +
								'"etapaEntrega":"VIAJANDO",' + 
            					'"recogerTienda":"SI",' +
								'"etapa":"Aprobación",' +
            					'"causalDesiste":"HOLA",' +
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
            					'"accionSugerida":"G3",' +
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
        List<Opportunity> ops = [SELECT ID FROM Opportunity where IdOp__C =: 'JA_001'];
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunityWithId(ops[0].id, middles);
        Test.stopTest();

    }
    
    @isTest
    public static void updateOpportunityContactado_test(){
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
            					'"causalDesiste":"HOLA",' +
            					'"recogerTienda":"SI",' +
            					'"etapaEntrega":"VIAJANDO",' +
            					'"agenciaPedido":"JP_001",' +
            					'"agenciaVendedor":"JP_001",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
            					'"accionSugerida":"G3",' +
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
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunityContactado(middles);
        Test.stopTest();
        
    }
    
    
    @isTest
    public static void updateOpportunityContizacion_test(){
        TestDataFactory.crearOportunityAndQuote('JA', 'Cotización');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
            					'"causalDesiste":"HOLA",' +
            					'"etapaEntrega":"VIAJANDO",' +
								'"idCliente":"JP_444444444",' +
            					'"recogerTienda":"SI",' +
            					'"agenciaPedido":"JP_001",' +
            					'"agenciaVendedor":"JP_001",' +
								'"etapa":"Aprobación",' +
								'"ventaTotal":3000000,' +
								'"seguro":40000,' +
            					'"ultimaFechaPrecalificacion":"2020-08-15",' +
            					'"ejecutivoCredito":"Brayan Silvera",' +
								'"periodo":"2020",' +
            					'"accionSugerida":"G3",' +
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
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunityContizacion(middles);
        Test.stopTest();
    }
    
    
    @isTest
    public static void updateOpportunityWithOutIdOp_test(){
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
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
        
        
        List<Account> act = [SELECT Id, Tipo_de_Registro__c, Description, Ultima_Fecha_Ingreso__c FROM Account Where IdCliente__c =: 'JP_444444444'];
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunityWithOutIdOp(act[0], middles);
        Test.stopTest();
    }
    
    @isTest
    public static void updateOpportunityWithOutIdOpStage_test(){
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
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
        
        
        List<Account> act = [SELECT Id, Tipo_de_Registro__c, Description, Ultima_Fecha_Ingreso__c FROM Account Where IdCliente__c =: 'JP_444444444'];
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.updateOpportunityWithOutIdOpStage(act[0], middles, 'Cotización');
        Test.stopTest();
    }
    
    @isTest
    public static void createdOpportunityOtherStage_test(){
        TestDataFactory.crearOportunityContactado('JA', 'Contactado');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
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
        
        
        List<Account> act = [SELECT Id, Tipo_de_Registro__c, Description, Ultima_Fecha_Ingreso__c FROM Account Where IdCliente__c =: 'JP_444444444'];
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.createdOpportunityOtherStage(act[0], middles, true, 'Cotización');
        Test.stopTest();
    }
    
    @isTest
    public static void createdOpportunityWithIdOp_test(){
        TestDataFactory.createAccount('444444444');
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
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
            					'"causalDesiste":"HOLA",' +
            					'"etapaEntrega":"VIAJANDO",' +
            					'"agenciaPedido":"JP_001",' +
            					'"agenciaVendedor":"JP_001",' +
            					'"recogerTienda":"SI",' +
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
            					'"accionSugerida":"G3",' +
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
        
        List<Account> act = [SELECT Id, Tipo_de_Registro__c, Description, Ultima_Fecha_Ingreso__c FROM Account Where IdCliente__c =: 'JP_444444444'];
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        OpportunityClass.createdOpportunityWithIdOp(act[0], middles, true);
        Test.stopTest();
    }
    
     @isTest
    public static void getListaPrecios_test(){
        Test.startTest();
        OpportunityClass.getListaPrecios();
        Test.stopTest();
    }



}