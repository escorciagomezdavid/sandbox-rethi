/*
Creado por David Leon
Fecha creacion: 03/07/2020
Descripcion: Web service rest para la creacion/actualizacion general de lead, cuentas, oportunidades y producto de oportunidad
*/

@RestResource(UrlMapping='/googleBootAPI/')
global class GoogleBotAPI  {
    
    @HttpPost
    global static classResponse upsertInfo(){
        Boolean esLead = false;
        Boolean leadConvertido = false;
        Boolean updateOp = false;
        Boolean newOp = false;
        Boolean createOpOld = false;
        Boolean createOpOld2 = false;
        Integer count = 0;
        String idTRLead = '';
        String idTRLeadCol = '';
        String idTRAct = '';
        String idTRActCol = '';
        String idTROpp = '';
        String origenes = '';
        //String ownerId = '';
        String origenTemp = '';
        
        
        Log__c log = new Log__c();
        Opportunity opUpdate = new Opportunity();
        Opportunity opUpdateIdOP;
        Opportunity opCreate = new Opportunity();
        Opportunity opCreateFlag = new Opportunity();
        
        Account newAct = new Account();
        List<Account> act = new List<Account>();
        List<Opportunity> listOp = new List<Opportunity>();
        List<Opportunity> listIdOp = new List<Opportunity>();
        Map<String, Agencia__c> mapAgencias = new Map<String, Agencia__c>();
        Map<String, Departamento__c> mapDepartamentos = new Map<String, Departamento__c>();
        List<String> setOrigenes = new List<String>();
        List<Pricebook2> listaPrecios = new List<Pricebook2>();
        
        RestRequest req = RestContext.request;
        info infoRequest = new info();
        infoRequest.Oportunidad = new Oportunidad();
        infoRequest.Productos = new List<Productos>();
        infoRequest.Record = new classGeneral();
        System.debug(' ** INICIALIZACION ** ' + infoRequest);
        classResponse response = new classResponse();
        
        if(req == null){
            response.estado = 'Error';
            response.descripcionError = 'Infomración entrante nula.';
            response.codigoError = '';
            return response;
        }
        
        String jsonInput = req.requestBody.toString();
        System.debug(' ** JSON ENTRANTE ** ' + jsonInput);
        infoRequest = (info)JSON.deserialize(jsonInput, info.class);
        
        //Se obtienen los tipos de registro para Lead, Account...
        idTRLead = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
        idTRAct =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
        idTRLeadCol = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Colombia').getRecordTypeId();
        idTRActCol =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        //Se obtienen todas las agencias disponibles...
        for(Agencia__c c : [SELECT IdAgencia__c, Id FROM Agencia__c]){
            mapAgencias.put(c.IdAgencia__c, c);
        }
        
        //Se obtienen todos los departamentos disponibles...
        for(Departamento__c dep : [SELECT Name, Id FROM Departamento__c]){
            mapDepartamentos.put(dep.Name, dep);
        }
        
        
        //Se obtiene la lista de precios
        listaPrecios = [SELECT Id FROM Pricebook2];
        
        //Se obtienen los origenes de una etiqueta personalizada
        origenes = System.Label.Origen;
        setOrigenes = origenes.split(';');
        
        //Se hacen validaciones sobre el origen del registro entrante....
        System.debug(' ** PETICION ** ' + infoRequest);
        if(infoRequest.Record.origen != null){
            if(!setOrigenes.contains(infoRequest.Record.origen)){
                System.debug(' ** ORIGEN LEAD/CUENTA ** ');
                log.ClassName__c = 'GoogleBotAPIV1';
                log.date__c = Datetime.now();
                log.message__c = 'Error al intentar procesar la solicitud. Origen incorrecto. ';
                log.success__c = false;
                log.type__c = 'Procesamiento de peticion al ws';
                log.JSON__c = jsonInput;
                if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                    log.Empresa__c = 'Panamá';
                }else{
                    log.Empresa__c = 'Colombia';
                }
                insert log;
                
                response.estado = 'Error';
                response.descripcionError = 'Error: Origen Incorrecto. Contacte al administrador.';
                response.codigoError = '';
                return response;
            }
        }
        
        if(infoRequest.Record.identificacion != null && infoRequest.Record.identificacion != ''){
            LeadStatus convertStatus = new LeadStatus(); 
            Database.LeadConvert lc = new Database.LeadConvert();
            Database.DMLOptions dmlLead = new Database.DMLOptions();
            Database.LeadConvertResult lcr;
            
            
            //Se busca si el registro existe como prospecto para realizar al conversion a la cuenta existente
            List<Account> lstAct = new List<Account>();
            List<Lead> lstProspectos = new List<Lead>();
            
            lstAct = [SELECT Id FROM Account WHERE Identificacion__c =: infoRequest.Record.identificacion AND Empresa__c =: infoRequest.Record.empresa];
            lstProspectos = [SELECT Id, ownerId, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource FROM Lead WHERE Identificacin__c =: infoRequest.Record.identificacion AND IsConverted =: false ORDER BY Ultima_Fecha_Ingreso__c  DESC LIMIT 1]; //Hacer la modificacion aca de que escoja 1 solo
            if(lstProspectos.size() == 1){ // Si solo existe un prospecto
                if(infoRequest.Oportunidad !=null && infoRequest.Oportunidad.emisionOrdenPedido != null){ // Si viene una orden de pedido con emisionOP
                    if(lstProspectos[0].Ultima_Fecha_Ingreso__c != null){ // Si el prospecto tiene fecha de ultimo ingreso
                        DateTime ultimaFechaIngreso = lstProspectos[0].Ultima_Fecha_Ingreso__c; // Converitmos Ultimo ingreso en dateTime
                        Date convertUltimaFechaIngreso = Date.newInstance(ultimaFechaIngreso.year(), ultimaFechaIngreso.month(), ultimaFechaIngreso.day()); // COnvertimos Ultimo ingreso a Date
                        if(infoRequest.Oportunidad.emisionOrdenPedido < convertUltimaFechaIngreso) { // Si la fecha de emision de la orden de pedido es menor que la fecha de de ultimo ingreso envio Log
                            System.debug(infoRequest.Oportunidad.emisionOrdenPedido);
                            System.debug(convertUltimaFechaIngreso);
                            createOpOld = true;
                            System.debug('Ingreso a la condicion del Lead');
                        }
                    }
                }
            }
            
            System.debug(' ** LISTA CUENTA PROCESO CONVERSION LEAD ** ' + lstAct.size());
            System.debug(' ** LISTA PROSPECTOS ** ' + lstProspectos.size());
            
            try{
                if(!lstAct.isEmpty() && lstAct.size() > 1){
                    System.debug(' ** EXISTE MAS DE UNA CUENTA ** ');
                    log.ClassName__c = 'GoogleBotAPIV1';
                    log.date__c = Datetime.now();
                    log.message__c = 'Error al intentar convertir el prospecto, existe mas de una cuenta con identificación: ' + infoRequest.Record.identificacion;
                    log.success__c = false;
                    log.type__c = 'Procesamiento de peticion al ws';
                    log.JSON__c = jsonInput;
                    if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                        log.Empresa__c = 'Panamá';
                    }else{
                        log.Empresa__c = 'Colombia';
                    }
                    insert log;
                    
                    response.estado = 'Error';
                    response.descripcionError = 'Error al intentar convertir el prospecto, existe mas de una cuenta con identificación: ' + infoRequest.Record.identificacion;
                    response.codigoError = '';
                    return response;
                }else if(!lstProspectos.isEmpty() && lstProspectos.size() > 1){
                    System.debug(' ** EXISTE MAS DE UN PROSPECTO ** ');
                    log.ClassName__c = 'GoogleBotAPIV1';
                    log.date__c = Datetime.now();
                    log.message__c = 'Error al intentar convertir el prospecto, existe mas de un prospecto con identificación: ' + infoRequest.Record.identificacion;
                    log.success__c = false;
                    log.type__c = 'Procesamiento de peticion al ws';
                    log.JSON__c = jsonInput;
                    if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                        log.Empresa__c = 'Panamá';
                    }else{
                        log.Empresa__c = 'Colombia';
                    }
                    insert log;
                    
                    response.estado = 'Error';
                    response.descripcionError = 'Error al intentar convertir el prospecto, existe mas de un prospecto con identificación: ' + infoRequest.Record.identificacion;
                    response.codigoError = '';
                    return response;
                }else if(!lstAct.isEmpty() && lstAct.size() == 1 && !lstProspectos.isEmpty() && lstProspectos.size() == 1){
                    System.debug(' ** CONVERSION DE LEAD A CUENTA EXISTENTE ** ');
                    lstProspectos[0].cancelarWorkFlow__c = true;
                    lstProspectos[0].Convertido__c = true;
                    lstProspectos[0].Api_Name__c = 'APIV1';
                    update lstProspectos;
                    
                    lc.setLeadId(lstProspectos[0].Id);
                    lc.setConvertedStatus('Qualified');
                    lc.setDoNotCreateOpportunity(true);
                    lc.setAccountId(lstAct[0].Id);
                    dmlLead.DuplicateRuleHeader.AllowSave = true;
                    
                    TriggerHandler.bypass('TriggerHandlerAccount');
                    lcr = Database.convertLead(lc, dmlLead);
                    TriggerHandler.clearBypass('TriggerHandlerAccount');
                }else if(lstAct.isEmpty() && infoRequest.Oportunidad != null && !lstProspectos.isEmpty() && lstProspectos.size() == 1){
                    if(infoRequest.Oportunidad != null){
                        System.debug(' ** CONVERSION DE LEAD A CUENTA NUEVA ** ');
                        lstProspectos[0].cancelarWorkFlow__c = true;
                        lstProspectos[0].Convertido__c = true;
                        lstProspectos[0].Api_Name__c = 'APIV1';
                        
                        update lstProspectos;
                        
                        lc.setLeadId(lstProspectos[0].Id);
                        lc.setConvertedStatus('Qualified');
                        lc.setDoNotCreateOpportunity(true);
                        //lc.setAccountId(lstAct[0].Id);
                        dmlLead.DuplicateRuleHeader.AllowSave = true;
                        
                        TriggerHandler.bypass('TriggerHandlerAccount');
                        lcr = Database.convertLead(lc, dmlLead);
                        TriggerHandler.clearBypass('TriggerHandlerAccount');
                    }
                }
                
                System.debug(' ** RESUTALDO LEAD CONVERTIDO ** ' + lcr);
                if(lcr != null){
                    if(lcr.isSuccess()){
                        leadConvertido = true;
                        origenTemp = lstProspectos[0].LeadSource;
                        /**
                        if(lstProspectos.size() == 1){
                            ownerId = lstProspectos[0].ownerId;
                        }
                        **/
                    }else{
                        String cadenaError = lcr.getErrors()[0].getMessage();
                        Boolean existeCadena  = cadenaError.contains('Este prospecto ya se ha convertido al contacto');     
                        if(existeCadena){
                            leadConvertido = true;
                        }else{
                            log.ClassName__c = 'GoogleBotAPIV1';
                            log.date__c = Datetime.now();
                            log.message__c = 'Error al intentar convertir el prospecto. Error 1: ' + lcr.getErrors();
                            log.success__c = false;
                            log.type__c = 'Procesamiento de peticion al ws';
                            log.JSON__c = jsonInput;
                            if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                                log.Empresa__c = 'Panamá';
                            }else{
                                log.Empresa__c = 'Colombia';
                            }
                            
                            insert log;
                            
                            response.estado = 'Error';
                            response.descripcionError = 'Error al intentar convertir el prospecto. Error 1: ' + lcr.getErrors();
                            response.codigoError = '';
                            return response;
                        }
                    }
                }
            }
            catch(Exception ex){
                System.debug(' ** ERROR AL CONVERTIR LEAD ** ' + ex.getMessage());
                log.ClassName__c = 'GoogleBotAPIV1';
                log.date__c = Datetime.now();
                log.message__c = 'Error al intentar convertir el prospecto. Error 3: ' + ex.getMessage();
                log.success__c = false;
                log.type__c = 'Procesamiento de peticion al ws';
                log.JSON__c = jsonInput;
                if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                    log.Empresa__c = 'Panamá';
                }else{
                    log.Empresa__c = 'Colombia';
                }
                insert log;
                
                response.estado = 'Error';
                response.descripcionError = 'Error al intentar convertir el prospecto. Error 4: ' + ex.getMessage();
                response.codigoError = '';
                return response;
            }
        }
        
        //Se procesa el registro entrante....
        System.debug(' ** ID CLIENTE ENTRANTE ** ' + infoRequest.Record.idCliente);
        if(infoRequest.Record.idCliente != '' && infoRequest.Record.idCliente != null){
            act = [SELECT Id, FirstName, MiddleName, LastName, Whatsapp__c, CupoDisponible__c, ProductoDeInteres__c, CuantosContactosHaTenido__c, LineaDeLlamada__c, CuotaDisponible__c, TieneOfertaEspecial__c, Viabilidad__c, Estrategia__c, 
                   Ingresos__c, Salida__c, LectData__c, PersonLeadSource, AccountSource, BillingCity, BillingCountry, BillingLatitude, BillingLongitude, BillingStreet, Description, Phone, PersonOtherPhone, ShippingCity, ShippingCountry, ShippingLatitude, 
                   ShippingLongitude, ShippingStreet, AnioInicio__c, PersonBirthdate, PersonEmail, PersonHomePhone, PersonMobilePhone, Identificacion__c, Empresa__c, TipodeEnvioDocumentacion__c, TipodeIdentificacion__c, Sexo__c, 
                   Estado_civil__c, Ocupacion__c, QuieroQueMeLlamen__c, TieneCuentaActiva__c, Tienda__c, Departamento__c, TipoDePagoUltimaCompraDeContado__c, SegmentoPanama__c, Acepto_Contacto_por_Whatsapp__c, IdCliente__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Primer_Origen__c
                   FROM Account 
                   WHERE IdCliente__c =: infoRequest.Record.idCliente];
            
            System.debug(' ** CUENTA EXISTENTE ** ' + act);
            System.debug(' ** INFO REQUEST OPORTUNIDAD ** ' + infoRequest);
            System.debug(' ** INFO REQUEST OPORTUNIDAD ** ' + infoRequest.Oportunidad);
            if(act.isEmpty() && act.size() == 0 && infoRequest.Oportunidad == null){
                esLead = true;
            }else if(act.size() > 1){
                log.ClassName__c = 'GoogleBotAPIV1';
                log.date__c = Datetime.now();
                log.message__c = 'Error al intentar crear/actualizar una cuenta. Existe duplicidad de cuentas con el idCliente ' + infoRequest.Record.idCliente;
                log.success__c = false;
                log.type__c = 'Procesamiento de peticion al ws';
                log.JSON__c = jsonInput;
                if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                    log.Empresa__c = 'Panamá';
                }else{
                    log.Empresa__c = 'Colombia';
                }
                insert log;
                
                response.estado = 'Error';
                response.descripcionError = 'Error al intentar crear/actualizar una cuenta. Existe duplicidad de cuentas con el idCliente ' + infoRequest.Record.idCliente;
                response.codigoError = '';
                return response;
            }else{
                //Se consulta si existe un usuario de mensajeria
                String condition = '%' + infoRequest.Record.whatsapp + '%';
                Boolean updateUser = false;
                List<MessagingEndUser> listU = new List<MessagingEndUser>();
                listU = [SELECT Id, AccountId, Account.Name, MessagingPlatformKey FROM MessagingEndUser WHERE MessagingPlatformKey LIKE : condition];
                
                try{
                    if(act.isEmpty() && act.size() == 0 && infoRequest.Oportunidad.idOP != null && !leadConvertido){
                        System.debug(' ** CREAR UNA CUENTA NUEVA ** ');
                        if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                            newAct.RecordTypeId = idTRAct;
                        }else{
                            newAct.RecordTypeId = idTRActCol;
                        }
                        /**
                        if(ownerId != '' && ownerId != null){
                            newAct.OwnerId = ownerId;
                        }
						**/
                        newAct.Api_Name__c = 'APIV1';
                        if(infoRequest.Record.nombre != null){
                            newAct.FirstName = infoRequest.Record.nombre;
                        }
                        if(infoRequest.Record.tienda != null){
                            newAct.Tienda__c = mapAgencias.get(infoRequest.Record.tienda).Id;
                        }
                        if(infoRequest.Record.nombreVendedor != null){
                            newAct.Vendedor__c = infoRequest.Record.nombreVendedor;
                        }
                        
                        if(infoRequest.Record.segundoNombre != null){
                            newAct.MiddleName = infoRequest.Record.segundoNombre;
                        }
                        if(infoRequest.Record.apellidos != null){
                            newAct.LastName = infoRequest.Record.apellidos;
                        }
                        if(infoRequest.Record.whatsapp != null){
                            newAct.Whatsapp__c = infoRequest.Record.whatsapp;
                        }
                        if(infoRequest.Record.cupoDisponible != null){
                            newAct.CupoDisponible__c = infoRequest.Record.cupoDisponible;
                        }
                        if(infoRequest.Record.productoInteres != null){
                            newAct.ProductoDeInteres__c = infoRequest.Record.productoInteres;
                        }
                        if(infoRequest.Record.cuantosContactosTenido != null){
                            newAct.CuantosContactosHaTenido__c = infoRequest.Record.cuantosContactosTenido;
                        }
                        if(infoRequest.Record.lineaLlamada != null){
                            newAct.LineaDeLlamada__c = infoRequest.Record.lineaLlamada;
                        }
                        if(infoRequest.Record.cuotaDisponible != null){
                            newAct.CuotaDisponible__c = infoRequest.Record.cuotaDisponible;
                        }
                        if(infoRequest.Record.ofertaEspecial != null){
                            newAct.TieneOfertaEspecial__c = infoRequest.Record.ofertaEspecial;
                        }
                        if(infoRequest.Record.viabilidad != null){
                            newAct.Viabilidad__c = infoRequest.Record.viabilidad;
                        }
                        if(infoRequest.Record.estrategia != null){
                            newAct.Estrategia__c = infoRequest.Record.estrategia;
                        }
                        if(infoRequest.Record.ingresos != null){
                            newAct.Ingresos__c = infoRequest.Record.ingresos;
                        }
                        if(infoRequest.Record.salida != null){
                            newAct.Salida__c = infoRequest.Record.salida;
                        }
                        if(infoRequest.Record.lectData != null){
                            newAct.LectData__c = infoRequest.Record.lectData;
                        }
                        if(infoRequest.Record.origen != null){
                            newAct.PersonLeadSource = infoRequest.Record.origen;
                            newAct.Primer_Origen__c = infoRequest.Record.origen;
                        }
                        if(infoRequest.Record.ciudadResidencia != null){
                            newAct.BillingCity = infoRequest.Record.ciudadResidencia;
                        }
                        if(infoRequest.Record.paisResidencia != null){
                            newAct.BillingCountry = infoRequest.Record.paisResidencia;
                        }
                        if(infoRequest.Record.latitudResidencia != null){
                            newAct.BillingLatitude = Double.valueOf(infoRequest.Record.latitudResidencia);
                        }
                        if(infoRequest.Record.longitudResidencia != null){
                            newAct.BillingLongitude = Double.valueOf(infoRequest.Record.longitudResidencia);
                        }
                        if(infoRequest.Record.calleResidencia != null){
                            newAct.BillingStreet = infoRequest.Record.calleResidencia;
                        }
                        if(infoRequest.Record.descripcion != null){
                            newAct.Description = infoRequest.Record.descripcion;
                        }
                        if(infoRequest.Record.telefonoFijo != null){
                            newAct.Phone = infoRequest.Record.telefonoFijo;
                        }
                        if(infoRequest.Record.telefonoTrabajo != null){
                            newAct.PersonOtherPhone = infoRequest.Record.telefonoTrabajo;
                        }
                        if(infoRequest.Record.ciudadTrabajo != null){
                            newAct.ShippingCity = infoRequest.Record.ciudadTrabajo;
                        }
                        if(infoRequest.Record.latitudTrabajo != null){
                            newAct.ShippingLatitude = Double.valueOf(infoRequest.Record.latitudTrabajo);
                        }
                        if(infoRequest.Record.longitudTrabajo != null){
                            newAct.ShippingLongitude = Double.valueOf(infoRequest.Record.longitudTrabajo);
                        }
                        if(infoRequest.Record.calleTrabajo != null){
                            newAct.ShippingStreet = infoRequest.Record.calleTrabajo;
                        }
                        if(infoRequest.Record.anioInicio != null){
                            newAct.AnioInicio__c = infoRequest.Record.anioInicio;
                        }
                        if(infoRequest.Record.fechaNacimiento != null){
                            newAct.PersonBirthdate = infoRequest.Record.fechaNacimiento;
                        }
                        if(infoRequest.Record.correoElectronico != null){
                            newAct.PersonEmail = infoRequest.Record.correoElectronico;
                        }
                        if(infoRequest.Record.telefonoDomicilio != null){
                            newAct.PersonHomePhone = infoRequest.Record.telefonoDomicilio;
                        }
                        if(infoRequest.Record.identificacion != null){
                            newAct.Identificacion__c = infoRequest.Record.identificacion;
                        }
                        if(infoRequest.Record.empresa != null){
                            newAct.Empresa__c = infoRequest.Record.empresa;
                        }
                        if(infoRequest.Record.tipoEnvioDocumentacion != null){
                            newAct.TipodeEnvioDocumentacion__c = infoRequest.Record.tipoEnvioDocumentacion;
                        }
                        if(infoRequest.Record.tipoIdentificacion != null){
                            newAct.TipodeIdentificacion__c = infoRequest.Record.tipoIdentificacion;
                        }
                        if(infoRequest.Record.sexo != null){
                            newAct.Sexo__c = infoRequest.Record.sexo;
                        }
                        if(infoRequest.Record.estadoCivil != null){
                            newAct.Estado_civil__c = infoRequest.Record.estadoCivil;
                        }
                        if(infoRequest.Record.ocupacion != null){
                            newAct.Ocupacion__c = infoRequest.Record.ocupacion;
                        }
                        if(infoRequest.Record.quieroQueLlamen != null){
                            newAct.QuieroQueMeLlamen__c = infoRequest.Record.quieroQueLlamen;
                        }
                        if(infoRequest.Record.tieneCuentaActiva != null){
                            newAct.TieneCuentaActiva__c = infoRequest.Record.tieneCuentaActiva;
                        }
                        if(infoRequest.Record.idCliente != null){
                            newAct.IdCliente__c = infoRequest.Record.idCliente;
                        }
                        if(infoRequest.Record.celular != null){
                            newAct.PersonMobilePhone = infoRequest.Record.celular;
                        }
                        if(infoRequest.Record.departamento != null){
                            newAct.Departamento__c = mapDepartamentos.get(infoRequest.Record.departamento).Id;
                        }
                        if(infoRequest.Record.tipoPagoUltimaCompraContado != null){
                            newAct.TipoDePagoUltimaCompraDeContado__c = infoRequest.Record.tipoPagoUltimaCompraContado;
                        }
                        if(infoRequest.Record.segmento != null){
                            newAct.SegmentoPanama__c = infoRequest.Record.segmento;
                        }
                        if(infoRequest.Record.aceptoContactoWhatsapp != null && listU.size() == 0){
                            newAct.Acepto_Contacto_por_Whatsapp__c = infoRequest.Record.aceptoContactoWhatsapp;
                        }else{
                            newAct.Acepto_Contacto_por_Whatsapp__c = false;
                        }
                        if(infoRequest.Record.gclid != null){
                            newAct.GCLID__c = infoRequest.Record.gclid;
                        }
                        /**
* mod brayan
* **/
                        newAct.Ultima_Fecha_Ingreso__c = DateTime.now();
                        if(infoRequest.Record.tipoGestion != null){
                            newAct.Tipo_de_Registro__c = infoRequest.Record.tipoGestion;
                        }
                        TriggerHandler.bypass('TriggerHandlerAccount');  
                        try{
                            insert newAct;
                        }catch(Exception e){
                            System.debug('Entro en el Catch error' + e.getCause() + e.getLineNumber() + e.getTypeName());
                            act = [SELECT Id, FirstName, MiddleName, LastName, Whatsapp__c, CupoDisponible__c, ProductoDeInteres__c, CuantosContactosHaTenido__c, LineaDeLlamada__c, CuotaDisponible__c, TieneOfertaEspecial__c, Viabilidad__c, Estrategia__c, 
                                   Ingresos__c, Salida__c, LectData__c, PersonLeadSource, AccountSource, BillingCity, BillingCountry, BillingLatitude, BillingLongitude, BillingStreet, Description, Phone, PersonOtherPhone, ShippingCity, ShippingCountry, ShippingLatitude, 
                                   ShippingLongitude, ShippingStreet, AnioInicio__c, PersonBirthdate, PersonEmail, PersonHomePhone, PersonMobilePhone, Identificacion__c, Empresa__c, TipodeEnvioDocumentacion__c, TipodeIdentificacion__c, Sexo__c, 
                                   Estado_civil__c, Ocupacion__c, QuieroQueMeLlamen__c, Tienda__c, TieneCuentaActiva__c, Departamento__c, TipoDePagoUltimaCompraDeContado__c, SegmentoPanama__c, Acepto_Contacto_por_Whatsapp__c, IdCliente__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                   FROM Account 
                                   WHERE IdCliente__c =: infoRequest.Record.idCliente];
                        }
                        TriggerHandler.clearBypass('TriggerHandlerAccount');
                    }else{
                        System.debug(' ** ACTUALIZAR UNA CUENTA EXISTENTE ** ');
                        if(infoRequest.Record.nombre != null && infoRequest.Record.nombre != ''){
                            act[0].FirstName = infoRequest.Record.nombre;
                        }
                        act[0].Api_Name__c ='APIV1';
                        if(infoRequest.Record.nombreVendedor != null){
                            act[0].Vendedor__c = infoRequest.Record.nombreVendedor;
                        }
                    
                        if(infoRequest.Record.tienda != null){
                            act[0].Tienda__c = mapAgencias.get(infoRequest.Record.tienda).Id;
                        }
                        if(infoRequest.Record.segundoNombre != null && infoRequest.Record.segundoNombre != '' && infoRequest.Record.segundoNombre != '-'){
                            act[0].MiddleName = infoRequest.Record.segundoNombre;
                        }
                        if(infoRequest.Record.apellidos != null && infoRequest.Record.apellidos != ''  && infoRequest.Record.apellidos != '-'){
                            act[0].LastName = infoRequest.Record.apellidos;
                        }
                        if(infoRequest.Record.whatsapp != null){
                            act[0].Whatsapp__c = infoRequest.Record.whatsapp;
                        }
                        if(infoRequest.Record.cupoDisponible != null){
                            act[0].CupoDisponible__c = infoRequest.Record.cupoDisponible;
                        }
                        if(infoRequest.Record.productoInteres != null){
                            act[0].ProductoDeInteres__c = infoRequest.Record.productoInteres;
                        }
                        if(infoRequest.Record.cuantosContactosTenido != null){
                            act[0].CuantosContactosHaTenido__c = infoRequest.Record.cuantosContactosTenido;
                        }
                        if(infoRequest.Record.lineaLlamada != null){
                            act[0].LineaDeLlamada__c = infoRequest.Record.lineaLlamada;
                        }
                        if(infoRequest.Record.cuotaDisponible != null){
                            act[0].CuotaDisponible__c = infoRequest.Record.cuotaDisponible;
                        }
                        if(infoRequest.Record.ofertaEspecial != null){
                            act[0].TieneOfertaEspecial__c = infoRequest.Record.ofertaEspecial;
                        }
                        if(infoRequest.Record.viabilidad != null){
                            act[0].Viabilidad__c = infoRequest.Record.viabilidad;
                        }
                        if(infoRequest.Record.estrategia != null){
                            act[0].Estrategia__c = infoRequest.Record.estrategia;
                        }
                        if(infoRequest.Record.ingresos != null){
                            act[0].Ingresos__c = infoRequest.Record.ingresos;
                        }
                        if(infoRequest.Record.salida != null){
                            act[0].Salida__c = infoRequest.Record.salida;
                        }
                        if(infoRequest.Record.lectData != null){
                            act[0].LectData__c = infoRequest.Record.lectData;
                        }
                        if(infoRequest.Record.origen != null){
                            act[0].PersonLeadSource = infoRequest.Record.origen;
                        }
                        if(infoRequest.Record.ciudadResidencia != null){
                            act[0].BillingCity = infoRequest.Record.ciudadResidencia;
                        }
                        if(infoRequest.Record.paisResidencia != null){
                            act[0].BillingCountry = infoRequest.Record.paisResidencia;
                        }
                        if(infoRequest.Record.latitudResidencia != null){
                            act[0].BillingLatitude = Double.valueOf(infoRequest.Record.latitudResidencia);
                        }
                        if(infoRequest.Record.longitudResidencia != null){
                            act[0].BillingLongitude = Double.valueOf(infoRequest.Record.longitudResidencia);
                        }
                        if(infoRequest.Record.calleResidencia != null){
                            act[0].BillingStreet = infoRequest.Record.calleResidencia;
                        }
                        if(infoRequest.Record.descripcion != null){
                            act[0].Description = infoRequest.Record.descripcion;
                        }
                        if(infoRequest.Record.telefonoFijo != null && infoRequest.Record.telefonoFijo != ''){
                            act[0].Phone = infoRequest.Record.telefonoFijo;
                        }
                        if(infoRequest.Record.telefonoTrabajo != null && infoRequest.Record.telefonoTrabajo != ''){
                            act[0].PersonOtherPhone = infoRequest.Record.telefonoTrabajo;
                        }
                        if(infoRequest.Record.ciudadTrabajo != null){
                            act[0].ShippingCity = infoRequest.Record.ciudadTrabajo;
                        }
                        if(infoRequest.Record.paisTrabajo != null){
                            act[0].ShippingCountry = infoRequest.Record.paisTrabajo;
                        }
                        if(infoRequest.Record.latitudTrabajo != null){
                            act[0].ShippingLatitude = Double.valueOf(infoRequest.Record.latitudTrabajo);
                        }
                        if(infoRequest.Record.longitudTrabajo != null){
                            act[0].ShippingLongitude = Double.valueOf(infoRequest.Record.longitudTrabajo);
                        }
                        if(infoRequest.Record.calleTrabajo != null){
                            act[0].ShippingStreet = infoRequest.Record.calleTrabajo;
                        }
                        if(infoRequest.Record.anioInicio != null){
                            act[0].AnioInicio__c = infoRequest.Record.anioInicio;
                        }
                        if(infoRequest.Record.fechaNacimiento != null){
                            act[0].PersonBirthdate = infoRequest.Record.fechaNacimiento;
                        }
                        if(infoRequest.Record.correoElectronico != null && infoRequest.Record.correoElectronico != ''){
                            act[0].PersonEmail = infoRequest.Record.correoElectronico;
                        }
                        if(infoRequest.Record.telefonoDomicilio != null){
                            act[0].PersonHomePhone = infoRequest.Record.telefonoDomicilio;
                        }
                        if(infoRequest.Record.celular != null && infoRequest.Record.celular != ''){
                            act[0].PersonMobilePhone = infoRequest.Record.celular;
                        }
                        if(infoRequest.Record.identificacion != null){
                            act[0].Identificacion__c = infoRequest.Record.identificacion;
                        }
                        if(infoRequest.Record.empresa != null && infoRequest.Record.empresa != ''){
                            act[0].Empresa__c = infoRequest.Record.empresa;
                        }
                        if(infoRequest.Record.tipoEnvioDocumentacion != null){
                            act[0].TipodeEnvioDocumentacion__c = infoRequest.Record.tipoEnvioDocumentacion;
                        }
                        if(infoRequest.Record.tipoIdentificacion != null){
                            act[0].TipodeIdentificacion__c = infoRequest.Record.tipoIdentificacion;
                        }
                        if(infoRequest.Record.sexo != null){
                            act[0].Sexo__c = infoRequest.Record.sexo;
                        }
                        if(infoRequest.Record.estadoCivil != null){
                            act[0].Estado_civil__c = infoRequest.Record.estadoCivil;
                        }
                        if(infoRequest.Record.ocupacion != null){
                            act[0].Ocupacion__c = infoRequest.Record.ocupacion;
                        }
                        if(infoRequest.Record.quieroQueLlamen != null){
                            act[0].QuieroQueMeLlamen__c = infoRequest.Record.quieroQueLlamen;
                        }
                        if(infoRequest.Record.tieneCuentaActiva != null){
                            act[0].TieneCuentaActiva__c = infoRequest.Record.tieneCuentaActiva;
                        }
                        if(infoRequest.Record.departamento != null){
                            act[0].Departamento__c = mapDepartamentos.get(infoRequest.Record.departamento).Id;
                        }
                        if(infoRequest.Record.tipoPagoUltimaCompraContado != null){
                            act[0].TipoDePagoUltimaCompraDeContado__c = infoRequest.Record.tipoPagoUltimaCompraContado;
                        }
                        if(infoRequest.Record.segmento != null){
                            act[0].SegmentoPanama__c = infoRequest.Record.segmento;
                        }
                        if(infoRequest.Record.aceptoContactoWhatsapp != null && listU.size() == 0){
                            act[0].Acepto_Contacto_por_Whatsapp__c = infoRequest.Record.aceptoContactoWhatsapp;
                        }else{
                            act[0].Acepto_Contacto_por_Whatsapp__c = false;
                        }
                        if(infoRequest.Record.gclid != null){
                            act[0].GCLID__c = infoRequest.Record.gclid;
                        }
                        /**
* mod brayan
* **/
                        act[0].Ultima_Fecha_Ingreso__c = DateTime.now();
                        if(infoRequest.Record.tipoGestion != null){
                            act[0].Tipo_de_Registro__c = infoRequest.Record.tipoGestion;
                        }
                        TriggerHandler.bypass('TriggerHandlerAccount');
                        update act;
                        TriggerHandler.clearBypass('TriggerHandlerAccount');
                    }
                }catch(Exception ex){
                    log.ClassName__c = 'GoogleBotAPIV1';
                    log.date__c = Datetime.now();
                    log.message__c = 'Error al intentar procesar el cliente. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                    log.success__c = false;
                    log.type__c = 'Procesamiento de peticion al ws';
                    log.JSON__c = jsonInput;
                    if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                        log.Empresa__c = 'Panamá';
                    }else{
                        log.Empresa__c = 'Colombia';
                    }
                    insert log;
                    System.debug(' ** ERROR CUENTA ** ' + ex.getMessage());
                    response.estado = 'Error';
                    response.descripcionError = 'Error al intentar procesar el cliente. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                    response.codigoError = '';
                    return response;
                }
                
                //Se procesan las oportunidades
                try{
                    System.debug(' ** ACCOUNT ID ** ' + newAct.Id);
                    System.debug(' ** LIST ACCOUNT ** ' + act);
                    if(infoRequest.Oportunidad != null && infoRequest.Oportunidad.idOP != null){ // Si llega Oportunidad con IDop
                        listIdOp = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                                    Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                                    FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                                    FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                    FROM Opportunity WHERE IdOP__c =: infoRequest.Oportunidad.idOP];
                    }
                    if(act.isEmpty() && act.size() == 0 && listIdOp.size() == 0){
                        listOp = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                                  Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                                  FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                                  FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                  FROM Opportunity WHERE AccountId =: newAct.Id];
                        
                    }else if(listIdOp.size() == 0){ // Cliente tiene cuenta y la OP no existe en SF
                        listOp = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                                  Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                                  FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                                  FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                  FROM Opportunity WHERE AccountId =: act[0].Id];
                    }
                    System.debug(' ** LISTA ID OP ** ' + listIdOp.size());
                    System.debug(' ** LISTA OP ** ' + listOp.size());
                    
                    //Se valida si la oportunidad encontrada es cerrada ganada o cerrada perdida
                    if(listIdOp.size() == 1){ // Si el Cliente tiene solo una OP con id op y concuerda con la entrante se actualiza
                        System.debug('listIdOp.size() == 1');
                        opUpdate = listIdOp[0];
                        updateOp = true;  // Variable que marca la actualizacion de la ID OP que esta en salesforce
                    }else{
                        System.debug(' ** CANTIDAD OPORTUNIDADES ** ' + listOp.size());
                        for(Opportunity op : listOp){
                            System.debug(' ** Id OP Salesforce ** ' + op.IdOP__c);
                            // Actualizar una Oportunidad sin ID OP
                            if((op.IdOP__c == '' || op.IdOP__c == null) && op.StageName != 'Cerrado Perdido' && !createOpOld && op.StageName != 'Cerrado Ganado'){
                                count = count + 1;
                                opUpdateIdOP = op;  
                                System.debug('Sin idOP');
                                if(infoRequest.Oportunidad !=null && infoRequest.Oportunidad.emisionOrdenPedido != null){ // Si viene una orden de pedido con emisionOP
                                    System.debug('Viene con ID op y emision OP');
                                    if(op.Ultima_Fecha_Ingreso__c != null){ // Si el prospecto tiene fecha de ultimo ingreso
                                        System.debug('Ultimo Ingreso en la op en salesforce');
                                        DateTime ultimaFechaIngreso = op.Ultima_Fecha_Ingreso__c; // Converitmos Ultimo ingreso en dateTime
                                        Date convertUltimaFechaIngreso = Date.newInstance(ultimaFechaIngreso.year(), ultimaFechaIngreso.month(), ultimaFechaIngreso.day()); // COnvertimos Ultimo ingreso a Date
                                        if(infoRequest.Oportunidad.emisionOrdenPedido < convertUltimaFechaIngreso) { // Si la fecha de emision de la orden de pedido es menor que la fecha de de ultimo ingreso envio Log
                                            System.debug(infoRequest.Oportunidad.emisionOrdenPedido);
                                            System.debug(convertUltimaFechaIngreso);
                                            createOpOld2 = true;
                                            System.debug('Ingreso a la condicion del Oportunidad de la OP vieja');
                                        }
                                    }
                                }
                            }
                            
                            // Actualizar Oportunidad que ya existe en SF con id OP
                            if(infoRequest.Oportunidad != null){
                                System.debug(' ** ID OP ENTRANTE ** ' + infoRequest.Oportunidad.idOP);
                                System.debug(' ** ID OP EXISTENTE ** ' + op.IdOP__c);
                                if(op.IdOP__c == infoRequest.Oportunidad.idOP){ // Si el id op entrante es igual al idop de alguna de las oportunidades del cliente se actualiza la op
                                    System.debug('op.IdOP__c == infoRequest.Oportunidad.idOP');
                                    updateOp = true; // Variable que marca la actualizacion de la ID OP que esta en salesforce
                                    opUpdate = op;
                                }
                            }
                        }                   
                    }
                    
                    System.debug(' ** COUNT ** ' + count);
                    System.debug(' ** UPDATE OP  ** ' + updateOp);
                    System.debug(' ** UPDATE ID OP ** ' + opUpdateIdOP);
                    if(count == 1 && infoRequest.Oportunidad == null){
                        // Hacer actualizacion aca
                        if(act.isEmpty() && act.size() == 0){
                            opUpdateIdOP.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                              if(infoRequest.Record.origen != null){
                                    opUpdateIdOP.LeadSource = infoRequest.Record.origen;
                                }
                            opUpdateIdOP.Description = newAct.Description;
                            opUpdateIdOP.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                        }else{
                              if(infoRequest.Record.origen != null){
                                    opUpdateIdOP.LeadSource = infoRequest.Record.origen;
                                }
                            opUpdateIdOP.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                            opUpdateIdOP.Description = act[0].Description;
                            opUpdateIdOP.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                        }
      
                        
                        update opUpdateIdOP;
                    }
                    else if(
                        (count == 0 && !updateOp && (infoRequest.Oportunidad != null || infoRequest.Oportunidad == null))
                        || infoRequest.Record.origen == 'App Vendedor' || createOpOld2){
                            
                            // Agregue flag    createOpOld2 para las ops antiguas que ingresan 
                            if(count == 1 && opUpdateIdOP != null && !createOpOld2){ // Cuando Ingrese por Origen app vendedor cumple esta condicion
                                System.debug(' ** SE ACTUALIZA LA OPORTUNIDAD QUE NO TIENE ID OP count == 1 && opUpdateIdOP != null ** '); // Añade los campos que tenemos en la creacion de caontactado
                                if(infoRequest.Oportunidad.idOP != null){
                                    opUpdateIdOP.IdOP__c = infoRequest.Oportunidad.idOP;
                                }
                                if(infoRequest.Oportunidad.causalDesiste != null){
                                    opUpdateIdOP.Causal_Desiste__c = infoRequest.Oportunidad.causalDesiste;
                                }
                                if(infoRequest.Oportunidad.etapaEntrega != null){
                                    opUpdateIdOP.Etapa_Entrega__c = infoRequest.Oportunidad.etapaEntrega;
                                }
                                if(infoRequest.Oportunidad.etapa != null){
                                    opUpdateIdOP.StageName = infoRequest.Oportunidad.etapa;
                                }
                                if(infoRequest.Oportunidad.accionSugerida != null){
                                    opUpdateIdOP.Accion_Sugerida__c = infoRequest.Oportunidad.accionSugerida;
                                }
                                opUpdateIdOP.Api_Name__c = 'APIV1';
                                if(infoRequest.Oportunidad.ventaTotal != null){
                                    opUpdateIdOP.VentaTotal__c = infoRequest.Oportunidad.ventaTotal;
                                }
                                if(infoRequest.Oportunidad.seguro != null){
                                    opUpdateIdOP.Seguro__c = infoRequest.Oportunidad.seguro;
                                }
                                if(infoRequest.Oportunidad.fechaCierre != null){
                                    opUpdateIdOP.CloseDate = infoRequest.Oportunidad.fechaCierre;
                                }
                                if(infoRequest.Oportunidad.agenciaPedido != null){
                                    opUpdateIdOP.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                                }
                                if(infoRequest.Oportunidad.periodo != null){
                                    opUpdateIdOP.Periodo__c = infoRequest.Oportunidad.periodo;
                                }
                                if(infoRequest.Oportunidad.codigoVendedor != null){
                                    opUpdateIdOP.CodigoVendedor__c = infoRequest.Oportunidad.codigoVendedor;
                                }
                                if(infoRequest.Oportunidad.nombreVendedor != null){
                                    opUpdateIdOP.NombreDeVendedor__c = infoRequest.Oportunidad.nombreVendedor;
                                }
                                if(infoRequest.Oportunidad.emisionOrdenPedido != null){
                                    opUpdateIdOP.EmisionOrdenPedido__c = infoRequest.Oportunidad.emisionOrdenPedido;
                                }
                                if(infoRequest.Oportunidad.cuotas != null){
                                    opUpdateIdOP.Cuotas__c = infoRequest.Oportunidad.cuotas;
                                }
                                if(infoRequest.Oportunidad.direccionDespacho != null){
                                    opUpdateIdOP.DireccionDeDespacho__c = infoRequest.Oportunidad.direccionDespacho;
                                }
                                if(infoRequest.Oportunidad.estadoOrdenPedido != null){
                                    opUpdateIdOP.EstadoOrdenPedido__c = infoRequest.Oportunidad.estadoOrdenPedido;
                                }
                                if(infoRequest.Oportunidad.idEstudio != null){
                                    opUpdateIdOP.IdEstudio__c = infoRequest.Oportunidad.idEstudio;
                                }
                                if(infoRequest.Oportunidad.etapaCredito != null){
                                    opUpdateIdOP.EtapaDelCredito__c = infoRequest.Oportunidad.etapaCredito;
                                }
                                if(infoRequest.Oportunidad.existeInventario != null){
                                    opUpdateIdOP.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario;
                                }
                                if(infoRequest.Oportunidad.cotizacionPedidoEnviada != null){
                                    opUpdateIdOP.CotizacionPedidoEnviada__c = infoRequest.Oportunidad.cotizacionPedidoEnviada;
                                }
                                if(infoRequest.Oportunidad.completacionCredito != null){
                                    opUpdateIdOP.CompletacionDeCredito__c = infoRequest.Oportunidad.completacionCredito;
                                    opUpdate.ConcatPendCred__c = infoRequest.Oportunidad.completacionCredito;
                                }
                                if(infoRequest.Oportunidad.ordenPedidoAprobada != null){
                                    opUpdateIdOP.OrdenPedidoAprobada__c = infoRequest.Oportunidad.ordenPedidoAprobada;
                                }
                                if(infoRequest.Oportunidad.fechaEntrega != null){
                                    opUpdateIdOP.FechaEntrega__c = infoRequest.Oportunidad.fechaEntrega;
                                }
                                if(infoRequest.Oportunidad.pin != null){
                                    opUpdateIdOP.PIN__c = infoRequest.Oportunidad.pin;
                                }
                                if(infoRequest.Oportunidad.propuestaPago != null){
                                    opUpdateIdOP.PropuestaDePago__c = infoRequest.Oportunidad.propuestaPago;
                                }
                                if(infoRequest.Oportunidad.pedidoFactura != null){
                                    opUpdateIdOP.PedidoFaturado__c = infoRequest.Oportunidad.pedidoFactura;
                                }
                                if(infoRequest.Oportunidad.cerrada != null){
                                    opUpdateIdOP.Cerrada__c = infoRequest.Oportunidad.cerrada;
                                }
                                if(infoRequest.Oportunidad.motivoPerdida != null){
                                    opUpdateIdOP.MotivoDePerdida__c = infoRequest.Oportunidad.motivoPerdida;
                                }
                                if(infoRequest.Oportunidad.origen != null){
                                    opUpdateIdOP.LeadSource = infoRequest.Oportunidad.origen;
                                }   
                                if(infoRequest.Oportunidad.tipoPago != null){
                                    opUpdateIdOP.TipoDePago__c = infoRequest.Oportunidad.tipoPago;
                                }
                                if(infoRequest.Oportunidad.fechaFacturacion != null){
                                    opUpdateIdOP.FechaFacturacion__c = infoRequest.Oportunidad.fechaFacturacion;
                                }
                                if(infoRequest.Oportunidad.idCliente != null){
                                    opUpdateIdOP.IdCliente__c = infoRequest.Oportunidad.idCliente;
                                }
                                if(infoRequest.Oportunidad.fechaCompletacionCredito != null){
                                    opUpdateIdOP.FechaCompletacionCredito__c = infoRequest.Oportunidad.fechaCompletacionCredito;
                                }
                                if(infoRequest.Oportunidad.fechaAprobacion != null){
                                    opUpdateIdOP.FechaAprobacion__c = infoRequest.Oportunidad.fechaAprobacion;
                                }
                                if(infoRequest.Oportunidad.fechaCreacionOP != null){
                                    opUpdateIdOP.FechaEnvioCotizacion__c = infoRequest.Oportunidad.fechaCreacionOP;
                                }
                                if(infoRequest.Oportunidad.tipoVenta != null){
                                    opUpdateIdOP.Type = infoRequest.Oportunidad.tipoVenta;
                                }
                                if(infoRequest.Oportunidad.numeroOrdenPedido != null){
                                    opUpdateIdOP.Numero_OP__c = String.valueOf(infoRequest.Oportunidad.numeroOrdenPedido);
                                }
                                if(infoRequest.Oportunidad.tipoOportunidad != null){
                                    if(infoRequest.Oportunidad.tipoOportunidad == 'Contado'){
                                        opUpdateIdOP.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                                    }else{
                                        opUpdateIdOP.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                                    }
                                }
                                
                                System.debug(' ** INFO OP ** ' + opUpdateIdOP);
                                /**
* Mod Braya 5-08-2021
* */
                                if(infoRequest.Oportunidad.ejecutivoCredito != null){
                                    opUpdateIdOP.Ejecutivo_de_Credito__c = infoRequest.Oportunidad.ejecutivoCredito;
                                }
                                if(infoRequest.Oportunidad.ultimaFechaPrecalificacion != null){
                                    opUpdateIdOP.Ultima_Fecha_de_Pre_Calificacion__c = infoRequest.Oportunidad.ultimaFechaPrecalificacion;
                                }
                                /**
* Mod Brayan
* */
                                /**
* Mod Brayan 
* */
                                if(act.isEmpty() && act.size() == 0){
                                    opUpdateIdOP.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                                    opUpdateIdOP.Description = newAct.Description;
                                    opUpdateIdOP.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                                }else{
                                    opUpdateIdOP.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                                    opUpdateIdOP.Description = act[0].Description;
                                    opUpdateIdOP.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                                }
                                
                                if(infoRequest.Oportunidad.listoFacturarFecha != null){
                                    opUpdateIdOP.Listo_Facturar_Fecha__c = infoRequest.Oportunidad.listoFacturarFecha;
                                }
                                if(infoRequest.Oportunidad.listoFacturar != null){
                                    opUpdateIdOP.Listo_a_Factruar__c = infoRequest.Oportunidad.listoFacturar;
                                }
                                if(infoRequest.Oportunidad.fechaDespacho != null){
                                    opUpdateIdOP.Fecha_Despacho__c = infoRequest.Oportunidad.fechaDespacho;
                                }
                                if(infoRequest.Oportunidad.citaEntrega != null){
                                    opUpdateIdOP.Cita_Entrega__c = infoRequest.Oportunidad.citaEntrega;
                                }
                                if(infoRequest.Oportunidad.opDeTercero != null){
                                    opUpdateIdOP.OP_de_terceros__c = infoRequest.Oportunidad.opDeTercero;
                                }
                                
                                if(infoRequest.Oportunidad.canalAtencion != null){
                                    opUpdateIdOP.Canal_de_Atencion__c = infoRequest.Oportunidad.canalAtencion;
                                }
                                if(infoRequest.Oportunidad.origenVenta != null){
                                    opUpdateIdOP.Origen_Venta__c = infoRequest.Oportunidad.origenVenta;
                                }
      
                                update opUpdateIdOP;
                            }
                            else if(!updateOp){ // Crea la op del lead que se convirtio a cliente y del cliente que aplica a una creacion de Oportunidad
                                System.debug(' ** SE CREA UNA OPORTUNIDAD NUEVA ** ');
                                if(infoRequest.Oportunidad != null){
                                    System.debug(' ** LISTA ORIGENES ** ' + setOrigenes);
                                    System.debug(' ** ORIGEN OPORTUNIDAD ** ' + infoRequest.Oportunidad.origen);
                                    if(!setOrigenes.contains(infoRequest.Oportunidad.origen)){
                                        log.ClassName__c = 'GoogleBotAPIV1';
                                        log.date__c = Datetime.now();
                                        log.message__c = 'Error al intentar procesar la solicitud. Origen incorrecto. ';
                                        log.success__c = false;
                                        log.type__c = 'Procesamiento de peticion al ws';
                                        log.JSON__c = jsonInput;
                                        if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                                            log.Empresa__c = 'Panamá';
                                        }else{
                                            log.Empresa__c = 'Colombia';
                                        }
                                        insert log;
                                        
                                        response.estado = 'Error';
                                        response.descripcionError = 'Error: Origen Incorrecto. Contacte al administrador.';
                                        response.codigoError = '';
                                        return response;
                                    }
                                    if(infoRequest.Oportunidad.tipoOportunidad == 'Contado'){
                                        System.debug(' ** TIPO CONTADO ** ');
                                        idTROpp = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                                    }else{
                                        System.debug(' ** TIPO CREDITO ** ');
                                        idTROpp = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                                    }
                                    System.debug(' ** TIPO DE REGISTRO ** ' + idTROpp);
                                    if(act.isEmpty() && act.size() == 0){
                                        System.debug(' ** CUENTA NUEVA ** ' + newAct);
                                        opCreate.AccountId = newAct.Id;
                                    }else{                  
                                        System.debug(' ** CUENTA EXISTENTE ** ' + act[0]);
                                        opCreate.AccountId = act[0].Id;
                                    }
                                    opCreate.RecordTypeId = idTROpp;
                                    opCreate.Api_Name__c = 'APIV1';
                                    opCreate.Causal_Desiste__c = infoRequest.Oportunidad.causalDesiste;
                                    opCreate.Etapa_Entrega__c = infoRequest.Oportunidad.etapaEntrega;
                                    opCreate.Name = infoRequest.Record.nombre + ' ' + infoRequest.Record.apellidos;
                                    opCreate.StageName = infoRequest.Oportunidad.etapa;
                                    opCreate.VentaTotal__c = infoRequest.Oportunidad.ventaTotal;
                                    opCreate.Seguro__c = infoRequest.Oportunidad.seguro;
                                   
                                    opCreate.Accion_Sugerida__c = infoRequest.Oportunidad.accionSugerida;
                               
                                    opCreate.CloseDate = infoRequest.Oportunidad.fechaCierre;
                                    if(infoRequest.Oportunidad.agenciaPedido != null){
                                        opCreate.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                                    }
                                    opCreate.Periodo__c = infoRequest.Oportunidad.periodo;
                                    opCreate.CodigoVendedor__c = infoRequest.Oportunidad.codigoVendedor;
                                    opCreate.NombreDeVendedor__c = infoRequest.Oportunidad.nombreVendedor;
                                    opCreate.EmisionOrdenPedido__c = infoRequest.Oportunidad.emisionOrdenPedido;
                                    opCreate.Cuotas__c = infoRequest.Oportunidad.cuotas;
                                    opCreate.DireccionDeDespacho__c = infoRequest.Oportunidad.direccionDespacho;
                                    opCreate.EstadoOrdenPedido__c = infoRequest.Oportunidad.estadoOrdenPedido;
                                    opCreate.IdEstudio__c = infoRequest.Oportunidad.idEstudio;
                                    opCreate.EtapaDelCredito__c = infoRequest.Oportunidad.etapaCredito;
                                    //opCreate.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario;
                                    opCreate.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario != null ? infoRequest.Oportunidad.existeInventario : false;
                                    opCreate.CotizacionPedidoEnviada__c = infoRequest.Oportunidad.cotizacionPedidoEnviada;
                                    opCreate.CompletacionDeCredito__c = infoRequest.Oportunidad.completacionCredito;
                                    opCreate.ConcatPendCred__c = infoRequest.Oportunidad.completacionCredito;
                                    opCreate.OrdenPedidoAprobada__c = infoRequest.Oportunidad.ordenPedidoAprobada;
                                    opCreate.FechaEntrega__c = infoRequest.Oportunidad.fechaEntrega;
                                    opCreate.PIN__c = infoRequest.Oportunidad.pin;
                                    opCreate.PropuestaDePago__c = infoRequest.Oportunidad.propuestaPago;
                                    opCreate.PedidoFaturado__c = infoRequest.Oportunidad.pedidoFactura;
                                    opCreate.Cerrada__c = infoRequest.Oportunidad.cerrada;
                                    opCreate.MotivoDePerdida__c = infoRequest.Oportunidad.motivoPerdida;
                                    opCreate.IdOP__c = infoRequest.Oportunidad.idOP;
                                    //opCreate.Pricebook2Id = '01sf2000001lc6fAAA';
                                    opCreate.Pricebook2Id = listaPrecios[0].Id;
                                    opCreate.LeadSource = infoRequest.Oportunidad.origen;
                                    opCreate.TipoDePago__c = infoRequest.Oportunidad.tipoPago;
                                    opCreate.FechaFacturacion__c = infoRequest.Oportunidad.fechaFacturacion;
                                    opCreate.IdCliente__c = infoRequest.Oportunidad.idCliente;
                                    opCreate.FechaCompletacionCredito__c = infoRequest.Oportunidad.fechaCompletacionCredito;
                                    opCreate.FechaAprobacion__c = infoRequest.Oportunidad.fechaAprobacion;
                                    opCreate.FechaEnvioCotizacion__c = infoRequest.Oportunidad.fechaCreacionOP;
                                    opCreate.Type = infoRequest.Oportunidad.tipoVenta;
                                    opCreate.Numero_OP__c = String.valueOf(infoRequest.Oportunidad.numeroOrdenPedido);
                                    if(act.isEmpty() && act.size() == 0){
                                        if(createOpOld2 || createOpOld){
                                            opCreate.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                        }else{
                                            opCreate.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                        }
                                    }else{
                                         if(createOpOld2 || createOpOld){
                                            opCreate.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                         }else{
                                              if(leadConvertido){
                                                  opCreate.Primer_Origen__c = origenTemp ;
                                              }else {
                                                  opCreate.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                              }
                                         }
                                    }
                                    //opCreate.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                    if(leadConvertido && !createOpOld && !createOpOld2){
                                        opCreate.Convertido__c = true;
                                    }
                                    
                                    newOp = true; // Marca si la OP es creada Nueva
                                    /**
* mod brayan 
* **/
                                    opCreate.Ultima_Fecha_Ingreso__c = DateTime.now();
                                    opCreate.Tipo_de_Registro__c = infoRequest.Oportunidad.tipoGestion;
                                    
                                    /**
* Mod Braya 5-08-2021
* */
                                    opCreate.Ejecutivo_de_Credito__c = infoRequest.Oportunidad.ejecutivoCredito;
                                    opCreate.Ultima_Fecha_de_Pre_Calificacion__c = infoRequest.Oportunidad.ultimaFechaPrecalificacion;
                                    
                                    
                                    System.debug(' ** ETAPA OP ** ' + opCreate.StageName);
                                    System.debug(' ** MOTIVO PERDIDA ** ' + opCreate.MotivoDePerdida__c);
                                     if(infoRequest.Oportunidad.listoFacturarFecha != null){
                                        opCreate.Listo_Facturar_Fecha__c = infoRequest.Oportunidad.listoFacturarFecha;
                                        }
                                    if(infoRequest.Oportunidad.listoFacturar != null){
                                        opCreate.Listo_a_Factruar__c = infoRequest.Oportunidad.listoFacturar;
                                    }
                                    if(infoRequest.Oportunidad.fechaDespacho != null){
                                        opCreate.Fecha_Despacho__c = infoRequest.Oportunidad.fechaDespacho;
                                    }
                                    if(infoRequest.Oportunidad.citaEntrega != null){
                                        opCreate.Cita_Entrega__c = infoRequest.Oportunidad.citaEntrega;
                                    }
                                    if(infoRequest.Oportunidad.opDeTercero != null){
                                        opCreate.OP_de_terceros__c = infoRequest.Oportunidad.opDeTercero;
                                    }
                                    if(infoRequest.Oportunidad.canalAtencion != null){
                                    opCreate.Canal_de_Atencion__c = infoRequest.Oportunidad.canalAtencion;
                                        }
                                        if(infoRequest.Oportunidad.origenVenta != null){
                                            opCreate.Origen_Venta__c = infoRequest.Oportunidad.origenVenta;
                                        }
      
                                    insert opCreate;
                                }
                                else{
                                    if(act.isEmpty() && act.size() == 0){
                                        opCreateFlag.AccountId = newAct.Id;
                                        opCreateFlag.Api_Name__c = 'APIV1';
                                        if(infoRequest.Record.tipoGestion == null){
                                            opCreateFlag.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                                        }
                                         if(createOpOld2 || createOpOld){
                                            opCreateFlag.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                             if(leadConvertido){
                                                     opCreateFlag.LeadSource =  origenTemp; //Primer_Origen__c
                                             }else {
                                                     opCreateFlag.LeadSource =  infoRequest.Oportunidad.origen; //Primer_Origen__c
                                             }
                                        }else{
                                            opCreateFlag.Primer_Origen__c = infoRequest.Record.origen;
                                            opCreateFlag.LeadSource = infoRequest.Record.origen;
                                        }
                                        
                                        opCreateFlag.Description = newAct.Description;
                                        opCreateFlag.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                                        
                                    }else{                  
                                        opCreateFlag.AccountId = act[0].Id;
                                        opCreateFlag.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                                        if(createOpOld2 || createOpOld){
                                            opCreateFlag.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                             if(leadConvertido){
                                                     opCreateFlag.LeadSource =  origenTemp; //Primer_Origen__c
                                             }else {
                                                     opCreateFlag.LeadSource =  infoRequest.Oportunidad.origen; //Primer_Origen__c
                                             }
                                        }else{
                                            opCreateFlag.Primer_Origen__c = infoRequest.Record.origen;
                                            opCreateFlag.LeadSource = infoRequest.Record.origen;
                                        }
                                        opCreateFlag.Description = act[0].Description;
                                        opCreateFlag.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                                    }
                                    if(infoRequest.Record.tienda != null){
                                            opCreateFlag.Oportunidad_Visor__c = True;
                                     }
                                    opCreateFlag.Name = infoRequest.Record.nombre + ' ' + infoRequest.Record.apellidos;
                                    opCreateFlag.StageName = 'Contactado';
                                    opCreateFlag.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                                    opCreateFlag.CloseDate = Date.today().addMonths(1);
                                    opCreateFlag.IdCliente__c = infoRequest.Record.empresa + '_' + infoRequest.Record.identificacion;
                                    if(leadConvertido){
                                        opCreateFlag.Convertido__c = true;
                                    }
                                    /**
                                    if(ownerId != '' && ownerId != null){
                                        opCreateFlag.OwnerId = ownerId;
                                    }
									**/
                                                
                                    System.debug(' ** INFO OP ** ' + opCreate);
                                    insert opCreateFlag;
                                }
                                if(createOpOld){
                                    if(act.isEmpty() && act.size() == 0){
                                        opCreateFlag.AccountId = newAct.Id;
                                        opCreateFlag.Api_Name__c = 'APIV1';
                                        if(infoRequest.Record.tipoGestion == null){
                                            opCreateFlag.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                                        }
                                        if(createOpOld){
                                            opCreateFlag.Primer_Origen__c = newAct.Primer_Origen__c;
                                            if(leadConvertido){
                                                     opCreateFlag.LeadSource =  origenTemp; //Primer_Origen__c
                                             }else {
                                                     opCreateFlag.LeadSource =  infoRequest.Oportunidad.origen; //Primer_Origen__c
                                             }
                                        }else{
                                            opCreateFlag.Primer_Origen__c =  infoRequest.Oportunidad.origen;
                                            opCreateFlag.LeadSource =  infoRequest.Oportunidad.origen;

                                        }

                                        opCreateFlag.Description = newAct.Description;
                                        opCreateFlag.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                                        
                                        
                                    }else{                  
                                        opCreateFlag.AccountId = act[0].Id;
                                        opCreateFlag.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                                         if(createOpOld){
                                            opCreateFlag.Primer_Origen__c = act[0].Primer_Origen__c;
                                           if(leadConvertido){
                                                     opCreateFlag.LeadSource =  origenTemp; //Primer_Origen__c
                                             }else {
                                                     opCreateFlag.LeadSource =  infoRequest.Oportunidad.origen; //Primer_Origen__c
                                             } // Primer_origen_C

                                        }else{
                                            opCreateFlag.Primer_Origen__c = infoRequest.Oportunidad.origen;
                                            opCreateFlag.LeadSource = infoRequest.Oportunidad.origen;
                                        }

                                        opCreateFlag.Description = act[0].Description;
                                        opCreateFlag.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                                        
                                    }
                                    opCreateFlag.Name = infoRequest.Record.nombre + ' ' + infoRequest.Record.apellidos;
                                    opCreateFlag.StageName = 'Contactado';
                                    opCreateFlag.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                                    opCreateFlag.CloseDate = Date.today().addMonths(1);
                                    opCreateFlag.IdCliente__c = infoRequest.Record.empresa + '_' + infoRequest.Record.identificacion;
                                    if(infoRequest.Record.tienda != null){
                                            opCreateFlag.Oportunidad_Visor__c = True;
                                    }
									if(leadConvertido){
                                        opCreateFlag.Convertido__c = true;
                                    }
                                    /**
                                    if(ownerId != '' && ownerId != null){
                                        opCreateFlag.OwnerId = ownerId;
                                    }
									**/
                                    System.debug(' ** INFO OP ** ' + opCreateFlag);
                                    
                                    System.debug(opCreateFlag);
                                    insert opCreateFlag;
                                }
                            }
                            
                            else{
                                System.debug(' ** SE ACTUALIZA UNA OPORTUNIDAD QUE YA TIENE ID OP ENTRO POR EL ELSE ** ');
                                if(infoRequest.Oportunidad.etapa != null){
                                    opUpdate.StageName = infoRequest.Oportunidad.etapa;
                                }
                                opUpdate.Api_Name__c = 'APIV1';
                                if(infoRequest.Oportunidad.ventaTotal != null){
                                    opUpdate.VentaTotal__c = infoRequest.Oportunidad.ventaTotal;
                                }
                                if(infoRequest.Oportunidad.causalDesiste != null){
                                    opUpdate.Causal_Desiste__c = infoRequest.Oportunidad.causalDesiste;
                                }
                                if(infoRequest.Oportunidad.etapaEntrega != null){
                                    opUpdate.Etapa_Entrega__c = infoRequest.Oportunidad.etapaEntrega;
                                }
                                if(infoRequest.Oportunidad.accionSugerida != null){
                                    opUpdate.Accion_Sugerida__c = infoRequest.Oportunidad.accionSugerida;
                                }
                                if(infoRequest.Oportunidad.seguro != null){
                                    opUpdate.Seguro__c = infoRequest.Oportunidad.seguro;
                                }
                                if(infoRequest.Oportunidad.fechaCierre != null){
                                    opUpdate.CloseDate = infoRequest.Oportunidad.fechaCierre;
                                }
                                if(infoRequest.Oportunidad.agenciaPedido != null){
                                    opUpdate.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                                }
                                if(infoRequest.Oportunidad.periodo != null){
                                    opUpdate.Periodo__c = infoRequest.Oportunidad.periodo;
                                }
                                if(infoRequest.Oportunidad.codigoVendedor != null){
                                    opUpdate.CodigoVendedor__c = infoRequest.Oportunidad.codigoVendedor;
                                }
                                if(infoRequest.Oportunidad.nombreVendedor != null){
                                    opUpdate.NombreDeVendedor__c = infoRequest.Oportunidad.nombreVendedor;
                                }
                                if(infoRequest.Oportunidad.emisionOrdenPedido != null){
                                    opUpdate.EmisionOrdenPedido__c = infoRequest.Oportunidad.emisionOrdenPedido;
                                }
                                if(infoRequest.Oportunidad.cuotas != null){
                                    opUpdate.Cuotas__c = infoRequest.Oportunidad.cuotas;
                                }
                                if(infoRequest.Oportunidad.direccionDespacho != null){
                                    opUpdate.DireccionDeDespacho__c = infoRequest.Oportunidad.direccionDespacho;
                                }
                                if(infoRequest.Oportunidad.estadoOrdenPedido != null){
                                    opUpdate.EstadoOrdenPedido__c = infoRequest.Oportunidad.estadoOrdenPedido;
                                }
                                if(infoRequest.Oportunidad.idEstudio != null){
                                    opUpdate.IdEstudio__c = infoRequest.Oportunidad.idEstudio;
                                }
                                if(infoRequest.Oportunidad.etapaCredito != null){
                                    opUpdate.EtapaDelCredito__c = infoRequest.Oportunidad.etapaCredito;
                                }
                                if(infoRequest.Oportunidad.existeInventario != null){
                                    opUpdate.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario;
                                }
                                if(infoRequest.Oportunidad.cotizacionPedidoEnviada != null){
                                    opUpdate.CotizacionPedidoEnviada__c = infoRequest.Oportunidad.cotizacionPedidoEnviada;
                                }
                                if(infoRequest.Oportunidad.completacionCredito != null){
                                    opUpdate.CompletacionDeCredito__c = infoRequest.Oportunidad.completacionCredito;
                                    opUpdate.ConcatPendCred__c = infoRequest.Oportunidad.completacionCredito;
                                }
                                if(infoRequest.Oportunidad.ordenPedidoAprobada != null){
                                    opUpdate.OrdenPedidoAprobada__c = infoRequest.Oportunidad.ordenPedidoAprobada;
                                }
                                if(infoRequest.Oportunidad.fechaEntrega != null){
                                    opUpdate.FechaEntrega__c = infoRequest.Oportunidad.fechaEntrega;
                                }
                                if(infoRequest.Oportunidad.pin != null){
                                    opUpdate.PIN__c = infoRequest.Oportunidad.pin;
                                }
                                if(infoRequest.Oportunidad.propuestaPago != null){
                                    opUpdate.PropuestaDePago__c = infoRequest.Oportunidad.propuestaPago;
                                }
                                if(infoRequest.Oportunidad.pedidoFactura != null){
                                    opUpdate.PedidoFaturado__c = infoRequest.Oportunidad.pedidoFactura;
                                }
                                if(infoRequest.Oportunidad.cerrada != null){
                                    opUpdate.Cerrada__c = infoRequest.Oportunidad.cerrada;
                                }   
                                if(infoRequest.Oportunidad.agenciaPedido != null){
                                    opUpdate.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                                }
                                if(infoRequest.Oportunidad.origen != null){
                                    opUpdate.LeadSource = infoRequest.Oportunidad.origen;
                                }
                                if(infoRequest.Oportunidad.tipoPago != null){
                                    opUpdate.TipoDePago__c = infoRequest.Oportunidad.tipoPago;
                                }
                                if(infoRequest.Oportunidad.fechaFacturacion != null){
                                    opUpdate.FechaFacturacion__c = infoRequest.Oportunidad.fechaFacturacion;
                                }
                                if(infoRequest.Oportunidad.idCliente != null){
                                    opUpdate.IdCliente__c = infoRequest.Oportunidad.idCliente;
                                }
                                if(infoRequest.Oportunidad.fechaCompletacionCredito != null){
                                    opUpdate.FechaCompletacionCredito__c = infoRequest.Oportunidad.fechaCompletacionCredito;
                                }
                                if(infoRequest.Oportunidad.fechaAprobacion != null){
                                    opUpdate.FechaAprobacion__c = infoRequest.Oportunidad.fechaAprobacion;
                                }
                                if(infoRequest.Oportunidad.fechaCreacionOP != null){
                                    opUpdate.FechaEnvioCotizacion__c = infoRequest.Oportunidad.fechaCreacionOP;
                                }
                                if(infoRequest.Oportunidad.tipoVenta != null){
                                    opUpdate.Type = infoRequest.Oportunidad.tipoVenta;
                                }
                                if(infoRequest.Oportunidad.numeroOrdenPedido != null){
                                    opUpdate.Numero_OP__c = String.valueOf(infoRequest.Oportunidad.numeroOrdenPedido);
                                }
                                if(infoRequest.Oportunidad.tipoOportunidad != null){
                                    if(infoRequest.Oportunidad.tipoOportunidad == 'Contado'){
                                        opUpdate.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                                    }else{
                                        opUpdate.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                                    }
                                }
                                if(infoRequest.Oportunidad.motivoPerdida != null){
                                    opUpdate.MotivoDePerdida__c = infoRequest.Oportunidad.motivoPerdida;
                                }
                                
                                System.debug(' ** INFO OP ** ' + opUpdate);
                                
                                /**
* Mod Braya 5-08-2021
* */
                                if(infoRequest.Oportunidad.ejecutivoCredito != null){
                                    opUpdate.Ejecutivo_de_Credito__c = infoRequest.Oportunidad.ejecutivoCredito;
                                }
                                if(infoRequest.Oportunidad.ultimaFechaPrecalificacion != null){
                                    opUpdate.Ultima_Fecha_de_Pre_Calificacion__c = infoRequest.Oportunidad.ultimaFechaPrecalificacion;
                                }
                                if(act.isEmpty() && act.size() == 0){
                                    opUpdate.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                                    opUpdate.Description = newAct.Description;
                                    opUpdate.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                                }else{
                                    opUpdate.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                                    opUpdate.Description = act[0].Description;
                                    opUpdate.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                                }
                                if(infoRequest.Oportunidad.listoFacturarFecha != null){
                                    opUpdate.Listo_Facturar_Fecha__c = infoRequest.Oportunidad.listoFacturarFecha;
                                }
                                if(infoRequest.Oportunidad.listoFacturar != null){
                                    opUpdate.Listo_a_Factruar__c = infoRequest.Oportunidad.listoFacturar;
                                }
                                if(infoRequest.Oportunidad.fechaDespacho != null){
                                    opUpdate.Fecha_Despacho__c = infoRequest.Oportunidad.fechaDespacho;
                                }
                                if(infoRequest.Oportunidad.citaEntrega != null){
                                    opUpdate.Cita_Entrega__c = infoRequest.Oportunidad.citaEntrega;
                                }
                                if(infoRequest.Oportunidad.opDeTercero != null){
                                    opUpdate.OP_de_terceros__c = infoRequest.Oportunidad.opDeTercero;
                                }
      
                                if(infoRequest.Oportunidad.canalAtencion != null){
                                    opUpdate.Canal_de_Atencion__c = infoRequest.Oportunidad.canalAtencion;
                                }
                                if(infoRequest.Oportunidad.origenVenta != null){
                                    opUpdate.Origen_Venta__c = infoRequest.Oportunidad.origenVenta;
                                }
                                update opUpdate;
                            }
                        }
                    else if(updateOp && infoRequest.Oportunidad != null && !createOpOld && !createOpOld2)
                    {
                        System.debug(' ** SE ACTUALIZA UNA OPORTUNIDAD QUE YA TIENE ID OP updateOp && infoRequest.Oportunidad != null && !createOpOld ** ');
                        if(infoRequest.Oportunidad.etapa != null){
                            opUpdate.StageName = infoRequest.Oportunidad.etapa;
                        }
                        if(infoRequest.Oportunidad.causalDesiste != null){
                            opUpdate.Causal_Desiste__c = infoRequest.Oportunidad.causalDesiste;
                        }
                        if(infoRequest.Oportunidad.etapaEntrega != null){
                                    opUpdate.Etapa_Entrega__c = infoRequest.Oportunidad.etapaEntrega;
                        }
                        opUpdate.Api_Name__c = 'APIV1';
                        if(infoRequest.Oportunidad.ventaTotal != null){
                            opUpdate.VentaTotal__c = infoRequest.Oportunidad.ventaTotal;
                        }
                        if(infoRequest.Oportunidad.accionSugerida != null){
                            opUpdate.Accion_Sugerida__c = infoRequest.Oportunidad.accionSugerida;
                        }
                        if(infoRequest.Oportunidad.seguro != null){
                            opUpdate.Seguro__c = infoRequest.Oportunidad.seguro;
                        }
                        if(infoRequest.Oportunidad.fechaCierre != null){
                            opUpdate.CloseDate = infoRequest.Oportunidad.fechaCierre;
                        }
                        if(infoRequest.Oportunidad.agenciaPedido != null){
                            opUpdate.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                        }
                        if(infoRequest.Oportunidad.periodo != null){
                            opUpdate.Periodo__c = infoRequest.Oportunidad.periodo;
                        }
                        if(infoRequest.Oportunidad.codigoVendedor != null){
                            opUpdate.CodigoVendedor__c = infoRequest.Oportunidad.codigoVendedor;
                        }
                        if(infoRequest.Oportunidad.nombreVendedor != null){
                            opUpdate.NombreDeVendedor__c = infoRequest.Oportunidad.nombreVendedor;
                        }
                        if(infoRequest.Oportunidad.emisionOrdenPedido != null){
                            opUpdate.EmisionOrdenPedido__c = infoRequest.Oportunidad.emisionOrdenPedido;
                        }
                        if(infoRequest.Oportunidad.cuotas != null){
                            opUpdate.Cuotas__c = infoRequest.Oportunidad.cuotas;
                        }
                        if(infoRequest.Oportunidad.direccionDespacho != null){
                            opUpdate.DireccionDeDespacho__c = infoRequest.Oportunidad.direccionDespacho;
                        }
                        if(infoRequest.Oportunidad.estadoOrdenPedido != null){
                            opUpdate.EstadoOrdenPedido__c = infoRequest.Oportunidad.estadoOrdenPedido;
                        }
                        if(infoRequest.Oportunidad.idEstudio != null){
                            opUpdate.IdEstudio__c = infoRequest.Oportunidad.idEstudio;
                        }
                        if(infoRequest.Oportunidad.etapaCredito != null){
                            opUpdate.EtapaDelCredito__c = infoRequest.Oportunidad.etapaCredito;
                        }
                        if(infoRequest.Oportunidad.existeInventario != null){
                            opUpdate.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario;
                        }
                        if(infoRequest.Oportunidad.cotizacionPedidoEnviada != null){
                            opUpdate.CotizacionPedidoEnviada__c = infoRequest.Oportunidad.cotizacionPedidoEnviada;
                        }
                        if(infoRequest.Oportunidad.completacionCredito != null){
                            opUpdate.CompletacionDeCredito__c = infoRequest.Oportunidad.completacionCredito;
                            opUpdate.ConcatPendCred__c = infoRequest.Oportunidad.completacionCredito;
                        }
                        if(infoRequest.Oportunidad.ordenPedidoAprobada != null){
                            opUpdate.OrdenPedidoAprobada__c = infoRequest.Oportunidad.ordenPedidoAprobada;
                        }
                        if(infoRequest.Oportunidad.fechaEntrega != null){
                            opUpdate.FechaEntrega__c = infoRequest.Oportunidad.fechaEntrega;
                        }
                        if(infoRequest.Oportunidad.pin != null){
                            opUpdate.PIN__c = infoRequest.Oportunidad.pin;
                        }
                        if(infoRequest.Oportunidad.propuestaPago != null){
                            opUpdate.PropuestaDePago__c = infoRequest.Oportunidad.propuestaPago;
                        }
                        if(infoRequest.Oportunidad.pedidoFactura != null){
                            opUpdate.PedidoFaturado__c = infoRequest.Oportunidad.pedidoFactura;
                        }
                        if(infoRequest.Oportunidad.cerrada != null){
                            opUpdate.Cerrada__c = infoRequest.Oportunidad.cerrada;
                        }
                        if(infoRequest.Oportunidad.motivoPerdida != null){
                            opUpdate.MotivoDePerdida__c = infoRequest.Oportunidad.motivoPerdida;
                        }
                        if(infoRequest.Oportunidad.origen != null){
                            opUpdate.LeadSource = infoRequest.Oportunidad.origen;
                        }
                        if(infoRequest.Oportunidad.tipoPago != null){
                            opUpdate.TipoDePago__c = infoRequest.Oportunidad.tipoPago;
                        }
                        if(infoRequest.Oportunidad.fechaFacturacion != null){
                            opUpdate.FechaFacturacion__c = infoRequest.Oportunidad.fechaFacturacion;
                        }
                        if(infoRequest.Oportunidad.idCliente != null){
                            opUpdate.IdCliente__c = infoRequest.Oportunidad.idCliente;
                        }
                        if(infoRequest.Oportunidad.fechaCompletacionCredito != null){
                            opUpdate.FechaCompletacionCredito__c = infoRequest.Oportunidad.fechaCompletacionCredito;
                        }
                        if(infoRequest.Oportunidad.fechaAprobacion != null){
                            opUpdate.FechaEnvioCotizacion__c = infoRequest.Oportunidad.fechaAprobacion;
                        }
                        if(infoRequest.Oportunidad.tipoVenta != null){
                            opUpdate.Type = infoRequest.Oportunidad.tipoVenta;
                        }
                        if(infoRequest.Oportunidad.fechaAprobacion != null){
                            opUpdate.FechaAprobacion__c = infoRequest.Oportunidad.fechaAprobacion;
                        }
                        if(infoRequest.Oportunidad.numeroOrdenPedido != null){
                            opUpdate.Numero_OP__c = String.valueOf(infoRequest.Oportunidad.numeroOrdenPedido);
                        }
                        if(infoRequest.Oportunidad.tipoOportunidad != null){
                            if(infoRequest.Oportunidad.tipoOportunidad == 'Contado'){
                                opUpdate.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                            }else{
                                opUpdate.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                            }
                        }
                        
                        System.debug(' ** INFO OP ** ' + opUpdate);
                        /**
* Mod Braya 5-08-2021
* */
                        if(infoRequest.Oportunidad.ejecutivoCredito != null){
                            opUpdate.Ejecutivo_de_Credito__c = infoRequest.Oportunidad.ejecutivoCredito;
                        }
                        if(infoRequest.Oportunidad.ultimaFechaPrecalificacion != null){
                            opUpdate.Ultima_Fecha_de_Pre_Calificacion__c = infoRequest.Oportunidad.ultimaFechaPrecalificacion;
                        }
                        if(act.isEmpty() && act.size() == 0){
                            opUpdate.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                            opUpdate.Description = newAct.Description;
                            opUpdate.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                        }else{
                            opUpdate.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                            opUpdate.Description = act[0].Description;
                            opUpdate.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                        }
                        		if(infoRequest.Oportunidad.listoFacturarFecha != null){
                                    opUpdate.Listo_Facturar_Fecha__c = infoRequest.Oportunidad.listoFacturarFecha;
                                }
                                if(infoRequest.Oportunidad.listoFacturar != null){
                                    opUpdate.Listo_a_Factruar__c = infoRequest.Oportunidad.listoFacturar;
                                }
                                if(infoRequest.Oportunidad.fechaDespacho != null){
                                    opUpdate.Fecha_Despacho__c = infoRequest.Oportunidad.fechaDespacho;
                                }
                                if(infoRequest.Oportunidad.citaEntrega != null){
                                    opUpdate.Cita_Entrega__c = infoRequest.Oportunidad.citaEntrega;
                                }
                                if(infoRequest.Oportunidad.opDeTercero != null){
                                    opUpdate.OP_de_terceros__c = infoRequest.Oportunidad.opDeTercero;
                                }
                        		if(infoRequest.Oportunidad.canalAtencion != null){
                                    opUpdate.Canal_de_Atencion__c = infoRequest.Oportunidad.canalAtencion;
                                }
                                if(infoRequest.Oportunidad.origenVenta != null){
                                    opUpdate.Origen_Venta__c = infoRequest.Oportunidad.origenVenta;
                                }
                        update opUpdate;
                    }
                    else if(infoRequest.Oportunidad != null && !createOpOld && !createOpOld2)
                    {
                        System.debug(' ** SE ACTUALIZA LA OPORTUNIDAD QUE NO TIENE ID OP infoRequest.Oportunidad != null && !createOpOld** ');
                        if(infoRequest.Oportunidad.idOP != null){
                            opUpdateIdOP.IdOP__c = infoRequest.Oportunidad.idOP;
                        }
                        
                        if(infoRequest.Oportunidad.accionSugerida != null){
                                    opUpdateIdOP.Accion_Sugerida__c = infoRequest.Oportunidad.accionSugerida;
                                }
                        if(infoRequest.Oportunidad.etapaEntrega != null){
                                    opUpdateIdOP.Etapa_Entrega__c = infoRequest.Oportunidad.etapaEntrega;
                                }
                        if(infoRequest.Oportunidad.causalDesiste != null){
                                    opUpdateIdOP.Causal_Desiste__c = infoRequest.Oportunidad.causalDesiste;
                                }
                        opUpdateIdOP.Api_Name__c = 'APIV1';
                        if(infoRequest.Oportunidad.etapa != null){
                            opUpdateIdOP.StageName = infoRequest.Oportunidad.etapa;
                        }
                        if(infoRequest.Oportunidad.ventaTotal != null){
                            opUpdateIdOP.VentaTotal__c = infoRequest.Oportunidad.ventaTotal;
                        }
                        if(infoRequest.Oportunidad.seguro != null){
                            opUpdateIdOP.Seguro__c = infoRequest.Oportunidad.seguro;
                        }
                        if(infoRequest.Oportunidad.fechaCierre != null){
                            opUpdateIdOP.CloseDate = infoRequest.Oportunidad.fechaCierre;
                        }
                        if(infoRequest.Oportunidad.agenciaPedido != null){
                            opUpdateIdOP.AgenciaPedido__c = mapAgencias.get(infoRequest.Oportunidad.agenciaPedido).Id;
                        }
                        if(infoRequest.Oportunidad.periodo != null){
                            opUpdateIdOP.Periodo__c = infoRequest.Oportunidad.periodo;
                        }
                        if(infoRequest.Oportunidad.codigoVendedor != null){
                            opUpdateIdOP.CodigoVendedor__c = infoRequest.Oportunidad.codigoVendedor;
                        }
                        if(infoRequest.Oportunidad.nombreVendedor != null){
                            opUpdateIdOP.NombreDeVendedor__c = infoRequest.Oportunidad.nombreVendedor;
                        }
                        if(infoRequest.Oportunidad.emisionOrdenPedido != null){
                            opUpdateIdOP.EmisionOrdenPedido__c = infoRequest.Oportunidad.emisionOrdenPedido;
                        }
                        if(infoRequest.Oportunidad.cuotas != null){
                            opUpdateIdOP.Cuotas__c = infoRequest.Oportunidad.cuotas;
                        }
                        if(infoRequest.Oportunidad.direccionDespacho != null){
                            opUpdateIdOP.DireccionDeDespacho__c = infoRequest.Oportunidad.direccionDespacho;
                        }
                        if(infoRequest.Oportunidad.estadoOrdenPedido != null){
                            opUpdateIdOP.EstadoOrdenPedido__c = infoRequest.Oportunidad.estadoOrdenPedido;
                        }
                        if(infoRequest.Oportunidad.idEstudio != null){
                            opUpdateIdOP.IdEstudio__c = infoRequest.Oportunidad.idEstudio;
                        }
                        if(infoRequest.Oportunidad.etapaCredito != null){
                            opUpdateIdOP.EtapaDelCredito__c = infoRequest.Oportunidad.etapaCredito;
                        }
                        if(infoRequest.Oportunidad.existeInventario != null){
                            opUpdateIdOP.ExisteEnInventario__c = infoRequest.Oportunidad.existeInventario;
                        }
                        if(infoRequest.Oportunidad.cotizacionPedidoEnviada != null){
                            opUpdateIdOP.CotizacionPedidoEnviada__c = infoRequest.Oportunidad.cotizacionPedidoEnviada;
                        }
                        if(infoRequest.Oportunidad.completacionCredito != null){
                            opUpdateIdOP.CompletacionDeCredito__c = infoRequest.Oportunidad.completacionCredito;
                            opUpdate.ConcatPendCred__c = infoRequest.Oportunidad.completacionCredito;
                        }
                        if(infoRequest.Oportunidad.ordenPedidoAprobada != null){
                            opUpdateIdOP.OrdenPedidoAprobada__c = infoRequest.Oportunidad.ordenPedidoAprobada;
                        }
                        if(infoRequest.Oportunidad.fechaEntrega != null){
                            opUpdateIdOP.FechaEntrega__c = infoRequest.Oportunidad.fechaEntrega;
                        }
                        if(infoRequest.Oportunidad.pin != null){
                            opUpdateIdOP.PIN__c = infoRequest.Oportunidad.pin;
                        }
                        if(infoRequest.Oportunidad.propuestaPago != null){
                            opUpdateIdOP.PropuestaDePago__c = infoRequest.Oportunidad.propuestaPago;
                        }
                        if(infoRequest.Oportunidad.pedidoFactura != null){
                            opUpdateIdOP.PedidoFaturado__c = infoRequest.Oportunidad.pedidoFactura;
                        }
                        if(infoRequest.Oportunidad.cerrada != null){
                            opUpdateIdOP.Cerrada__c = infoRequest.Oportunidad.cerrada;
                        }
                        if(infoRequest.Oportunidad.motivoPerdida != null){
                            opUpdateIdOP.MotivoDePerdida__c = infoRequest.Oportunidad.motivoPerdida;
                        }
                        if(infoRequest.Oportunidad.origen != null){
                            opUpdateIdOP.LeadSource = infoRequest.Oportunidad.origen;
                        }   
                        if(infoRequest.Oportunidad.tipoPago != null){
                            opUpdateIdOP.TipoDePago__c = infoRequest.Oportunidad.tipoPago;
                        }
                        if(infoRequest.Oportunidad.fechaFacturacion != null){
                            opUpdateIdOP.FechaFacturacion__c = infoRequest.Oportunidad.fechaFacturacion;
                        }
                        if(infoRequest.Oportunidad.idCliente != null){
                            opUpdateIdOP.IdCliente__c = infoRequest.Oportunidad.idCliente;
                        }
                        if(infoRequest.Oportunidad.fechaCompletacionCredito != null){
                            opUpdateIdOP.FechaCompletacionCredito__c = infoRequest.Oportunidad.fechaCompletacionCredito;
                        }
                        if(infoRequest.Oportunidad.fechaAprobacion != null){
                            opUpdateIdOP.FechaAprobacion__c = infoRequest.Oportunidad.fechaAprobacion;
                        }
                        if(infoRequest.Oportunidad.fechaCreacionOP != null){
                            opUpdateIdOP.FechaEnvioCotizacion__c = infoRequest.Oportunidad.fechaCreacionOP;
                        }
                        if(infoRequest.Oportunidad.tipoVenta != null){
                            opUpdateIdOP.Type = infoRequest.Oportunidad.tipoVenta;
                        }
                        if(infoRequest.Oportunidad.numeroOrdenPedido != null){
                            opUpdateIdOP.Numero_OP__c = String.valueOf(infoRequest.Oportunidad.numeroOrdenPedido);
                        }
                        if(infoRequest.Oportunidad.tipoOportunidad != null){
                            if(infoRequest.Oportunidad.tipoOportunidad == 'Contado'){
                                opUpdateIdOP.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                            }else{
                                opUpdateIdOP.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                            }
                        }
                        
                        /**
* Mod Braya 5-08-2021
* */
                        if(infoRequest.Oportunidad.ejecutivoCredito != null){
                            opUpdateIdOP.Ejecutivo_de_Credito__c = infoRequest.Oportunidad.ejecutivoCredito;
                        }
                        if(infoRequest.Oportunidad.ultimaFechaPrecalificacion != null){
                            opUpdateIdOP.Ultima_Fecha_de_Pre_Calificacion__c = infoRequest.Oportunidad.ultimaFechaPrecalificacion;
                        }
                        
                        /**
* Mod Brayan 
* */
                        if(act.isEmpty() && act.size() == 0){
                            opUpdateIdOP.Tipo_de_Registro__c = newAct.Tipo_de_Registro__c;
                            opUpdateIdOP.Description = newAct.Description;
                            opUpdateIdOP.Ultima_Fecha_Ingreso__c = newAct.Ultima_Fecha_Ingreso__c;
                        }else{
                            opUpdateIdOP.Tipo_de_Registro__c = act[0].Tipo_de_Registro__c;
                            opUpdateIdOP.Description = act[0].Description;
                            opUpdateIdOP.Ultima_Fecha_Ingreso__c = act[0].Ultima_Fecha_Ingreso__c;
                        }
                        
                        		if(infoRequest.Oportunidad.listoFacturarFecha != null){
                                    opUpdateIdOP.Listo_Facturar_Fecha__c = infoRequest.Oportunidad.listoFacturarFecha;
                                }
                                if(infoRequest.Oportunidad.listoFacturar != null){
                                    opUpdateIdOP.Listo_a_Factruar__c = infoRequest.Oportunidad.listoFacturar;
                                }
                                if(infoRequest.Oportunidad.fechaDespacho != null){
                                    opUpdateIdOP.Fecha_Despacho__c = infoRequest.Oportunidad.fechaDespacho;
                                }
                                if(infoRequest.Oportunidad.citaEntrega != null){
                                    opUpdateIdOP.Cita_Entrega__c = infoRequest.Oportunidad.citaEntrega;
                                }
                                if(infoRequest.Oportunidad.opDeTercero != null){
                                    opUpdateIdOP.OP_de_terceros__c = infoRequest.Oportunidad.opDeTercero;
                                }
                        if(infoRequest.Oportunidad.canalAtencion != null){
                                    opUpdateIdOP.Canal_de_Atencion__c = infoRequest.Oportunidad.canalAtencion;
                                }
                                if(infoRequest.Oportunidad.origenVenta != null){
                                    opUpdateIdOP.Origen_Venta__c = infoRequest.Oportunidad.origenVenta;
                                }
                        System.debug(' ** INFO OP ** ' + opUpdateIdOP);
                        update opUpdateIdOP;
                    }
                    response.descripcionError = 'Registro procesado exitosamente.';
                }catch(Exception ex){
                    log.ClassName__c = 'GoogleBotAPIV1';
                    log.date__c = Datetime.now();
                    log.message__c = 'Error al intentar procesar la oportunidad. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                    log.success__c = false;
                    log.type__c = 'Procesamiento de peticion al ws';
                    log.JSON__c = jsonInput;
                    if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                        log.Empresa__c = 'Panamá';
                    }else{
                        log.Empresa__c = 'Colombia';
                    }
                    insert log;
                    
                    System.debug(' ** ERROR OPORTUNIDAD ** ' + ex.getMessage()); 
                    
                    response.estado = 'Error';
                    response.descripcionError = 'Error al intentar procesar la oportunidad. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                    response.codigoError = '';
                    return response;
                }
                
                //Se procesan los productos de oportunidad
                if(infoRequest.Productos != null){
                    try{
                        Boolean existe = false;
                        List<PricebookEntry> listPriceBook = new List<PricebookEntry>();
                        List<OpportunityLineItem> listProdOpExist = new List<OpportunityLineItem>();
                        List<OpportunityLineItem> listProdOp = new List<OpportunityLineItem>();
                        List<OpportunityLineItem> listProdOpUpdate = new List<OpportunityLineItem>();
                        Set<String> idsProdEliminar = new Set<String>();
                        Set<String> setIdsProd = new Set<String>();
                        Map<String, Product2> mapProd = new Map<String, Product2>();
                        Map<String, PricebookEntry> mapListaPrecios = new Map<String, PricebookEntry>();
                        Map<id,OpportunityLineItem> listProdOpUpdateUnique = new Map<id,OpportunityLineItem>();
                        
                        
                        //listPriceBook = [SELECT Id FROM PricebookEntry];
                        //System.debug(' ** LIST PRICE BOOK ** ' + listPriceBook);
                        
                        for(Productos p : infoRequest.Productos){
                            setIdsProd.add(p.idProducto);
                        }
                        System.debug('LISTADO DE PRODUCT');                        
                        System.debug(setIdsProd);
                        
                        for(Product2 p : [SELECT Id, ProductCode, IdProducto__c, Description FROM Product2 WHERE IdProducto__c IN : setIdsProd]){
                            mapProd.put(p.IdProducto__c, p);
                        }
                        
                        for(PricebookEntry pbe : [SELECT Id, Product2.IdProducto__c FROM PricebookEntry WHERE Product2.IdProducto__c IN : setIdsProd]){
                            mapListaPrecios.put(pbe.Product2.IdProducto__c, pbe);
                        }
                        
                        if(!newOp){
                            if(updateOp){
                                System.debug('ENTRO A updateOp' + opUpdate.Id);
                                listProdOpExist = [SELECT Product2Id, Quantity, Description, PricebookEntryId, TotalPrice, IdProducto__c, IdDetalleOP__c, IdOP__c FROM OpportunityLineItem WHERE OpportunityId =: opUpdate.Id];
                            }else{
                                System.debug('ENTRO A opUpdateIdOP');
                                listProdOpExist = [SELECT Product2Id, Quantity, Description, PricebookEntryId, TotalPrice, IdProducto__c, IdDetalleOP__c, IdOP__c FROM OpportunityLineItem WHERE OpportunityId =: opUpdateIdOP.Id];
                            }
                        }
                        
                        System.debug(' ** MAPA PRODUCTOS ** ' + mapProd.values());
                        System.debug(' ** COUNT 2 ** ' + count);
                        System.debug(' ** UPDATEOP ** ' + updateOp);
                        System.debug(' ** MAPA LISTA PRECIOS ** ' + mapListaPrecios.values());
                        
                        
                        if(!listProdOpExist.isEmpty() && listProdOpExist.size() > 0){
                            delete listProdOpExist;
                        }
                        if(newOp){
                            for(Productos p : infoRequest.Productos){
								System.debug(' ** PRODUCTOS NUEVOS ** ');
                                OpportunityLineItem prod = new OpportunityLineItem();
                                
                                if(p.cantidad != null){
                                    if((count == 0 && !updateOp) || infoRequest.Record.origen == 'App Vendedor'){
                                        if(!updateOp){
											System.debug(' ** OP NUEVA ** ' + opCreate);
                                            prod.OpportunityId = opCreate.Id;
                                        }else{
											System.debug(' ** OP UPDATE ** ' + opUpdate);
                                            prod.OpportunityId = opUpdate.Id;
                                        }
                                    }else if(updateOp){
										System.debug(' ** OP UPDATE 2 ** ' + opUpdate);
                                        prod.OpportunityId = opUpdate.Id;
                                    }else{
										System.debug(' ** OP UPDATE ID OP ** ' + opUpdateIdOP);
                                        prod.OpportunityId = opUpdateIdOP.Id;
                                    }
                                    prod.Product2Id = mapProd.get(p.idProducto).Id;
                                    prod.Quantity = p.cantidad;
                                    prod.Description = mapProd.get(p.idProducto).Description;
                                    //prod.PricebookEntryId = listPriceBook[0].Id;
                                    prod.PricebookEntryId = mapListaPrecios.get(p.idProducto).Id;
                                    prod.TotalPrice = p.valor;
                                    prod.IdProducto__c = p.idProducto;
                                    prod.IdDetalleOP__c = p.idDetalleOP;
                                    prod.IdOP__c = p.idOP;
                                    
                                    System.debug(' ** PRODUCTO NUEVO ** ' + prod);
                                    listProdOp.add(prod);
                                }
                            }   
                        }
                        else{
                            for(Productos p : infoRequest.Productos){
                                    OpportunityLineItem prod = new OpportunityLineItem();
                                        
                                    if(updateOp){
                                        prod.OpportunityId = opUpdate.Id;
                                    }else{
                                        prod.OpportunityId = opUpdateIdOP.Id;
                                    }
                                    prod.Product2Id = mapProd.get(p.idProducto).Id;
                                    prod.Quantity = p.cantidad;
                                    prod.Description = mapProd.get(p.idProducto).Description;
                                    //prod.PricebookEntryId = listPriceBook[0].Id;
                                    prod.PricebookEntryId = mapListaPrecios.get(p.idProducto).Id;
                                    prod.TotalPrice = p.valor;
                                    prod.IdProducto__c = p.idProducto;
                                    prod.IdDetalleOP__c = p.idDetalleOP;
                                    prod.IdOP__c = p.idOP;
                                    
                                    idsProdEliminar.add(p.idProducto);
                                    System.debug(' ** PRODUCTO NUEVO A OPORTUNIDAD EXISTENTE ** ' + prod);
                                    listProdOp.add(prod);
                               
                            }
                        }
                         if(!listProdOp.isEmpty() && listProdOp.size() > 0){
                            insert listProdOp;
                        }
                              
                    }catch(Exception ex){
                        System.debug(' ** ERROR PRODUCTO ** ' + ex.getMessage()); 
                        log.ClassName__c = 'GoogleBotAPIV1';
                        log.date__c = Datetime.now();
                        log.message__c = 'Error al intentar procesar el producto de la oportunidad. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                        log.success__c = false;
                        log.type__c = 'Procesamiento de peticion al ws';
                        log.JSON__c = jsonInput;
                        if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                            log.Empresa__c = 'Panamá';
                        }else{
                            log.Empresa__c = 'Colombia';
                        }
                        insert log;
                        
                        response.estado = 'Error';
                        response.descripcionError = 'Error al intentar procesar el producto de la oportunidad. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                        response.codigoError = '';
                        return response;
                    }
                }
            }
        }else{
            esLead = true;
            System.debug(' ** RECORD ENTRANTE ES LEAD ** ' + esLead);
        }
        
        //Se procesa el lead entrante siempre y cuando no existe como cuenta
        if(esLead && !leadConvertido){
            Boolean crearLead = false;
            Boolean actualizarLead = false;
            Boolean busquedaCorreo = false;
            List<Lead> listProspCed = new List<Lead>();
            List<Lead> listProspEmail = new List<Lead>();
            
            if(infoRequest.Record.identificacion != null && infoRequest.Record.identificacion != ''){
                System.debug(' ** BUSQUEDA DE LEAD POR CEDULA ** ');
                listProspCed = [SELECT FirstName, MiddleName, LastName, LeadSource, Tipo_de_Venta__c, Tipo_de_Crdito__c, Status, Identificacin__c, Email, MobilePhone, Phone, Whatsapp_Telfono__c, City, Country, Latitud_de_Residencia__c,
                                Longitud_de_Residencia__c, Street, Ciudad_de_Trabajo__c, Pa_s_de_Trabajo__c, Latitud_de_Trabajo__c, Longitud_de_Trabajo__c, Calle_de_Trabajo__c, Cupo_Disponible__c, Producto_de_inters__c, Cuantos_contactos_ha_tenido__c,
                                Lnea_de_llamada__c, Cuota_Disponible__c, Agencia__c, Empresa__c, Tipo_de__c, Viabilidad__c, Estrategia__c, Segmento__c, Ocupacion__c, Ingresos__c, Tipo_de_Referencia__c, Tipo_de_relacion__c, Tipo__c,
                                Quiero_que_me_llamen__c, Pas__c, Salida__c, Description, leadDuplicadoAPI__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                FROM Lead WHERE Identificacin__c =: infoRequest.Record.identificacion AND IsConverted =: FALSE];
                if(listProspCed.isEmpty() && listProspCed.size() == 0 && infoRequest.Record.correoElectronico != '' && infoRequest.Record.correoElectronico != null){
                    System.debug(' ** BUSQUEDA DE LEAD POR CEDULA SIN REGISTROS, SE BUSCA POR CORREO ** ');
                    busquedaCorreo = true;
                    listProspCed = [SELECT FirstName, MiddleName, LastName, LeadSource, Tipo_de_Venta__c, Tipo_de_Crdito__c, Status, Identificacin__c, Email, MobilePhone, Phone, Whatsapp_Telfono__c, City, Country, Latitud_de_Residencia__c,
                                    Longitud_de_Residencia__c, Street, Ciudad_de_Trabajo__c, Pa_s_de_Trabajo__c, Latitud_de_Trabajo__c, Longitud_de_Trabajo__c, Calle_de_Trabajo__c, Cupo_Disponible__c, Producto_de_inters__c, Cuantos_contactos_ha_tenido__c,
                                    Lnea_de_llamada__c, Cuota_Disponible__c, Agencia__c, Empresa__c, Tipo_de__c, Viabilidad__c, Estrategia__c, Segmento__c, Ocupacion__c, Ingresos__c, Tipo_de_Referencia__c, Tipo_de_relacion__c, Tipo__c,
                                    Quiero_que_me_llamen__c, Pas__c, Salida__c, Description, leadDuplicadoAPI__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                    FROM Lead WHERE Email =: infoRequest.Record.correoElectronico AND IsConverted =: FALSE];
                }
            }else if(infoRequest.Record.correoElectronico != null && infoRequest.Record.correoElectronico != ''){
                System.debug(' ** BUSQUEDA DE LEAD POR CORREO ELECTRONICO SI EL REGISTRO NO TRAE CEDULA ** ');
                listProspEmail = [SELECT FirstName, MiddleName, LastName, LeadSource, Tipo_de_Venta__c, Tipo_de_Crdito__c, Status, Identificacin__c, Email, MobilePhone, Phone, Whatsapp_Telfono__c, City, Country, Latitud_de_Residencia__c,
                                  Longitud_de_Residencia__c, Street, Ciudad_de_Trabajo__c, Pa_s_de_Trabajo__c, Latitud_de_Trabajo__c, Longitud_de_Trabajo__c, Calle_de_Trabajo__c, Cupo_Disponible__c, Producto_de_inters__c, Cuantos_contactos_ha_tenido__c,
                                  Lnea_de_llamada__c, Cuota_Disponible__c, Agencia__c, Empresa__c, Tipo_de__c, Viabilidad__c, Estrategia__c, Segmento__c, Ocupacion__c, Ingresos__c, Tipo_de_Referencia__c, Tipo_de_relacion__c, Tipo__c,
                                  Quiero_que_me_llamen__c, Pas__c, Salida__c, Description, leadDuplicadoAPI__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c
                                  FROM Lead WHERE Email =: infoRequest.Record.correoElectronico AND IsConverted =: FALSE];
            }
            
            System.debug(' ** PROSP CED SIZE ** ' + listProspCed.size());
            System.debug(' ** PROSP EMAIL SIZE ** ' + listProspEmail.size());
            
            if(!listProspCed.isEmpty() && listProspCed.size() > 1){
                crearLead = true;
            }
            
            if(!listProspEmail.isEmpty() && listProspEmail.size() > 1 && listProspCed.isEmpty()){
                crearLead = true;
            }
            
            //Busqueda por identificacion
            if(listProspCed.size() == 1){
                if(!listProspCed.isEmpty() && !busquedaCorreo){
                    actualizarLead = true;
                }else if(!listProspCed.isEmpty() && busquedaCorreo){
                    if(listProspCed[0].Identificacin__c != '' && listProspCed[0].Identificacin__c != NULL){
                        if(listProspCed[0].Identificacin__c == infoRequest.Record.identificacion){
                            actualizarLead = true;
                        }else{
                            crearLead = true;
                        }
                    }else{
                        actualizarLead = true;  
                    }
                }else{
                    crearLead = true;
                }
            }
            
            //Busqueda por correo cuando el prospecto no viene con cedula
            if(!listProspEmail.isEmpty() && listProspEmail.size() == 1){
                actualizarLead = true;
            }else{
                crearLead = true;
            }
            
            try{
                if(actualizarLead){
                    if(!listProspCed.isEmpty()){
                        System.debug(' ** LEAD EXISTENTE POR CEDULA ** ');
                        if(infoRequest.Record.nombre != null && infoRequest.Record.nombre != ''){
                            listProspCed[0].FirstName = infoRequest.Record.nombre;
                        }
                        listProspCed[0].Api_Name__c = 'APIV1';
                        if(infoRequest.Record.tienda != null){
                            listProspCed[0].Tienda__c = mapAgencias.get(infoRequest.Record.tienda).Id;
                        }
                        if(infoRequest.Record.nombreVendedor != null){
                            listProspCed[0].Vendedor__c = infoRequest.Record.nombreVendedor;
                        }
                        if(infoRequest.Record.segundoNombre != null && infoRequest.Record.segundoNombre != '' && infoRequest.Record.segundoNombre != ''){
                            listProspCed[0].MiddleName = infoRequest.Record.segundoNombre;
                        }
                        if(infoRequest.Record.apellidos != null && infoRequest.Record.apellidos != '' && infoRequest.Record.segundoNombre != '-'){
                            listProspCed[0].LastName = infoRequest.Record.apellidos;
                        }
                        if(infoRequest.Record.origen != null){
                            listProspCed[0].LeadSource = infoRequest.Record.origen;
                        }
                        if(infoRequest.Record.tipoVenta != null){
                            listProspCed[0].Tipo_de_Venta__c = infoRequest.Record.tipoVenta;
                        }
                        if(infoRequest.Record.tipoCredito != null){
                            listProspCed[0].Tipo_de_Crdito__c = infoRequest.Record.tipoCredito;
                        }
                        if(infoRequest.Record.etapa != null){
                            if(listProspCed[0].Status == 'Unqualified'){
                                listProspCed[0].Status = 'Nuevo';
                            }else{
                                listProspCed[0].Status = infoRequest.Record.etapa;
                            }
                        }else if(listProspCed[0].Status == 'Unqualified'){
                            listProspCed[0].Status = 'Nuevo';
                        }
                        if(infoRequest.Record.identificacion != null){
                            listProspCed[0].Identificacin__c = infoRequest.Record.identificacion;
                        }
                        if(infoRequest.Record.correoElectronico != null && infoRequest.Record.correoElectronico != ''){
                            listProspCed[0].Email = infoRequest.Record.correoElectronico;
                        }
                        if(infoRequest.Record.celular != null && infoRequest.Record.celular != ''){
                            listProspCed[0].MobilePhone = infoRequest.Record.celular;
                        }
                        if(infoRequest.Record.telefonoFijo != null){
                            listProspCed[0].Phone = infoRequest.Record.telefonoFijo;
                        }
                        if(infoRequest.Record.whatsapp != null){
                            listProspCed[0].Whatsapp_Telfono__c = infoRequest.Record.whatsapp;
                        }
                        if(infoRequest.Record.latitudResidencia != null){
                            listProspCed[0].Latitud_de_Residencia__c = infoRequest.Record.latitudResidencia;
                        }
                        if(infoRequest.Record.longitudResidencia != null){
                            listProspCed[0].Longitud_de_Residencia__c = infoRequest.Record.longitudResidencia;
                        }
                        if(infoRequest.Record.calleResidencia != null){
                            listProspCed[0].Street = infoRequest.Record.calleResidencia;
                        }
                        if(infoRequest.Record.ciudadTrabajo != null){
                            listProspCed[0].Ciudad_de_Trabajo__c = infoRequest.Record.ciudadTrabajo;
                        }
                        if(infoRequest.Record.paisTrabajo != null){
                            listProspCed[0].Pa_s_de_Trabajo__c = infoRequest.Record.paisTrabajo;
                        }
                        if(infoRequest.Record.latitudTrabajo != null){
                            listProspCed[0].Latitud_de_Trabajo__c = infoRequest.Record.latitudTrabajo;
                        }
                        if(infoRequest.Record.longitudTrabajo != null){
                            listProspCed[0].Longitud_de_Trabajo__c = infoRequest.Record.longitudTrabajo;
                        }
                        if(infoRequest.Record.calleTrabajo != null){
                            listProspCed[0].Calle_de_Trabajo__c = infoRequest.Record.calleTrabajo;
                        }
                        if(infoRequest.Record.cupoDisponible != null){
                            listProspCed[0].Cupo_Disponible__c = infoRequest.Record.cupoDisponible;
                        }
                        if(infoRequest.Record.productoInteres != null){
                            listProspCed[0].Producto_de_inters__c = infoRequest.Record.productoInteres;
                        }
                        if(infoRequest.Record.cuantosContactosTenido != null){
                            listProspCed[0].Cuantos_contactos_ha_tenido__c = infoRequest.Record.cuantosContactosTenido;
                        }
                        if(infoRequest.Record.lineaLlamada != null){
                            listProspCed[0].Lnea_de_llamada__c = infoRequest.Record.lineaLlamada;
                        }
                        if(infoRequest.Record.cuotaDisponible != null){
                            listProspCed[0].Cuota_Disponible__c = infoRequest.Record.cuotaDisponible;
                        }
                        if(infoRequest.Record.agencia != null){
                            listProspCed[0].Agencia__c = mapAgencias.get(infoRequest.Record.agencia).Id;
                        }
                        if(infoRequest.Record.empresa != null && infoRequest.Record.empresa != ''){
                            listProspCed[0].Empresa__c = infoRequest.Record.empresa;
                        }
                        if(infoRequest.Record.tipoIdentificacion != null){
                            listProspCed[0].Tipo_de__c = infoRequest.Record.tipoIdentificacion;
                        }
                        if(infoRequest.Record.viabilidad != null){
                            listProspCed[0].Viabilidad__c = infoRequest.Record.viabilidad;
                        }
                        if(infoRequest.Record.estrategia != null){
                            listProspCed[0].Estrategia__c = infoRequest.Record.estrategia;
                        }
                        if(infoRequest.Record.segmento != null){
                            listProspCed[0].Segmento__c = infoRequest.Record.segmento;
                        }
                        if(infoRequest.Record.ocupacion != null){
                            listProspCed[0].Ocupacion__c = infoRequest.Record.ocupacion;
                        }
                        if(infoRequest.Record.ingresos != null){
                            listProspCed[0].Ingresos__c = infoRequest.Record.ingresos;
                        }
                        if(infoRequest.Record.tipoReferencia != null){
                            listProspCed[0].Tipo_de_Referencia__c = infoRequest.Record.tipoReferencia;
                        }
                        if(infoRequest.Record.tipoRelacion != null){
                            listProspCed[0].Tipo_de_relacion__c = infoRequest.Record.tipoRelacion;
                        }
                        if(infoRequest.Record.cuentaPersona != null && infoRequest.Record.cuentaPersona != ''){
                            listProspCed[0].Tipo__c = infoRequest.Record.cuentaPersona;
                        }
                        if(infoRequest.Record.quieroQueLlamen != null){
                            listProspCed[0].Quiero_que_me_llamen__c = infoRequest.Record.quieroQueLlamen;
                        }
                        if(infoRequest.Record.pais != null){
                            listProspCed[0].Pas__c = infoRequest.Record.pais;
                        }
                        if(infoRequest.Record.salida != null){
                            listProspCed[0].Salida__c = infoRequest.Record.salida;
                        }
                        if(infoRequest.Record.descripcion != null){
                            listProspCed[0].Description = infoRequest.Record.descripcion;
                        }
                        /**
* mod brayan
* **/
                        listProspCed[0].Ultima_Fecha_Ingreso__c = DateTime.now();
                        if(infoRequest.Record.tipoGestion != null){
                            listProspCed[0].Tipo_de_Registro__c = infoRequest.Record.tipoGestion;
                        }
                        if(infoRequest.Record.locale != null){
                            listProspCed[0].et4ae5__Mobile_Country_Code__c = infoRequest.Record.locale;
                        }
                        if(infoRequest.Record.gclid != null){
                            listProspCed[0].GCLID__c = infoRequest.Record.gclid;
                        }
                        update listProspCed;
                    }else if(!listProspEmail.isEmpty()){
                        System.debug(' ** LEAD EXISTENTE POR CORREO ** ');
                        if(infoRequest.Record.nombre != null && infoRequest.Record.nombre != ''){
                            listProspEmail[0].FirstName = infoRequest.Record.nombre;
                        }
                        listProspEmail[0].Api_Name__c = 'APIV1';
                        if(infoRequest.Record.tienda != null){
                            listProspEmail[0].Tienda__c = mapAgencias.get(infoRequest.Record.tienda).Id;
                        }
                        if(infoRequest.Record.nombreVendedor != null){
                            listProspEmail[0].Vendedor__c = infoRequest.Record.nombreVendedor;
                        }
                        if(infoRequest.Record.segundoNombre != null && infoRequest.Record.segundoNombre != '' && infoRequest.Record.segundoNombre != '-'){
                            listProspEmail[0].MiddleName = infoRequest.Record.segundoNombre;
                        }
                        if(infoRequest.Record.apellidos != null && infoRequest.Record.apellidos != '' && infoRequest.Record.apellidos != '-'){
                            listProspEmail[0].LastName = infoRequest.Record.apellidos;
                        }
                        if(infoRequest.Record.origen != null){
                            listProspEmail[0].LeadSource = infoRequest.Record.origen;
                        }
                        if(infoRequest.Record.tipoVenta != null){
                            listProspEmail[0].Tipo_de_Venta__c = infoRequest.Record.tipoVenta;
                        }
                        if(infoRequest.Record.tipoCredito != null){
                            listProspEmail[0].Tipo_de_Crdito__c = infoRequest.Record.tipoCredito;
                        }
                        if(infoRequest.Record.etapa != null){
                            if(listProspEmail[0].Status == 'Unqualified'){
                                listProspEmail[0].Status = 'Nuevo';
                            }else{
                                listProspEmail[0].Status = infoRequest.Record.etapa;
                            }
                        }else if(listProspEmail[0].Status == 'Unqualified'){
                            listProspEmail[0].Status = 'Nuevo';
                        }
                        if(infoRequest.Record.identificacion != null){
                            listProspEmail[0].Identificacin__c = infoRequest.Record.identificacion;
                        }
                        if(infoRequest.Record.correoElectronico != null && infoRequest.Record.correoElectronico != ''){
                            listProspEmail[0].Email = infoRequest.Record.correoElectronico;
                        }
                        if(infoRequest.Record.celular != null && infoRequest.Record.celular != ''){
                            listProspEmail[0].MobilePhone = infoRequest.Record.celular;
                        }
                        if(infoRequest.Record.telefonoFijo != null){
                            listProspEmail[0].Phone = infoRequest.Record.telefonoFijo;
                        }
                        if(infoRequest.Record.whatsapp != null){
                            listProspEmail[0].Whatsapp_Telfono__c = infoRequest.Record.whatsapp;
                        }
                        if(infoRequest.Record.latitudResidencia != null){
                            listProspEmail[0].Latitud_de_Residencia__c = infoRequest.Record.latitudResidencia;
                        }
                        if(infoRequest.Record.longitudResidencia != null){
                            listProspEmail[0].Longitud_de_Residencia__c = infoRequest.Record.longitudResidencia;
                        }
                        if(infoRequest.Record.calleResidencia != null){
                            listProspEmail[0].Street = infoRequest.Record.calleResidencia;
                        }
                        if(infoRequest.Record.ciudadTrabajo != null){
                            listProspEmail[0].Ciudad_de_Trabajo__c = infoRequest.Record.ciudadTrabajo;
                        }
                        if(infoRequest.Record.paisTrabajo != null){
                            listProspEmail[0].Pa_s_de_Trabajo__c = infoRequest.Record.paisTrabajo;
                        }
                        if(infoRequest.Record.latitudTrabajo != null){
                            listProspEmail[0].Latitud_de_Trabajo__c = infoRequest.Record.latitudTrabajo;
                        }
                        if(infoRequest.Record.longitudTrabajo != null){
                            listProspEmail[0].Longitud_de_Trabajo__c = infoRequest.Record.longitudTrabajo;
                        }
                        if(infoRequest.Record.calleTrabajo != null){
                            listProspEmail[0].Calle_de_Trabajo__c = infoRequest.Record.calleTrabajo;
                        }
                        if(infoRequest.Record.cupoDisponible != null){
                            listProspEmail[0].Cupo_Disponible__c = infoRequest.Record.cupoDisponible;
                        }
                        if(infoRequest.Record.productoInteres != null){
                            listProspEmail[0].Producto_de_inters__c = infoRequest.Record.productoInteres;
                        }
                        if(infoRequest.Record.cuantosContactosTenido != null){
                            listProspEmail[0].Cuantos_contactos_ha_tenido__c = infoRequest.Record.cuantosContactosTenido;
                        }
                        if(infoRequest.Record.lineaLlamada != null){
                            listProspEmail[0].Lnea_de_llamada__c = infoRequest.Record.lineaLlamada;
                        }
                        if(infoRequest.Record.cuotaDisponible != null){
                            listProspEmail[0].Cuota_Disponible__c = infoRequest.Record.cuotaDisponible;
                        }
                        if(infoRequest.Record.agencia != null){
                            listProspEmail[0].Agencia__c = mapAgencias.get(infoRequest.Record.agencia).Id;
                        }
                        if(infoRequest.Record.empresa != null && infoRequest.Record.empresa != ''){
                            listProspEmail[0].Empresa__c = infoRequest.Record.empresa;
                        }
                        if(infoRequest.Record.tipoIdentificacion != null){
                            listProspEmail[0].Tipo_de__c = infoRequest.Record.tipoIdentificacion;
                        }
                        if(infoRequest.Record.viabilidad != null){
                            listProspEmail[0].Viabilidad__c = infoRequest.Record.viabilidad;
                        }
                        if(infoRequest.Record.estrategia != null){
                            listProspEmail[0].Estrategia__c = infoRequest.Record.estrategia;
                        }
                        if(infoRequest.Record.segmento != null){
                            listProspEmail[0].Segmento__c = infoRequest.Record.segmento;
                        }
                        if(infoRequest.Record.ocupacion != null){
                            listProspEmail[0].Ocupacion__c = infoRequest.Record.ocupacion;
                        }
                        if(infoRequest.Record.ingresos != null){
                            listProspEmail[0].Ingresos__c = infoRequest.Record.ingresos;
                        }
                        if(infoRequest.Record.tipoReferencia != null){
                            listProspEmail[0].Tipo_de_Referencia__c = infoRequest.Record.tipoReferencia;
                        }
                        if(infoRequest.Record.tipoRelacion != null){
                            listProspEmail[0].Tipo_de_relacion__c = infoRequest.Record.tipoRelacion;
                        }
                        if(infoRequest.Record.cuentaPersona != null && infoRequest.Record.cuentaPersona != ''){
                            listProspEmail[0].Tipo__c = infoRequest.Record.cuentaPersona;
                        }
                        if(infoRequest.Record.quieroQueLlamen != null){
                            listProspEmail[0].Quiero_que_me_llamen__c = infoRequest.Record.quieroQueLlamen;
                        }
                        if(infoRequest.Record.pais != null){
                            listProspEmail[0].Pas__c = infoRequest.Record.pais;
                        }
                        if(infoRequest.Record.salida != null){
                            listProspEmail[0].Salida__c = infoRequest.Record.salida;
                        }
                        if(infoRequest.Record.descripcion != null){
                            listProspEmail[0].Description = infoRequest.Record.descripcion;
                        }
                        /**
* mod brayan
* */
                        listProspEmail[0].Ultima_Fecha_Ingreso__c = DateTime.now();
                        if(infoRequest.Record.tipoGestion != null){
                            listProspEmail[0].Tipo_de_Registro__c = infoRequest.Record.tipoGestion;
                        }
                        if(infoRequest.Record.locale != null){
                            listProspEmail[0].et4ae5__Mobile_Country_Code__c = infoRequest.Record.locale;
                        }
                        if(infoRequest.Record.gclid != null){
                            listProspEmail[0].GCLID__c = infoRequest.Record.gclid;
                        }
                        update listProspEmail;
                    }
                }else if(crearLead){
                    System.debug(' ** LEAD NUEVO ** ');
                    Lead leadNuevo = new Lead();
                    if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                        leadNuevo.RecordTypeId = idTRLead;
                    }else{
                        leadNuevo.RecordTypeId = idTRLeadCol;
                    }
                    if(infoRequest.Record.tienda != null){
                        leadNuevo.Tienda__c = mapAgencias.get(infoRequest.Record.tienda).Id;
                    }
                    leadNuevo.FirstName = infoRequest.Record.nombre;
                    leadNuevo.Api_Name__c = 'APIV1';
                    leadNuevo.Vendedor__c = infoRequest.Record.nombreVendedor;
                    leadNuevo.MiddleName = infoRequest.Record.segundoNombre;
                    leadNuevo.LastName = infoRequest.Record.apellidos;
                    leadNuevo.LeadSource = infoRequest.Record.origen;
                    leadNuevo.Tipo_de_Venta__c = infoRequest.Record.tipoVenta;
                    leadNuevo.Tipo_de_Crdito__c = infoRequest.Record.tipoCredito;
                    leadNuevo.Status = infoRequest.Record.etapa;
                    leadNuevo.Identificacin__c = infoRequest.Record.identificacion;
                    leadNuevo.Email = infoRequest.Record.correoElectronico;
                    leadNuevo.MobilePhone = infoRequest.Record.celular;
                    leadNuevo.Phone = infoRequest.Record.telefonoFijo;
                    leadNuevo.Whatsapp_Telfono__c = infoRequest.Record.whatsapp;
                    leadNuevo.City = infoRequest.Record.ciudadResidencia;
                    leadNuevo.Country = infoRequest.Record.paisResidencia;
                    leadNuevo.Latitud_de_Residencia__c = infoRequest.Record.latitudResidencia;
                    leadNuevo.Longitud_de_Residencia__c = infoRequest.Record.longitudResidencia;
                    leadNuevo.Street = infoRequest.Record.calleResidencia;
                    leadNuevo.Ciudad_de_Trabajo__c = infoRequest.Record.ciudadTrabajo;
                    leadNuevo.Pa_s_de_Trabajo__c = infoRequest.Record.paisTrabajo;
                    leadNuevo.Latitud_de_Trabajo__c = infoRequest.Record.latitudTrabajo;
                    leadNuevo.Longitud_de_Trabajo__c = infoRequest.Record.longitudTrabajo;
                    leadNuevo.Calle_de_Trabajo__c = infoRequest.Record.calleTrabajo;
                    leadNuevo.Cupo_Disponible__c = infoRequest.Record.cupoDisponible;
                    leadNuevo.Producto_de_inters__c = infoRequest.Record.productoInteres;
                    leadNuevo.Cuantos_contactos_ha_tenido__c = infoRequest.Record.cuantosContactosTenido;
                    leadNuevo.Lnea_de_llamada__c = infoRequest.Record.lineaLlamada;
                    leadNuevo.Cuota_Disponible__c = infoRequest.Record.cuotaDisponible;
                    if(infoRequest.Record.agencia != null){
                        leadNuevo.Agencia__c = mapAgencias.get(infoRequest.Record.agencia).Id;
                    }
                    leadNuevo.Empresa__c = infoRequest.Record.empresa;
                    leadNuevo.Tipo_de__c = infoRequest.Record.tipoIdentificacion;
                    leadNuevo.Viabilidad__c = infoRequest.Record.viabilidad;
                    leadNuevo.Estrategia__c = infoRequest.Record.estrategia;
                    leadNuevo.Segmento__c = infoRequest.Record.segmento;
                    leadNuevo.Ocupacion__c = infoRequest.Record.ocupacion;
                    leadNuevo.Ingresos__c = infoRequest.Record.ingresos;
                    leadNuevo.Tipo_de_Referencia__c = infoRequest.Record.tipoReferencia;
                    leadNuevo.Tipo_de_relacion__c = infoRequest.Record.tipoRelacion;
                    leadNuevo.Tipo__c = infoRequest.Record.cuentaPersona;
                    leadNuevo.Quiero_que_me_llamen__c = infoRequest.Record.quieroQueLlamen;
                    leadNuevo.Pas__c = infoRequest.Record.pais;
                    leadNuevo.Salida__c = infoRequest.Record.salida;
                    leadNuevo.Description = infoRequest.Record.descripcion;
                    leadNuevo.Primer_Origen__c = infoRequest.Record.origen;
                    /**
* mod brayan
* **/
                    leadNuevo.Ultima_Fecha_Ingreso__c = DateTime.now();
                    leadNuevo.Tipo_de_Registro__c = infoRequest.Record.tipoGestion;
                    leadNuevo.GCLID__c = infoRequest.Record.gclid;
                    if(infoRequest.Record.locale != null){
                        leadNuevo.et4ae5__Mobile_Country_Code__c = infoRequest.Record.locale;
                    }
                    //leadNuevo.leadDuplicadoAPI__c = true;
                    
                    Database.DMLOptions dml = new Database.DMLOptions();
                    dml.DuplicateRuleHeader.AllowSave = true;
                    Database.SaveResult sr = Database.insert(leadNuevo, dml);
                    if(sr.isSuccess()){
                        System.debug(' ** LEAD DUPLICADO CREADO ** ' + sr.getId());
                    }else{
                        log.ClassName__c = 'GoogleBotAPIV1';
                        log.date__c = Datetime.now();
                        log.message__c = 'Error al intentar procesar el prospecto. Error: ' + sr.getErrors();
                        log.success__c = false;
                        log.type__c = 'Procesamiento de peticion al ws';
                        log.JSON__c = jsonInput;
                        if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                            log.Empresa__c = 'Panamá';
                        }else{
                            log.Empresa__c = 'Colombia';
                        }
                        insert log;
                        
                        response.estado = 'Error';
                        response.descripcionError = 'Error al intentar procesar el prospecto. Error: ' + sr.getErrors();
                        response.codigoError = '';
                        return response;
                    }
                    //insert leadNuevo;
                }
                response.descripcionError = 'Registro procesado exitosamente.';
            }catch(Exception ex){
                log.ClassName__c = 'GoogleBotAPIv1';
                log.date__c = Datetime.now();
                log.message__c = 'Error al intentar procesar el prospecto. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                log.success__c = false;
                log.type__c = 'Procesamiento de peticion al ws';
                log.JSON__c = jsonInput;
                if(infoRequest.Record.pais == 'Panama' || infoRequest.Record.pais == null || infoRequest.Record.pais == ''){
                    log.Empresa__c = 'Panamá';
                }else{
                    log.Empresa__c = 'Colombia';
                }
                insert log;
                
                response.estado = 'Error';
                response.descripcionError = 'Error al intentar procesar el prospecto. Error: ' + ex.getMessage() + ', ' + ex.getCause() + ', linea ' + ex.getLineNumber() + ' del API.';
                response.codigoError = '';
            }
        }
        return response;
    }
    
    //Clase para manejar la informacion general...
    public class info{
        public classGeneral Record;
        //public Cliente Cliente;
        public Oportunidad Oportunidad;
        public List<Productos> Productos;
    } 
    
    //Clase para manejar la informacion de cada lead....
    public class classGeneral{
        public String nombre;
        public String segundoNombre;
        public String apellidos;
        public String origen;
        public String tipoVenta;
        public String tipoCredito;
        public String cuentaPersona;
        public String etapa;
        public String identificacion;
        public String correoElectronico;
        public String celular;
        public String telefonoFijo;
        public String whatsapp;
        public String ciudadResidencia;
        public String paisResidencia;
        public String latitudResidencia;
        public String longitudResidencia;
        public String calleResidencia;
        public String ciudadTrabajo;
        public String paisTrabajo;
        public String latitudTrabajo;
        public String longitudTrabajo;
        public String calleTrabajo;
        public Double cupoDisponible;
        public String productoInteres;
        public Integer cuantosContactosTenido;
        public String lineaLlamada;
        public Double cuotaDisponible;
        public String agencia;
        public String pais;
        public String empresa;
        public String tipoIdentificacion;
        public String viabilidad;
        public String estrategia;
        public String segmento;
        public String ocupacion;
        public Double ingresos;
        public String tipoReferencia;
        public String tipoRelacion;
        public Boolean ofertaEspecial;
        public String salida;
        public String lectData;
        public String descripcion;
        public String propietarioCliente; //Pendiente
        public String propiedad; //Pendiente
        public String telefonoTrabajo;
        public String tipo;
        public String anioInicio;
        public Date fechaNacimiento;
        public String departamento;
        public Boolean llamar;
        public String idCliente;
        public String tipoEnvioDocumentacion;
        public String sexo;
        public String estadoCivil;
        public String telefonoDomicilio;
        public String quieroQueLlamen;
        public String tieneCuentaActiva;
        public String tipoPagoUltimaCompraContado;
        public Boolean aceptoContactoWhatsapp;
        /**
* mod brayan
* **/
        public DateTime ultimaFechaIngreso;
        public String   tipoGestion;
        public String locale;
        public String tienda;
        public String nombreVendedor;
		public String gclid;
        
        
        public classGeneral(){
            this.nombre = null;
            this.segundoNombre = null;
            this.apellidos = null;
            this.origen = null;
            this.tipoVenta = null;
            this.tipoCredito = null;
            this.cuentaPersona = null;
            this.etapa = null;
            this.identificacion = null;
            this.correoElectronico = null;
            this.celular = null;
            this.telefonoFijo = null;
            this.whatsapp = null;
            this.ciudadResidencia = null;
            this.paisResidencia = null;
            this.latitudResidencia = null;
            this.longitudResidencia = null;
            this.calleResidencia = null;
            this.ciudadTrabajo = null;
            this.paisTrabajo = null;
            this.latitudTrabajo = null;
            this.longitudTrabajo = null;
            this.calleTrabajo = null;
            this.cupoDisponible = null;
            this.productoInteres = null;
            this.cuantosContactosTenido = null;
            this.lineaLlamada = null;
            this.cuotaDisponible = null;
            this.agencia = null;
            this.pais = null;
            this.empresa = null;
            this.tipoIdentificacion = null;
            this.viabilidad = null;
            this.estrategia = null;
            this.segmento = null;
            this.ocupacion = null;
            this.ingresos = null;
            this.tipoReferencia = null;
            this.tipoRelacion = null;
            this.ofertaEspecial = null;
            this.salida = null;
            this.lectData = null;
            this.descripcion = null;
            this.propietarioCliente = null; //Pendiente
            this.propiedad = null; //Pendiente
            this.telefonoTrabajo = null;
            this.tipo = null;
            this.anioInicio = null;
            this.fechaNacimiento = null;
            this.departamento = null;
            this.llamar = null;
            this.idCliente = null;
            this.tipoEnvioDocumentacion = null;
            this.sexo = null;
            this.estadoCivil = null;
            this.telefonoDomicilio = null;
            this.quieroQueLlamen = null;
            this.tieneCuentaActiva = null;
            this.tipoPagoUltimaCompraContado = null;
            this.aceptoContactoWhatsapp = null;
            /**
* mod brayan
* **/
            this.ultimaFechaIngreso = null;
            this.tipoGestion = null;
            this.locale = null;
            this.tienda = null;
            this.nombreVendedor = null;
            this.gclid = null;
        }
    }
    
    //Clase para manejar la informacion de cada oportunidad....
    public class Oportunidad{
        public String cliente;
        public String idCliente;
        public String etapa;
        public Double ventaTotal;
        public Double seguro;
        public Date fechaCierre;
        public String agenciaPedido;
        public String periodo;
        public Integer numeroOrdenPedido;
        public String idOP;
        public String tipoVenta;
        public String codigoVendedor;
        public String nombreVendedor;
        public Date emisionOrdenPedido;
        public Double cuotas;
        public String direccionDespacho;
        public String estadoOrdenPedido;
        public String idEstudio;
        public String etapaCredito;
        public Boolean existeInventario;
        public String cotizacionPedidoEnviada;
        public String completacionCredito;
        public String ordenPedidoAprobada;
        public Date fechaEntrega;
        public String pin;
        public String propuestaPago;
        public String pedidoFactura;
        public String cerrada;
        public String motivoPerdida;
        public String origen;
        public String tipoPago;
        public Date fechaFacturacion;
        public String tipoOportunidad;
        public Date fechaCompletacionCredito;
        public Date fechaAprobacion;
        public Date fechaCreacionOP;
        /**
* mod brayan
* **/
        public DateTime ultimaFechaIngreso;
        Public String tipoGestion;
        
        /**
* Mod Braya 5-08-2021
* */
        public Date ultimaFechaPrecalificacion;
        public String ejecutivoCredito;
        
        public Date listoFacturarFecha;
        public Boolean listoFacturar;
        public Date fechaDespacho;
        public Date citaEntrega;
        public Boolean opDeTercero;
        public String accionSugerida;
        public String canalAtencion;
        public String origenVenta;
        public String causalDesiste;
        public String etapaEntrega;
        
        public Oportunidad(){
            this.causalDesiste = null;
            this.etapaEntrega = null;
            this.canalAtencion = null;
            this.origenVenta = null;
            this.cliente = null;
            this.idCliente = null;
            this.etapa = null;
            this.agenciaPedido = null;
            this.periodo = null;
            this.numeroOrdenPedido = null;
            this.idOP = '';
            this.tipoVenta = null;
            this.codigoVendedor = null;
            this.nombreVendedor = null;
            this.direccionDespacho = null;
            this.estadoOrdenPedido = null;
            this.idEstudio = null;
            this.etapaCredito = null;
            this.existeInventario = false;
            this.cotizacionPedidoEnviada = null;
            this.completacionCredito = null;
            this.ordenPedidoAprobada = null;
            this.pin = null;
            this.propuestaPago = null;
            this.pedidoFactura = null;
            this.cerrada = null;
            this.motivoPerdida = null;
            this.origen = null;
            this.tipoPago = null;
            this.tipoOportunidad = null;
            /**
* mod brayan
* **/
            this.ultimaFechaIngreso = null;
            this.tipoGestion = null;
            /**
* Mod Braya 5-08-2021
* */
            this.ultimaFechaPrecalificacion = null;
            this.ejecutivoCredito = null;
            this.accionSugerida = null;
        }
    }
    
    //Clase para manejar la informacion de cada producto de oportunidad....
    public class Productos{
        public String idProducto;
        public String idOP;
        public String descripcionProducto;
        public Integer cantidad;
        public Double precioSinDescuento;
        public Double porcDCTO;
        public Double diasGarantia;
        public String aplicaCambio;
        public String obsequio;
        public Double valor;
        public String idDetalleOP;
        public Double valorDCTO;
        
        public Productos(){
            this.idProducto = null;
            this.idOP = null;
            this.descripcionProducto = null;
            this.cantidad = null;
            this.precioSinDescuento = null;
            this.porcDCTO = null;
            this.diasGarantia = null;
            this.aplicaCambio = null;
            this.obsequio = null;
            this.valor = null;
            this.idDetalleOP = null;
            this.valorDCTO = null;
        }
    }
    
    //Clase para manejar la informacion de respuesta del api
    global class classResponse{
        global String estado{get;set;}
        global String codigoError{get;set;}
        global String descripcionError{get;set;}
        
        global classResponse(){
            this.estado = 'Exitoso';
            this.codigoError = '';
            this.descripcionError = '';
        }
    }
}