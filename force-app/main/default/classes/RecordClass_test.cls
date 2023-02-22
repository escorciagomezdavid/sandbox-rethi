/**
* Se comenta createAccountJA 
* BRIAN CORONEL - 1/09/2022
* Se comenta porque no existe el metodo en la clase TestDataFactory
* **/

@isTest
public class RecordClass_test {
    
    @isTest
    public static void getAccountIdentify_test(){
        String identify = '1143154102';
        String empresa = 'JA';
        TestDataFactory.createAccountCustom(identify, empresa);
        Test.startTest();
        RecordClass.getAccountIdentify(identify, empresa);
        Test.stopTest();
        
    }
    
    @isTest
    public static void getAccountIdCliente_test(){
        String IdCliente = 'JA_1143154102';
        String identify  = '1143154102';
        TestDataFactory.createAccountCustom(identify, 'JA');
        Test.startTest();
        RecordClass.getAccountIdCliente(IdCliente);
        Test.stopTest();
    }
    
     @isTest
    public static void getLeadIdentify_test(){
        String identify = '1143154102';
        String empresa = 'JP';
        TestDataFactory.createLeadIdentify(identify);
        Test.startTest();
        RecordClass.getLeadIdentify(identify, empresa);
        Test.stopTest();
    }
    
    @isTest
    public static void getLeadEmail_test(){
        String email = 'jamartest@jamar.com';
        String empresa = 'JP';
        TestDataFactory.createLeadEmail(email);
        Test.startTest();
        RecordClass.getLeadEmail(email, empresa);
        Test.stopTest();
    }
    

    
    @isTest
    public static void getUserMessageService_test(){
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
								'"segundoNombre":"Prueba",' +
            					'"canalAtencion":"Distancia",' +
								'"apellidos":"Prueba Prueba",' +
            					'"idProspecto":"12",' +
            					'"codigoVendedor":"Prueba Prueba",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
         
         
         
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.getUserMessageService(middles);
        Test.stopTest();
        
    }
    
    @isTest
    public static void createdNewAccountPanama_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"departamento":"ATL",' +
            					'"canalAtencion":"Distancia",' +
            					'"codigoVendedor":"Prueba Prueba",' +
								'"segundoNombre":"Prueba",' +
            					'"idProspecto":"12",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.createdNewAccount(middles);
        Test.stopTest();
        
    }
   
    @isTest
    public static void createdNewAccountColombia_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"idProspecto":"12",' +
            					'"canalAtencion":"Distancia",' +
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
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JA_1143154102",' +
            					'"pais":"Colombia",' +
            					'"tipoGestion":"Ventas",' +
            					'"nombreVendedor":"Brayan",' +
            					'"cupoDisponible":10,' +
            					'"productoInteres":"cama",' +
            					'"cuantosContactosTenido":10,' +
            					'"aceptoContactoWhatsapp":true,' +
                                '"lineaLlamada":"Whatsapp",' +
            					'"cuotaDisponible":10,' +
                                '"viabilidad":"ROJO",' +
                                '"estrategia":"NARANJA",' +
            					'"segmento":"ORO",' +
            					'"ingresos":10,' +
                                '"ciudadResidencia":"C8SSSS",' +
                                '"paisResidencia":"Colombia",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.createdNewAccount(middles);
        Test.stopTest();
        
    }
    
    @isTest
    public static void createdNewLeadPanama_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"canalAtencion":"Distancia",' +
            					'"idProspecto":"12",' +
            					'"departamento":"ATL",' +
            					'"codigoVendedor":"Prueba Prueba",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.createdNewLead(middles);
        Test.stopTest();
    }
    
    // @isTest
    // public static void createdNewLeadColombia_test(){
        
    //     TestDataFactory.createAgencia();
    //     TestDataFactory.createDepartamento();
    //     String JsonMsg = '{' +
	// 						'"Record" : {' +
	// 							'"nombre":"Prueba",' +
    //         					'"tienda":"JA_01",' +
    //         					'"codigoVendedor":"Prueba Prueba",' +
    //         					'"agencia":"JA_01",' +
    //         					'"canalAtencion":"Distancia",' +
    //         					'"departamento":"ATL",' +
    //         					'"idProspecto":"12",' +
    //         					'"locale":"US",' +
	// 							'"segundoNombre":"Prueba",' +
	// 							'"apellidos":"Prueba Prueba",' +
	// 							'"origen":"WhatsApp",' +
    //         					'"whatsapp":"+573207238222",' +
	// 							'"tipoVenta":"Contado",' +
	// 							'"cuentaPersona":"Cuenta Persona",' +
	// 							'"identificacion":"1143154102",' +
	// 							'"correoElectronico":"jamartest@jamar.com",' +
	// 							'"celular":"574444444489",' +
	// 							'"empresa":"JA",' +
	// 							'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
	// 							'"salida":"CONOCIDO",' +
	// 							'"lectData":"EXD",' +
	// 							'"descripcion":"Prueba Creacion Prospecto",' +
	// 							'"idCliente":"JA_1143154102",' +
    //         					'"pais":"Colombia",' +
    //         					'"nombreVendedor":"Brayan",' +
    //         					'"cupoDisponible":10,' +
    //         					'"productoInteres":"cama",' +
    //         					'"cuantosContactosTenido":10,' +
    //                             '"lineaLlamada":"Whatsapp",' +
    //         					'"cuotaDisponible":10,' +
    //                             '"viabilidad":"ROJO",' +
    //                             '"estrategia":"NARANJA",' +
    //         					'"segmento":"ORO",' +
    //         					'"ingresos":10,' +
    //                             '"ciudadResidencia":"C8SSSS",' +
    //                             '"paisResidencia":"Panama",' +
    //                             '"latitudResidencia":"10",' +
    //                             '"longitudResidencia":"10",' +
    //         					'"calleResidencia":"10",' +
    //         					'"telefonoFijo":"102828282",' +
    //         					'"telefonoTrabajo":"102828282",' +
    //                             '"ciudadTrabajo":"PAN",' +
    //         					'"longitudTrabajo":"10",' +
    //                             '"latitudTrabajo":"10",' +
    //         					'"calleTrabajo":"10",' +
    //         					'"anioInicio":"10",' +
    //         					'"fechaNacimiento":"2020-08-15",' +
    //         					'"tipoEnvioDocumentacion":"FISICO",' +
    //         					'"sexo":"FEMENINO",' +
    //         					'"estadoCivil":"SOLTERO",' +
    //                            	'"ocupacion":"COMERCIANTE FORMAL",' +
    //                             '"quieroQueLlamen":"SI",' +
    //                             '"tieneCuentaActiva":"SI",' +
    //         					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
    //         					'"idInforme":"1234",' +
    //         					'"rango":"R1",' +
    //         					'"porcentajeLead": 10,' +
    //         					'"fechaConsulta": "2020-08-04",' +
    //         					'"gclid":"cooosoaiii2",' +
	// 							'"ofertaEspecial":' + true +
	// 						'}' +
	// 					'}';
        
    //     MiddlewareClass middles = new MiddlewareClass();
    //     middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
    //     Test.startTest();
    //     RecordClass.createdNewLead(middles);
    //     Test.stopTest();
    // }
    
    @isTest
    public static void updateLead_test(){
        
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadIdentify('1143154102');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
            					'"etapa":"Nuevo",' +
            					'"idProspecto":"12",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
           						'"canalAtencion":"Distancia",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.updateLead(middles);
        Test.stopTest();
        
    }
    
    @isTest
    public static void updateLeadUnqualified_test(){
        
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadIdentify('1143154102');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"canalAtencion":"Distancia",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idProspecto":"12",' +
            					'"fechaNacimiento":"2020-08-15",' +
            					'"tipoEnvioDocumentacion":"FISICO",' +
            					'"sexo":"FEMENINO",' +
            					'"estadoCivil":"SOLTERO",' +
                               	'"ocupacion":"COMERCIANTE FORMAL",' +
                                '"quieroQueLlamen":"SI",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.updateLead(middles);
        Test.stopTest();
        
    }
    
    @isTest
    public static void updateLeadWithEmail_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadEmail('jamartest@jamar.com');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"departamento":"ATL",' +
            					'"canalAtencion":"Distancia",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
            					'"etapa":"Nuevo",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idInforme":"1234",' +
            					'"idProspecto":"12",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.updateLeadWithEmail(middles);
        Test.stopTest();
        
    }
    
    @isTest
    public static void updateLeadWithEmailUnqualified_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadEmail('jamartest@jamar.com');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"agencia":"JP_001",' +
            					'"canalAtencion":"Distancia",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idInforme":"1234",' +
            					'"idProspecto":"12",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.updateLeadWithEmail(middles);
        Test.stopTest();
        
    }
    
   
    
    
    @isTest
    public static void updateAccountWithIdCliente_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccountCustom('1143154102', 'JA');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"canalAtencion":"Distancia",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
            					'"etapa":"Nuevo",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"3207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"44444444",' +
								'"empresa":"JA",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
            					'"idProspecto":"12",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        List<Account> act = [SELECT ID FROM Account where Identificacion__c =: '1143154102'];
        Test.startTest();
        RecordClass.updateAccountWithIdCliente(middles, act[0].id);
        Test.stopTest();
    }
    
    @isTest
    public static void getAgencias_test(){
        Test.startTest();
        RecordClass.getAgencias();
        Test.stopTest();
    }
    
    @isTest
    public static void getDepartmento_test(){
        Test.startTest();
        RecordClass.getDepartmento();
        Test.stopTest();
    }
    
    
     @isTest
    public static void updateLeadWithId_test(){
        
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createLeadIdentify('1143154102');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"canalAtencion":"Distancia",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
								'"segundoNombre":"Prueba",' +
								'"apellidos":"Prueba Prueba",' +
								'"origen":"WhatsApp",' +
            					'"whatsapp":"+5073207238222",' +
								'"tipoVenta":"Contado",' +
								'"cuentaPersona":"Cuenta Persona",' +
								'"identificacion":"1143154102",' +
								'"correoElectronico":"jamartest@jamar.com",' +
								'"celular":"50744444444",' +
								'"empresa":"JP",' +
								'"tipoIdentificacion":"CEDULA DE CIUDADANIA",' +
								'"salida":"CONOCIDO",' +
								'"lectData":"EXD",' +
								'"descripcion":"Prueba Creacion Prospecto",' +
								'"idCliente":"JP_1143154102",' +
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
            					'"idInforme":"1234",' +
            					'"idProspecto":"12",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        List<Lead> lead = [SELECT ID FROM LEAD WHERE Identificacin__c =: '1143154102'];
        Test.startTest();
        RecordClass.updateLeadWithId(middles, lead[0].Id);
        Test.stopTest();
        
    }
    
        @isTest
    public static void updateAccount_test(){
        TestDataFactory.createAgencia();
        TestDataFactory.createDepartamento();
        TestDataFactory.createAccount('1143154102');
        String JsonMsg = '{' +
							'"Record" : {' +
								'"nombre":"Prueba",' +
            					'"tienda":"JP_001",' +
            					'"agencia":"JP_001",' +
            					'"codigoVendedor":"Prueba Prueba",' +
            					'"departamento":"ATL",' +
            					'"tipoGestion":"Ventas",' +
            					'"tipoRelacion":"AGREGADO",' +
            					'"tipoReferencia":"-AGREGADO",' +
            					'"paisTrabajo":"Panama",' +
            					'"tipoCredito":"CR",' +
            					'"locale":"US",' +
            					'"etapa":"Nuevo",' +
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
            					'"idInforme":"1234",' +
            					'"rango":"R1",' +
            					'"porcentajeLead": 10,' +
            					'"fechaConsulta": "2020-08-04",' +
                                '"tieneCuentaActiva":"SI",' +
            					'"tipoPagoUltimaCompraContado":"consignación bancaria",' +
            					'"gclid":"cooosoaiii2",' +
								'"ofertaEspecial":' + true +
							'}' +
						'}';
        
        MiddlewareClass middles = new MiddlewareClass();
        middles = (MiddlewareClass)JSON.deserialize(JsonMsg, MiddlewareClass.class);
        Test.startTest();
        RecordClass.updateAccount(middles);
        Test.stopTest();
    }
}