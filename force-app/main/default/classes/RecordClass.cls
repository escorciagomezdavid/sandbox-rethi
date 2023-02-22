public class RecordClass {
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
    public String propietarioCliente;
    public String propiedad;
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
    public DateTime ultimaFechaIngreso;
    public String   tipoGestion;
    public String locale;
    public String tienda;
    public String nombreVendedor;
    public String gclid;
    public String idProspecto;
    public String canalAtencion;
    public String codigoVendedor;
    public Double porcentajeLead;
    public String rango;
    public String idInforme;
    public Date fechaConsulta;
    public DateTime ultimaFechaVisor;
    public String webSite;
    public String tipoCliente;
    
    public static  List<Account> getAccountIdentify(String identify, String empresa){
        
        List<Account> act = new List<Account>();
        act = [SELECT Id, FirstName, MiddleName, LastName, Whatsapp__c, CupoDisponible__c, ProductoDeInteres__c, CuantosContactosHaTenido__c, LineaDeLlamada__c, CuotaDisponible__c, TieneOfertaEspecial__c, Viabilidad__c, Estrategia__c, 
               Ingresos__c, Salida__c, LectData__c, PersonLeadSource, AccountSource, BillingCity, BillingCountry, BillingLatitude, BillingLongitude, BillingStreet, Description, Phone, PersonOtherPhone, ShippingCity, ShippingCountry, ShippingLatitude, 
               ShippingLongitude, ShippingStreet, AnioInicio__c, PersonBirthdate, PersonEmail, PersonHomePhone, PersonMobilePhone, Identificacion__c, Empresa__c, TipodeEnvioDocumentacion__c, TipodeIdentificacion__c, Sexo__c, 
               Estado_civil__c, Ocupacion__c, QuieroQueMeLlamen__c, Tienda__c, TieneCuentaActiva__c, Departamento__c, TipoDePagoUltimaCompraDeContado__c, SegmentoPanama__c, Acepto_Contacto_por_Whatsapp__c, IdCliente__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Tipo_Cliente__c
               FROM Account 
               WHERE Identificacion__c =: identify AND Empresa__c =: empresa];
        if(act.size() > 1){
            throw new CustomException('Numero de identificacion  ' + identify + ' se encuentra registrado Cantidad: ' + String.valueOf(act.size()));
        }
        
        return act;
    }
    
    public static List<Account> getAccountIdCliente(String IdCliente){
        /**
        * Si esto retorna 0 y no se tiene Oportunidad es porque es un Lead
        * **/
        List<Account> account = new List<Account>();
        account = [SELECT Id, FirstName, MiddleName, LastName, Whatsapp__c, CupoDisponible__c, ProductoDeInteres__c, CuantosContactosHaTenido__c, LineaDeLlamada__c, CuotaDisponible__c, TieneOfertaEspecial__c, Viabilidad__c, Estrategia__c, 
                   Ingresos__c, Salida__c, LectData__c, PersonLeadSource, AccountSource, BillingCity, BillingCountry, BillingLatitude, BillingLongitude, BillingStreet, Description, Phone, PersonOtherPhone, ShippingCity, ShippingCountry, ShippingLatitude, 
                   ShippingLongitude, ShippingStreet, AnioInicio__c, PersonBirthdate, PersonEmail, PersonHomePhone, PersonMobilePhone, Identificacion__c, Empresa__c, TipodeEnvioDocumentacion__c, TipodeIdentificacion__c, Sexo__c, 
                   Estado_civil__c, Ocupacion__c, QuieroQueMeLlamen__c, TieneCuentaActiva__c, Tienda__c, Departamento__c, TipoDePagoUltimaCompraDeContado__c, SegmentoPanama__c, Acepto_Contacto_por_Whatsapp__c, IdCliente__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Primer_Origen__c, Tipo_Cliente__c
                   FROM Account 
                   WHERE IdCliente__c =: IdCliente];
        if(account.size() > 1){
            throw new CustomException('Error al intentar crear/actualizar una cuenta. Existe duplicidad de cuentas con el idCliente: ' + IdCliente);
        }
        return account;
    }
    
    public static  List<Lead> getLeadIdentify(String identify, String empresa){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, MobilePhone, Whatsapp_Telfono__c, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status, Empresa__c, Email, Tipo_de__c, Viabilidad__c, Website FROM Lead WHERE Identificacin__c =: identify AND IsConverted =: false AND empresa__c =: empresa];
        return lead;
        
    }
    
    public static  List<Lead> getLeadWithId(String Id){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, MobilePhone, Whatsapp_Telfono__c, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status, Email, Tipo_de__c, Website FROM Lead WHERE Id =: Id];
        return lead;
        
    }
    public static  List<Account> getAccountWithId(String Id){
        List<Account> account = new List<Account>();
        account = [SELECT Id FROM Account WHERE Id =: Id];
        return account;
        
    }
    
    public static  List<Lead> getLeadIdCliente(String idCliente){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status FROM Lead WHERE IdCliente__c=: idCliente AND IsConverted =: false Limit 1];
        System.debug('Lead getLeadIdCliente');
        System.debug(lead);
        return lead;
        
    }
    
    public static  List<Lead> getLeadEmail(String email, String empresa){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, MobilePhone, Whatsapp_Telfono__c, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status, Email, Tipo_de__c, Viabilidad__c, Website FROM Lead WHERE Email =: email AND IsConverted =: false AND empresa__c =: empresa  Limit 1];
   
        return lead;
        
    }
    
    public static  List<Lead> getLeadEmailPhone(String email, String celular, String empresa){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status, Identificacin__c FROM Lead WHERE Email =: email AND IsConverted =: false AND empresa__c =: empresa AND MobilePhone =: celular  Limit 1];
   
        return lead;
        
    }
    
    public static  List<Lead> getLeadLastDate(String email, String celular, String empresa){
        List<Lead> lead = new List<Lead>();
        lead = [SELECT Id, ownerId, cancelarWorkFlow__c, Ultima_Fecha_Ingreso__c, LeadSource, Status, Identificacin__c FROM Lead WHERE Email =: email AND IsConverted =: false AND empresa__c =: empresa   ORDER BY Ultima_Fecha_Ingreso__c desc LIMIT 1];
   
        return lead;
        
    }
    
    public static  List<Account> getAccountEmailPhone(String email, String celular, String empresa){
        List<Account> account = new List<Account>();
        account = [SELECT Id, ownerId, Ultima_Fecha_Ingreso__c, Identificacion__c FROM Account WHERE PersonEmail =: email AND PersonMobilePhone =: celular AND empresa__c =: empresa  Limit 1];
   
        return account;
        
    }
    
    public  static Database.LeadConvertResult convertProcessor(MiddlewareClass middle){
        /**
        * Variables de Conversion de lead
        * 
        * **/
        LeadStatus convertStatus = new LeadStatus(); 
        Database.LeadConvert lc = new Database.LeadConvert();
        Database.DMLOptions dmlLead = new Database.DMLOptions();
        Database.LeadConvertResult lcr;
        /**
* -----------------------------------------------------------------------
* **/       
        List<Account> account = new List<Account>();
        List<Lead> lead = new List<Lead>();
        RecordClass record = new RecordClass();        
        record = middle.Record;
        List<Account> getAccount = getAccountIdCliente(String.valueOf(record.IdCliente));
        List<Lead> getLead = getLeadIdentify(String.valueOf(record.identificacion), String.valueOf(record.empresa));
        System.debug(' ** LISTA CUENTA PROCESO CONVERSION LEAD ** ' + getAccount.size());
        System.debug(' ** LISTA PROSPECTOS ** ' + getLead.size());
        
        if(!getAccount.isEmpty() && getAccount.size() > 1){
            throw new CustomException('Error al intentar convertir el prospecto, existe mas de una cuenta con identificación: ' + String.valueOf(record.identificacion));
        }
        else if(!getAccount.isEmpty() && getAccount.size() == 1 && !getLead.isEmpty() && getLead.size() == 1){
            try{
                System.debug(' ** CONVERSION DE LEAD A CUENTA EXISTENTE ** ');
                getLead[0].cancelarWorkFlow__c = true;
                getLead[0].Convertido__c = true;
                
                if(record.viabilidad != null && record.viabilidad != ''){
                    getLead[0].Viabilidad__c = record.viabilidad;
                }

                getLead[0].Email = validarEmail(
                    getLead[0].Email != null ? getLead[0].Email : '',
                    record.correoElectronico != null ? record.correoElectronico : ''
                );

                if(getLead[0].Tipo_de__c == null){
                    getLead[0].Tipo_de__c = record.tipoIdentificacion != null ? record.tipoIdentificacion : '';
                }
            
                if(getLead[0].MobilePhone == null) {
                    getLead[0].MobilePhone = '';
                }

                if(record.celular == null) {
                    record.celular = '';
                }

                if(getLead[0].Whatsapp_Telfono__c == null) {
                    getLead[0].Whatsapp_Telfono__c = '';
                }

                if(record.whatsapp == null) {
                    record.whatsapp = '';
                }

                if(getLead[0].Empresa__c == 'JP'){
                    getLead[0].Pas__c = 'Panama';
                    
                    getLead[0].MobilePhone = validarCelular(getLead[0].MobilePhone, 'JP', record.celular);
                    
                    getLead[0].Whatsapp_Telfono__c = validarWhatsapp(getLead[0].Whatsapp_Telfono__c, 'JP', record.whatsapp);
                }else{
                    getLead[0].Pas__c = 'Colombia';

                    getLead[0].MobilePhone = validarCelular(getLead[0].MobilePhone, 'JA', record.celular);
                    
                    getLead[0].Whatsapp_Telfono__c = validarWhatsapp(getLead[0].Whatsapp_Telfono__c, 'JA', record.whatsapp);
                }
                update getLead;
                
                lc.setLeadId(getLead[0].Id);
                lc.setConvertedStatus('Qualified');
                lc.setDoNotCreateOpportunity(true);
                lc.setAccountId(getAccount[0].Id);
                dmlLead.DuplicateRuleHeader.AllowSave = true;
                
                TriggerHandler.bypass('TriggerHandlerAccount');
                lcr = Database.convertLead(lc, dmlLead);
                TriggerHandler.clearBypass('TriggerHandlerAccount');
            }catch(Exception e){
                throw new CustomException('Error al intentar convertir el prospecto a cuenta Existente. Error: ' + e.getMessage() + ' Account.ID: '+ getAccount[0].Id +  ' Celular lead: ' + getLead[0].MobilePhone + ' Whatsapp lead: ' + getLead[0].Whatsapp_Telfono__c + ' Celular del record: ' + record.celular);
            }
        }else if(getAccount.isEmpty() && middle.Oportunidad != null || middle.Quote != null  && !getLead.isEmpty() && getLead.size() == 1){
            if( middle.Oportunidad != null || middle.Quote != null){
                System.debug('HOLAA');
                try{
                    System.debug(' ** CONVERSION DE LEAD A CUENTA NUEVA ** ');
                    System.debug(getLead[0]);
                    getLead[0].cancelarWorkFlow__c = true;
                    getLead[0].Convertido__c = true;

                    if(record.viabilidad != null && record.viabilidad != ''){
                        getLead[0].Viabilidad__c = record.viabilidad;
                    }

                    getLead[0].Email = validarEmail(
                        getLead[0].Email != null ? getLead[0].Email : '',
                        record.correoElectronico != null ? record.correoElectronico : ''
                    );

                    if(getLead[0].Tipo_de__c == null){
                        getLead[0].Tipo_de__c = record.tipoIdentificacion != null ? record.tipoIdentificacion : '';
                    }

                    if(getLead[0].MobilePhone == null) {
                        getLead[0].MobilePhone = '';
                    }

                    if(record.celular == null) {
                        record.celular = '';
                    }

                    if(getLead[0].Whatsapp_Telfono__c == null) {
                        getLead[0].Whatsapp_Telfono__c = '';
                    }
    
                    if(record.whatsapp == null) {
                        record.whatsapp = '';
                    }

                    if(getLead[0].Empresa__c == 'JP'){
                		getLead[0].Pas__c = 'Panama';

                        getLead[0].MobilePhone = validarCelular(getLead[0].MobilePhone, 'JP', record.celular);
                    
                        getLead[0].Whatsapp_Telfono__c = validarWhatsapp(getLead[0].Whatsapp_Telfono__c, 'JP', record.whatsapp);

                    }else{
                        getLead[0].Pas__c = 'Colombia';

                        getLead[0].MobilePhone = validarCelular(getLead[0].MobilePhone, 'JA', record.celular);
                    
                        getLead[0].Whatsapp_Telfono__c = validarWhatsapp(getLead[0].Whatsapp_Telfono__c, 'JA', record.whatsapp);
                    }
                    
                    update getLead;    
                    lc.setLeadId(getLead[0].Id);
                    System.debug('312 lc: ' + lc);
                    lc.setConvertedStatus('Qualified');
                    System.debug('314 lc: ' + lc);
                    lc.setDoNotCreateOpportunity(true);
                    System.debug('316 lc: ' + lc);
                    //lc.setAccountId(lstAct[0].Id);
                    dmlLead.DuplicateRuleHeader.AllowSave = true;
                    System.debug('319 lc: ' + lc);
                    TriggerHandler.bypass('TriggerHandlerAccount');
                    lcr = Database.convertLead(lc, dmlLead);
                    TriggerHandler.clearBypass('TriggerHandlerAccount'); 
                }catch(Exception e){
                    throw new CustomException('Error al intentar convertir el prospecto a cuenta nueva. Error: ' + e.getMessage() +  ' Celular lead' + getLead[0].MobilePhone + ' Whatsapp lead' + getLead[0].Whatsapp_Telfono__c + ' Celular del record: ' + record.celular);
                }
            }            
        }
        if(!lcr.isSuccess()){
            throw new CustomException('Error al intentar convertir el prospecto: ' + lcr.getErrors());
        }
        
        return lcr;
    }
    
    public static List<MessagingEndUser> getUserMessageService(MiddlewareClass middle){
        RecordClass record = new RecordClass();
        record = middle.Record;
        String condition = '%' + record.whatsapp + '%';
        Boolean updateUser = false;
        List<MessagingEndUser> listUserMessage = new List<MessagingEndUser>();
        listUserMessage = [SELECT Id, AccountId, Account.Name, MessagingPlatformKey FROM MessagingEndUser WHERE MessagingPlatformKey LIKE : condition FOR UPDATE];
        return listUserMessage;
    }
    
    public static Account createdNewAccount(MiddlewareClass middle){
        Account account = new Account();
        RecordClass record = new RecordClass();
        String leadRecordTypePanama = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
        String accountRecordTypePanama =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
        String leadRecordTypeColombia = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Colombia').getRecordTypeId();
        String accountRecordTypeColombia =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<MessagingEndUser> messageUser = getUserMessageService(middle);
        
       
        try{
            record = middle.Record;
            System.debug(' **Line 360 RecordClass CREAR UNA CUENTA NUEVA ** ');
        	account.Api_Name__c = 'APIV2';
            if(record.pais == 'Panama' || record.pais == null || record.pais == ''){
                account.RecordTypeId = accountRecordTypePanama;
            }else{
                account.RecordTypeId = accountRecordTypeColombia;
            }
            if(record.nombre != null){
                account.FirstName = record.nombre;
            }
            if(record.tienda != null){
                System.debug('TIENDA');
                System.debug(record.tienda);
                System.debug(mapAgencias);
                account.Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.nombreVendedor != null){
                account.Vendedor__c = record.nombreVendedor;
            }
            if(record.segundoNombre != null){
                account.MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null){
                account.LastName = record.apellidos;
            }
            if(record.whatsapp != null){
                account.Whatsapp__c = record.whatsapp;
            }
            if(record.cupoDisponible != null){
                account.CupoDisponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                account.ProductoDeInteres__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                account.CuantosContactosHaTenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                account.LineaDeLlamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                account.CuotaDisponible__c = record.cuotaDisponible;
            }
            if(record.ofertaEspecial != null){
                account.TieneOfertaEspecial__c = record.ofertaEspecial;
            }
            if(record.viabilidad != null){
                account.Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                account.Estrategia__c = record.estrategia;
            }
            if(record.ingresos != null){
                account.Ingresos__c = record.ingresos;
            }
            if(record.salida != null){
                account.Salida__c = record.salida;
            }
            if(record.lectData != null){
                account.LectData__c = record.lectData;
            }
            if(record.origen != null){
                account.PersonLeadSource = record.origen;
                account.Primer_Origen__c = record.origen;
            }
            if(record.ciudadResidencia != null){
                account.BillingCity = record.ciudadResidencia;
            }
            if(record.paisResidencia != null){
                account.BillingCountry = record.paisResidencia;
            }
            if(record.latitudResidencia != null){
                account.BillingLatitude = Double.valueOf(record.latitudResidencia);
            }
            if(record.longitudResidencia != null){
                account.BillingLongitude = Double.valueOf(record.longitudResidencia);
            }
            if(record.calleResidencia != null){
                account.BillingStreet = record.calleResidencia;
            }
            if(record.descripcion != null){
                account.Description = record.descripcion;
            }
            if(record.telefonoFijo != null){
                account.Phone = record.telefonoFijo;
            }
            if(record.telefonoTrabajo != null){
                account.PersonOtherPhone = record.telefonoTrabajo;
            }
            if(record.ciudadTrabajo != null){
                account.ShippingCity = record.ciudadTrabajo;
            }
            if(record.latitudTrabajo != null){
                account.ShippingLatitude = Double.valueOf(record.latitudTrabajo);
            }
            if(record.longitudTrabajo != null){
                account.ShippingLongitude = Double.valueOf(record.longitudTrabajo);
            }
            if(record.calleTrabajo != null){
                account.ShippingStreet = record.calleTrabajo;
            }
            if(record.anioInicio != null){
                account.AnioInicio__c = record.anioInicio;
            }
            if(record.fechaNacimiento != null){
                account.PersonBirthdate = record.fechaNacimiento;
            }
            if(record.correoElectronico != null){
                account.PersonEmail = record.correoElectronico;
            }
            if(record.identificacion != null){
                account.Identificacion__c = record.identificacion;
            }
            if(record.empresa != null){
                account.Empresa__c = record.empresa;
            }
            if(record.tipoEnvioDocumentacion != null){
                account.TipodeEnvioDocumentacion__c = record.tipoEnvioDocumentacion;
            }
            if(record.tipoIdentificacion != null){
                account.TipodeIdentificacion__c = record.tipoIdentificacion;
            }
            if(record.tipoCliente != null){
                account.Tipo_Cliente__c = record.tipoCliente;
            }
            if(record.sexo != null){
                account.Sexo__c = record.sexo;
            }
            if(record.estadoCivil != null){
                account.Estado_civil__c = record.estadoCivil;
            }
            if(record.ocupacion != null){
                account.Ocupacion__c = record.ocupacion;
            }
            if(record.quieroQueLlamen != null){
                account.QuieroQueMeLlamen__c = record.quieroQueLlamen;
            }
            if(record.tieneCuentaActiva != null){
                account.TieneCuentaActiva__c = record.tieneCuentaActiva;
            }
            if(record.idCliente != null){
                account.IdCliente__c = record.idCliente;
            }
            if(record.celular != null){
                account.PersonMobilePhone = record.celular;
            }
            if(record.departamento != null){
                account.Departamento__c = mapDepartamentos.get(record.departamento).Id;
            }
            if(record.tipoPagoUltimaCompraContado != null){
                account.TipoDePagoUltimaCompraDeContado__c = record.tipoPagoUltimaCompraContado;
            }
            if(record.segmento != null){
                account.SegmentoPanama__c = record.segmento;
            }
            if(record.aceptoContactoWhatsapp != null  && messageUser.size() == 0){
                account.Acepto_Contacto_por_Whatsapp__c = record.aceptoContactoWhatsapp;
            }else{
                account.Acepto_Contacto_por_Whatsapp__c = false;
            }
            if(record.gclid != null){
                account.GCLID__c = record.gclid;
            }
            
            account.Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(record.ultimaFechaVisor != null){
                account.Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            
            if(record.tipoGestion != null){
                account.Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.idProspecto != null){
                account.ID_Prospecto__c = record.idProspecto;
            }
            if(record.canalAtencion != null){
                account.Canal_de_Atencion__c = record.canalAtencion;
            }
            if(record.webSite != null && record.webSite != ''){
                account.Website = record.webSite.length() > 255 ? record.webSite.substring(0, 255) : record.webSite;
            }
            TriggerHandler.bypass('TriggerHandlerAccount');
            insert account;
            TriggerHandler.clearBypass('TriggerHandlerAccount');
        }
        catch(Exception e){
            throw new CustomException('Error al insertar la cuenta en la funcion createdNewAccount ' +  e.getMessage() + 'Line: ' + e.getLineNumber());
        }
        return Account;
    }
    
    public static Lead createdNewLead(MiddlewareClass middle){
        System.debug('createdNewLead');
        Lead lead = new Lead();
        RecordClass record = new RecordClass();
        String leadRecordTypePanama = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Panamá').getRecordTypeId();
        String leadRecordTypeColombia = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Person Account Colombia').getRecordTypeId();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        
        try{
            record = middle.Record;
            lead.Api_Name__c = 'APIV2';
            if(record.pais == 'Panama' || record.pais == null || record.pais == ''){
                lead.RecordTypeId = leadRecordTypePanama;
            }else{
                lead.RecordTypeId = leadRecordTypeColombia;
            }
            if(record.tienda != null){
                lead.Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            lead.FirstName = record.nombre;
            lead.Vendedor__c = record.nombreVendedor;
            lead.Codigo_Vendedor__c = record.codigoVendedor;
            lead.MiddleName = record.segundoNombre;
            lead.LastName = record.apellidos;
            lead.LeadSource = record.origen;
            lead.Tipo_de_Venta__c = record.tipoVenta;
            lead.Tipo_de_Crdito__c = record.tipoCredito;
            lead.Status = record.etapa;
            lead.Identificacin__c = record.identificacion;
            lead.IdCliente__c	 = record.idCliente;
            lead.Email = record.correoElectronico;
            lead.MobilePhone = record.celular;
            lead.Phone = record.telefonoFijo;
            lead.Whatsapp_Telfono__c = record.whatsapp;
            lead.City = record.ciudadResidencia;
            lead.Country = record.paisResidencia;
            lead.Latitud_de_Residencia__c = record.latitudResidencia;
            lead.Longitud_de_Residencia__c = record.longitudResidencia;
            lead.Street = record.calleResidencia;
            lead.Ciudad_de_Trabajo__c = record.ciudadTrabajo;
            lead.Pa_s_de_Trabajo__c = record.paisTrabajo;
            lead.Latitud_de_Trabajo__c = record.latitudTrabajo;
            lead.Longitud_de_Trabajo__c = record.longitudTrabajo;
            lead.Calle_de_Trabajo__c = record.calleTrabajo;
            lead.Cupo_Disponible__c = record.cupoDisponible;
            lead.Producto_de_inters__c = record.productoInteres;
            lead.Cuantos_contactos_ha_tenido__c = record.cuantosContactosTenido;
            lead.Lnea_de_llamada__c = record.lineaLlamada;
            lead.Cuota_Disponible__c = record.cuotaDisponible;
            if(record.agencia != null){
                lead.Agencia__c = mapAgencias.get(record.agencia).Id;
            }
            lead.Empresa__c = record.empresa;
            lead.Tipo_de__c = record.tipoIdentificacion;
            lead.Viabilidad__c = record.viabilidad;
            lead.Estrategia__c = record.estrategia;
            lead.Segmento__c = record.segmento;
            lead.Ocupacion__c = record.ocupacion;
            lead.Ingresos__c = record.ingresos;
            lead.Tipo_de_Referencia__c = record.tipoReferencia;
            lead.Tipo_de_relacion__c = record.tipoRelacion;
            lead.Tipo__c = record.cuentaPersona;
            lead.Quiero_que_me_llamen__c = record.quieroQueLlamen;
            lead.Pas__c = record.paisResidencia;
            lead.Salida__c = record.salida;
            lead.Description = record.descripcion;
            lead.Primer_Origen__c = record.origen;
            lead.Ultima_Fecha_Ingreso__c = DateTime.now();
            
            lead.Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
      
            lead.Tipo_de_Registro__c = record.tipoGestion;
            lead.GCLID__c = record.gclid;
            lead.Canal_de_Atencion__c = record.canalAtencion;
            if(record.locale != null){
                lead.et4ae5__Mobile_Country_Code__c = record.locale;
            }
            lead.Probabilidad_Lead__c = record.porcentajeLead;
            lead.Rango__c = record.rango;
            lead.Id_Informe__c = record.idInforme;
            lead.Fecha_Consulta__c = record.fechaConsulta;
            
            if(record.webSite != null && record.webSite != ''){
                lead.Website = record.webSite.length() > 255 ? record.webSite.substring(0, 255) : record.webSite;
            }

            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.AllowSave = true;
            Database.SaveResult sr = Database.insert(lead, dml);
            if(sr.isSuccess()){
                System.debug(' ** LEAD DUPLICADO CREADO ** ' + sr.getId());
            }
            System.debug(' ** LEAD DUPLICADO CREADO ** ' + sr.errors);
            // Esto es un nuevo comentario
            if(!sr.isSuccess()){
                 throw new CustomException('Error al insertar al insertar el lead ' +  sr.errors);
            }
        }
        catch(Exception e){
            throw new CustomException('Line: ' + e.getLineNumber() + '. Error al insertar el lead en la funcion createdNewLead ' +  e.getMessage());
        }
        return lead;
    }
    
    public static Lead updateLead(MiddlewareClass middle){
        System.debug('updateLead');
        RecordClass record =  new RecordClass();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<Lead> listLead = new List<Lead>();
      
        try{
            record = middle.Record;
            listLead = getLeadIdentify(record.identificacion, record.empresa);
            listLead[0].Api_Name__c = 'APIV2';
            if(record.nombre != null && record.nombre != ''){
                listLead[0].FirstName = record.nombre;
            }
            if(record.codigoVendedor != null && record.codigoVendedor != ''){
                listLead[0].Codigo_Vendedor__c = record.codigoVendedor;
            }
            if(record.tienda != null && record.tienda != ''){
                listLead[0].Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.nombreVendedor != null){
                listLead[0].Vendedor__c = record.nombreVendedor;
            }
            if(record.segundoNombre != null && record.segundoNombre != ''){
                listLead[0].MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null && record.apellidos != '' && record.apellidos != '-'){
                listLead[0].LastName = record.apellidos;
            }
            if(record.origen != null){
                listLead[0].LeadSource = record.origen;
            }
            if(record.tipoVenta != null){
                listLead[0].Tipo_de_Venta__c = record.tipoVenta;
            }
            if(record.tipoCredito != null){
                listLead[0].Tipo_de_Crdito__c = record.tipoCredito;
            }
            if(record.etapa != null){
                listLead[0].Status = record.etapa;
            }
            else if(listLead[0].Status == 'Unqualified'){
                listLead[0].Status = 'Nuevo';
            }
            if(record.identificacion != null){
                listLead[0].Identificacin__c = record.identificacion;
            }
            if(record.idCliente != null){
                listLead[0].IdCliente__c = record.idCliente;
            }
            if(record.correoElectronico != null && record.correoElectronico != ''){
                listLead[0].Email = record.correoElectronico;
            }
            if(record.celular != null && record.celular != ''){
                listLead[0].MobilePhone = record.celular;
            }
            if(record.telefonoFijo != null){
                listLead[0].Phone = record.telefonoFijo;
            }
            if(record.whatsapp != null){
                listLead[0].Whatsapp_Telfono__c = record.whatsapp;
            }
            if(record.latitudResidencia != null){
                listLead[0].Latitud_de_Residencia__c = record.latitudResidencia;
            }
            if(record.longitudResidencia != null){
                listLead[0].Longitud_de_Residencia__c = record.longitudResidencia;
            }
            if(record.calleResidencia != null){
                listLead[0].Street = record.calleResidencia;
            }
            if(record.ciudadTrabajo != null){
                listLead[0].Ciudad_de_Trabajo__c = record.ciudadTrabajo;
            }
            if(record.paisTrabajo != null){
                listLead[0].Pa_s_de_Trabajo__c = record.paisTrabajo;
            }
            if(record.latitudTrabajo != null){
                listLead[0].Latitud_de_Trabajo__c = record.latitudTrabajo;
            }
            if(record.longitudTrabajo != null){
                listLead[0].Longitud_de_Trabajo__c = record.longitudTrabajo;
            }
            if(record.calleTrabajo != null){
                listLead[0].Calle_de_Trabajo__c = record.calleTrabajo;
            }
            if(record.cupoDisponible != null){
                listLead[0].Cupo_Disponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                listLead[0].Producto_de_inters__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                listLead[0].Cuantos_contactos_ha_tenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                listLead[0].Lnea_de_llamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                listLead[0].Cuota_Disponible__c = record.cuotaDisponible;
            }
            if(record.agencia != null){
                listLead[0].Agencia__c = mapAgencias.get(record.agencia).Id;
            }
            if(record.empresa != null && record.empresa != ''){
                listLead[0].Empresa__c = record.empresa;
            }
            if(record.tipoIdentificacion != null){
                listLead[0].Tipo_de__c = record.tipoIdentificacion;
            }
            if(record.viabilidad != null){
                listLead[0].Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                listLead[0].Estrategia__c = record.estrategia;
            }
            if(record.segmento != null){
                listLead[0].Segmento__c = record.segmento;
            }
            if(record.ocupacion != null){
                listLead[0].Ocupacion__c = record.ocupacion;
            }
            if(record.ingresos != null){
                listLead[0].Ingresos__c = record.ingresos;
            }
            if(record.tipoReferencia != null){
                listLead[0].Tipo_de_Referencia__c = record.tipoReferencia;
            }
            if(record.tipoRelacion != null){
                listLead[0].Tipo_de_relacion__c = record.tipoRelacion;
            }
            if(record.cuentaPersona != null && record.cuentaPersona != ''){
                listLead[0].Tipo__c = record.cuentaPersona;
            }
            if(record.quieroQueLlamen != null){
                listLead[0].Quiero_que_me_llamen__c = record.quieroQueLlamen;
            }
            if(record.paisResidencia != null){
                listLead[0].Pas__c = record.paisResidencia;
            }
            if(record.salida != null){
                listLead[0].Salida__c = record.salida;
            }
            if(record.descripcion != null){
                listLead[0].Description = record.descripcion;
            }
            listLead[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(record.ultimaFechaVisor != null){
                listLead[0].Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            if(record.tipoGestion != null){
                listLead[0].Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.locale != null){
                listLead[0].et4ae5__Mobile_Country_Code__c = record.locale;
            }
            if(record.gclid != null){
                listLead[0].GCLID__c = record.gclid;
            }
            if(record.canalAtencion != null){
                listLead[0].Canal_de_Atencion__c = record.canalAtencion;
            }
            
            if(record.porcentajeLead != null){
                listLead[0].Probabilidad_Lead__c = record.porcentajeLead;
            }
            if(record.rango != null){
                listLead[0].Rango__c = record.rango;
            }
            if(record.idInforme != null){
                listLead[0].Id_Informe__c = record.idInforme;
            }
            if(record.fechaConsulta != null){
                listLead[0].Fecha_Consulta__c = record.fechaConsulta;
            }
            if(record.webSite != null && record.webSite != '' && ( listLead[0].Website == null || listLead[0].Website == '' )){
                listLead[0].Website = record.webSite.length() > 255 ? record.webSite.substring(0, 255) : record.webSite;
            }
            System.debug('listLead[0]');
            update listLead;
        }
        catch(Exception e){
            throw new CustomException('Line: ' + e.getLineNumber() + '. Error al modificar el lead en la funcion updateLead ' +  e.getMessage() + 'listLead: ' + listLead);
        }
        
        return listLead[0];
    }
    
    public static Lead updateLeadWithEmail(MiddlewareClass middle){
        System.debug('updateLeadWithEmail');
        RecordClass record =  new RecordClass();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<Lead> listLead = new List<Lead>();
        try{
            record = middle.Record;
            listLead = getLeadEmail(record.correoElectronico, record.empresa);
            listLead[0].Api_Name__c = 'APIV2';
            if(record.nombre != null && record.nombre != ''){
                listLead[0].FirstName = record.nombre;
            }
            if(record.codigoVendedor != null && record.codigoVendedor != ''){
                listLead[0].Codigo_Vendedor__c = record.codigoVendedor;
            }
            if(record.tienda != null && record.tienda != ''){
                listLead[0].Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.nombreVendedor != null){
                listLead[0].Vendedor__c = record.nombreVendedor;
            }
            if(record.segundoNombre != null && record.segundoNombre != ''){
                listLead[0].MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null && record.apellidos != '' && record.apellidos != '-'){
                listLead[0].LastName = record.apellidos;
            }
            if(record.origen != null){
                listLead[0].LeadSource = record.origen;
            }
            if(record.tipoVenta != null){
                listLead[0].Tipo_de_Venta__c = record.tipoVenta;
            }
            if(record.tipoCredito != null){
                listLead[0].Tipo_de_Crdito__c = record.tipoCredito;
            }
            if(record.etapa != null){
                if(listLead[0].Status == 'Unqualified'){
                    listLead[0].Status = 'Nuevo';
                }else{
                    listLead[0].Status = record.etapa;
                }
            }else if(listLead[0].Status == 'Unqualified'){
                listLead[0].Status = 'Nuevo';
            }
            if(record.identificacion != null){
                listLead[0].Identificacin__c = record.identificacion;
            }
            if(record.correoElectronico != null && record.correoElectronico != ''){
                listLead[0].Email = record.correoElectronico;
            }
            if(record.celular != null && record.celular != ''){
                listLead[0].MobilePhone = record.celular;
            }
            if(record.telefonoFijo != null){
                listLead[0].Phone = record.telefonoFijo;
            }
            if(record.whatsapp != null){
                listLead[0].Whatsapp_Telfono__c = record.whatsapp;
            }
            if(record.latitudResidencia != null){
                listLead[0].Latitud_de_Residencia__c = record.latitudResidencia;
            }
            if(record.longitudResidencia != null){
                listLead[0].Longitud_de_Residencia__c = record.longitudResidencia;
            }
            if(record.calleResidencia != null){
                listLead[0].Street = record.calleResidencia;
            }
            if(record.ciudadTrabajo != null){
                listLead[0].Ciudad_de_Trabajo__c = record.ciudadTrabajo;
            }
            if(record.paisTrabajo != null){
                listLead[0].Pa_s_de_Trabajo__c = record.paisTrabajo;
            }
            if(record.latitudTrabajo != null){
                listLead[0].Latitud_de_Trabajo__c = record.latitudTrabajo;
            }
            if(record.longitudTrabajo != null){
                listLead[0].Longitud_de_Trabajo__c = record.longitudTrabajo;
            }
            if(record.calleTrabajo != null){
                listLead[0].Calle_de_Trabajo__c = record.calleTrabajo;
            }
            if(record.cupoDisponible != null){
                listLead[0].Cupo_Disponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                listLead[0].Producto_de_inters__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                listLead[0].Cuantos_contactos_ha_tenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                listLead[0].Lnea_de_llamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                listLead[0].Cuota_Disponible__c = record.cuotaDisponible;
            }
            if(record.agencia != null){
                listLead[0].Agencia__c = mapAgencias.get(record.agencia).Id;
            }
            if(record.empresa != null && record.empresa != ''){
                listLead[0].Empresa__c = record.empresa;
            }
            if(record.tipoIdentificacion != null){
                listLead[0].Tipo_de__c = record.tipoIdentificacion;
            }
            if(record.viabilidad != null){
                listLead[0].Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                listLead[0].Estrategia__c = record.estrategia;
            }
            if(record.segmento != null){
                listLead[0].Segmento__c = record.segmento;
            }
            if(record.ocupacion != null){
                listLead[0].Ocupacion__c = record.ocupacion;
            }
            if(record.ingresos != null){
                listLead[0].Ingresos__c = record.ingresos;
            }
            if(record.tipoReferencia != null){
                listLead[0].Tipo_de_Referencia__c = record.tipoReferencia;
            }
            if(record.tipoRelacion != null){
                listLead[0].Tipo_de_relacion__c = record.tipoRelacion;
            }
            if(record.cuentaPersona != null && record.cuentaPersona != ''){
                listLead[0].Tipo__c = record.cuentaPersona;
            }
            if(record.quieroQueLlamen != null){
                listLead[0].Quiero_que_me_llamen__c = record.quieroQueLlamen;
            }
            if(record.paisResidencia != null){
                listLead[0].Pas__c = record.paisResidencia;
            }
            if(record.salida != null){
                listLead[0].Salida__c = record.salida;
            }
            if(record.descripcion != null){
                listLead[0].Description = record.descripcion;
            }
            listLead[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(record.ultimaFechaVisor != null){
                listLead[0].Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            if(record.tipoGestion != null){
                listLead[0].Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.locale != null){
                listLead[0].et4ae5__Mobile_Country_Code__c = record.locale;
            }
            if(record.gclid != null){
                listLead[0].GCLID__c = record.gclid;
            }
            if(record.canalAtencion != null){
                listLead[0].Canal_de_Atencion__c = record.canalAtencion;
            }
            
            if(record.porcentajeLead != null){
                listLead[0].Probabilidad_Lead__c = record.porcentajeLead;
            }
            if(record.rango != null){
                listLead[0].Rango__c = record.rango;
            }
            if(record.idInforme != null){
                listLead[0].Id_Informe__c = record.idInforme;
            }
            if(record.fechaConsulta != null){
                listLead[0].Fecha_Consulta__c = record.fechaConsulta;
            }
            if(record.webSite != null && record.webSite != '' && ( listLead[0].Website == null || listLead[0].Website == '' )){
                listLead[0].Website = record.webSite.length() > 255 ? record.webSite.substring(0, 255) : record.webSite;
            }
            update listLead[0];
        }
        catch(Exception e){
            throw new CustomException('Line: ' + e.getLineNumber() + '. Error al modificar el lead en la funcion updateLeadWithEmail ' +  e.getMessage());
        }
        return listLead[0];
    }
    
    public static Lead updateLeadWithId(MiddlewareClass middle, String id){
        System.debug('updateLeadWithId');
        RecordClass record =  new RecordClass();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<Lead> listLead = new List<Lead>();
        try{
            record = middle.Record;
            listLead = getLeadWithId(id);
            listLead[0].Api_Name__c = 'APIV2';
            if(record.nombre != null && record.nombre != ''){
                listLead[0].FirstName = record.nombre;
            }
            if(record.codigoVendedor != null && record.codigoVendedor != ''){
                listLead[0].Codigo_Vendedor__c = record.codigoVendedor;
            }
            if(record.tienda != null && record.tienda != ''){
                listLead[0].Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.nombreVendedor != null){
                listLead[0].Vendedor__c = record.nombreVendedor;
            }
            if(record.segundoNombre != null && record.segundoNombre != ''){
                listLead[0].MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null && record.apellidos != '' && record.apellidos != '-'){
                listLead[0].LastName = record.apellidos;
            }
            if(record.origen != null){
                listLead[0].LeadSource = record.origen;
            }
            if(record.tipoVenta != null){
                listLead[0].Tipo_de_Venta__c = record.tipoVenta;
            }
            if(record.tipoCredito != null){
                listLead[0].Tipo_de_Crdito__c = record.tipoCredito;
            }
            if(record.etapa != null){
                if(listLead[0].Status == 'Unqualified'){
                    listLead[0].Status = 'Nuevo';
                }else{
                    listLead[0].Status = record.etapa;
                }
            }else if(listLead[0].Status == 'Unqualified'){
                listLead[0].Status = 'Nuevo';
            }
            if(record.identificacion != null){
                listLead[0].Identificacin__c = record.identificacion;
            }
            if(record.correoElectronico != null && record.correoElectronico != ''){
                listLead[0].Email = record.correoElectronico;
            }
            if(record.celular != null && record.celular != ''){
                listLead[0].MobilePhone = record.celular;
            }
            if(record.telefonoFijo != null){
                listLead[0].Phone = record.telefonoFijo;
            }
            if(record.whatsapp != null){
                listLead[0].Whatsapp_Telfono__c = record.whatsapp;
            }
            if(record.latitudResidencia != null){
                listLead[0].Latitud_de_Residencia__c = record.latitudResidencia;
            }
            if(record.longitudResidencia != null){
                listLead[0].Longitud_de_Residencia__c = record.longitudResidencia;
            }
            if(record.calleResidencia != null){
                listLead[0].Street = record.calleResidencia;
            }
            if(record.ciudadTrabajo != null){
                listLead[0].Ciudad_de_Trabajo__c = record.ciudadTrabajo;
            }
            if(record.paisTrabajo != null){
                listLead[0].Pa_s_de_Trabajo__c = record.paisTrabajo;
            }
            if(record.latitudTrabajo != null){
                listLead[0].Latitud_de_Trabajo__c = record.latitudTrabajo;
            }
            if(record.longitudTrabajo != null){
                listLead[0].Longitud_de_Trabajo__c = record.longitudTrabajo;
            }
            if(record.calleTrabajo != null){
                listLead[0].Calle_de_Trabajo__c = record.calleTrabajo;
            }
            if(record.cupoDisponible != null){
                listLead[0].Cupo_Disponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                listLead[0].Producto_de_inters__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                listLead[0].Cuantos_contactos_ha_tenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                listLead[0].Lnea_de_llamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                listLead[0].Cuota_Disponible__c = record.cuotaDisponible;
            }
            if(record.agencia != null){
                listLead[0].Agencia__c = mapAgencias.get(record.agencia).Id;
            }
            if(record.empresa != null && record.empresa != ''){
                listLead[0].Empresa__c = record.empresa;
            }
            if(record.tipoIdentificacion != null){
                listLead[0].Tipo_de__c = record.tipoIdentificacion;
            }
            if(record.viabilidad != null){
                listLead[0].Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                listLead[0].Estrategia__c = record.estrategia;
            }
            if(record.segmento != null){
                listLead[0].Segmento__c = record.segmento;
            }
            if(record.ocupacion != null){
                listLead[0].Ocupacion__c = record.ocupacion;
            }
            if(record.ingresos != null){
                listLead[0].Ingresos__c = record.ingresos;
            }
            if(record.tipoReferencia != null){
                listLead[0].Tipo_de_Referencia__c = record.tipoReferencia;
            }
            if(record.tipoRelacion != null){
                listLead[0].Tipo_de_relacion__c = record.tipoRelacion;
            }
            if(record.cuentaPersona != null && record.cuentaPersona != ''){
                listLead[0].Tipo__c = record.cuentaPersona;
            }
            if(record.quieroQueLlamen != null){
                listLead[0].Quiero_que_me_llamen__c = record.quieroQueLlamen;
            }
            if(record.paisResidencia != null){
                listLead[0].Pas__c = record.paisResidencia;
            }
            if(record.salida != null){
                listLead[0].Salida__c = record.salida;
            }
            if(record.descripcion != null){
                listLead[0].Description = record.descripcion;
            }
            listLead[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            if(record.ultimaFechaVisor != null){
                listLead[0].Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            if(record.tipoGestion != null){
                listLead[0].Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.locale != null){
                listLead[0].et4ae5__Mobile_Country_Code__c = record.locale;
            }
            if(record.gclid != null){
                listLead[0].GCLID__c = record.gclid;
            }
            if(record.canalAtencion != null){
                listLead[0].Canal_de_Atencion__c = record.canalAtencion;
            }
            
            if(record.porcentajeLead != null){
                listLead[0].Probabilidad_Lead__c = record.porcentajeLead;
            }
            if(record.rango != null){
                listLead[0].Rango__c = record.rango;
            }
            if(record.idInforme != null){
                listLead[0].Id_Informe__c = record.idInforme;
            }
            if(record.fechaConsulta != null){
                listLead[0].Fecha_Consulta__c = record.fechaConsulta;
            }
            if(record.webSite != null && record.webSite != '' && ( listLead[0].Website == null || listLead[0].Website == '' )){
                listLead[0].Website = record.webSite.length() > 255 ? record.webSite.substring(0, 255) : record.webSite;
            }
            update listLead[0];
        }
        catch(Exception e){
            throw new CustomException('Line: ' + e.getLineNumber() + '. Error al modificar el lead en la funcion updateLeadWithEmail ' +  e.getMessage());
        }
        return listLead[0];
    }
    
    public static Account updateAccount(MiddlewareClass middle){
        Account account = new Account();
        RecordClass record =  new RecordClass();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<MessagingEndUser> messageUser = getUserMessageService(middle);
        List<Account> listAccount = new List<Account>();
        try{
            record = middle.Record;
            listAccount = getAccountIdCliente(record.idCliente);
            System.debug('Lista de Cuentas');
            System.debug(listAccount);
            listAccount[0].Api_Name__c = 'APIV2';
            if(record.nombre != null && record.nombre != ''){
                listAccount[0].FirstName = record.nombre;
            }
            if(record.nombreVendedor != null){
                listAccount[0].Vendedor__c = record.nombreVendedor;
            }
            if(record.tienda != null){
                listAccount[0].Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.segundoNombre != null && record.segundoNombre != '' && record.segundoNombre != '-'){
                listAccount[0].MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null && record.apellidos != ''  && record.apellidos != '-'){
                listAccount[0].LastName = record.apellidos;
            }
            if(record.whatsapp != null){
                listAccount[0].Whatsapp__c = record.whatsapp;
            }
            if(record.cupoDisponible != null){
                listAccount[0].CupoDisponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                listAccount[0].ProductoDeInteres__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                listAccount[0].CuantosContactosHaTenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                listAccount[0].LineaDeLlamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                listAccount[0].CuotaDisponible__c = record.cuotaDisponible;
            }
            if(record.ofertaEspecial != null){
                listAccount[0].TieneOfertaEspecial__c = record.ofertaEspecial;
            }
            if(record.viabilidad != null){
                listAccount[0].Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                listAccount[0].Estrategia__c = record.estrategia;
            }
            if(record.ingresos != null){
                listAccount[0].Ingresos__c = record.ingresos;
            }
            if(record.salida != null){
                listAccount[0].Salida__c = record.salida;
            }
            if(record.lectData != null){
                listAccount[0].LectData__c = record.lectData;
            }
            if(record.origen != null){
                listAccount[0].PersonLeadSource = record.origen;
                listAccount[0].Primer_Origen__c = record.origen;
            }
            if(record.ciudadResidencia != null){
                listAccount[0].BillingCity = record.ciudadResidencia;
            }
            if(record.paisResidencia != null){
                listAccount[0].BillingCountry = record.paisResidencia;
            }
            if(record.latitudResidencia != null){
                listAccount[0].BillingLatitude = Double.valueOf(record.latitudResidencia);
            }
            if(record.longitudResidencia != null){
                listAccount[0].BillingLongitude = Double.valueOf(record.longitudResidencia);
            }
            if(record.calleResidencia != null){
                listAccount[0].BillingStreet = record.calleResidencia;
            }
            if(record.descripcion != null){
                listAccount[0].Description = record.descripcion;
            }
            if(record.telefonoFijo != null){
                listAccount[0].Phone = record.telefonoFijo;
            }
            if(record.telefonoTrabajo != null){
                listAccount[0].PersonOtherPhone = record.telefonoTrabajo;
            }
            if(record.ciudadTrabajo != null){
                listAccount[0].ShippingCity = record.ciudadTrabajo;
            }
            if(record.latitudTrabajo != null){
                listAccount[0].ShippingLatitude = Double.valueOf(record.latitudTrabajo);
            }
            if(record.longitudTrabajo != null){
                listAccount[0].ShippingLongitude = Double.valueOf(record.longitudTrabajo);
            }
            if(record.calleTrabajo != null){
                listAccount[0].ShippingStreet = record.calleTrabajo;
            }
            if(record.anioInicio != null){
                listAccount[0].AnioInicio__c = record.anioInicio;
            }
            if(record.fechaNacimiento != null){
                listAccount[0].PersonBirthdate = record.fechaNacimiento;
            }
            if(record.correoElectronico != null){
                listAccount[0].PersonEmail = record.correoElectronico;
            }
            if(record.identificacion != null){
                listAccount[0].Identificacion__c = record.identificacion;
            }
            if(record.empresa != null){
                listAccount[0].Empresa__c = record.empresa;
            }
            if(record.tipoEnvioDocumentacion != null){
                listAccount[0].TipodeEnvioDocumentacion__c = record.tipoEnvioDocumentacion;
            }
            if(record.tipoIdentificacion != null){
                listAccount[0].TipodeIdentificacion__c = record.tipoIdentificacion;
            }
            if(record.tipoCliente != null){
                listAccount[0].Tipo_Cliente__c = record.tipoCliente;
            }
            if(record.sexo != null){
                listAccount[0].Sexo__c = record.sexo;
            }
            if(record.estadoCivil != null){
                listAccount[0].Estado_civil__c = record.estadoCivil;
            }
            if(record.ocupacion != null){
                listAccount[0].Ocupacion__c = record.ocupacion;
            }
            if(record.quieroQueLlamen != null){
                listAccount[0].QuieroQueMeLlamen__c = record.quieroQueLlamen;
            }
            if(record.tieneCuentaActiva != null){
                listAccount[0].TieneCuentaActiva__c = record.tieneCuentaActiva;
            }
            if(record.idCliente != null){
                listAccount[0].IdCliente__c = record.idCliente;
            }
            if(record.celular != null){
                listAccount[0].PersonMobilePhone = record.celular;
            }
            if(record.departamento != null){
                listAccount[0].Departamento__c = mapDepartamentos.get(record.departamento).Id;
            }
            if(record.tipoPagoUltimaCompraContado != null){
                listAccount[0].TipoDePagoUltimaCompraDeContado__c = record.tipoPagoUltimaCompraContado;
            }
            if(record.segmento != null){
                listAccount[0].SegmentoPanama__c = record.segmento;
            }
            if(record.aceptoContactoWhatsapp != null  && messageUser.size() == 0){
                listAccount[0].Acepto_Contacto_por_Whatsapp__c = record.aceptoContactoWhatsapp;
            }else{
                listAccount[0].Acepto_Contacto_por_Whatsapp__c = false;
            }
            if(record.gclid != null){
                listAccount[0].GCLID__c = record.gclid;
            }
            
            listAccount[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            if(record.ultimaFechaVisor != null){
                listAccount[0].Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            
            if(record.tipoGestion != null){
                listAccount[0].Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.idProspecto != null){
                listAccount[0].ID_Prospecto__c = record.idProspecto;
            }
            if(record.canalAtencion != null){
                listAccount[0].Canal_de_Atencion__c = record.canalAtencion;
            }
            TriggerHandler.bypass('TriggerHandlerAccount');
            update listAccount[0];
            TriggerHandler.clearBypass('TriggerHandlerAccount');
        }
        catch(Exception e){
            throw new CustomException('Error al modificar el account en la funcion updateAccount ' +  e.getMessage());
        }  
        return listAccount[0];
    }
    
    public static Account updateAccountWithIdCliente(MiddlewareClass middle, String id){
        Account account = new Account();
        RecordClass record =  new RecordClass();
        Map<String, Agencia__c> mapAgencias = getAgencias();
        Map<String, Departamento__c> mapDepartamentos = getDepartmento();
        List<MessagingEndUser> messageUser = getUserMessageService(middle);
        List<Account> listAccount = new List<Account>();
        
        try{
            record = middle.Record;
            listAccount = getAccountWithId(id);
            System.debug('Lista de Cuentas');
            System.debug(listAccount);
            listAccount[0].Api_Name__c = 'APIV2';
            if(record.nombre != null && record.nombre != ''){
                listAccount[0].FirstName = record.nombre;
            }
            if(record.nombreVendedor != null){
                listAccount[0].Vendedor__c = record.nombreVendedor;
            }
            if(record.tienda != null){
                listAccount[0].Tienda__c = mapAgencias.get(record.tienda).Id;
            }
            if(record.segundoNombre != null && record.segundoNombre != '' && record.segundoNombre != '-'){
                listAccount[0].MiddleName = record.segundoNombre;
            }
            if(record.apellidos != null && record.apellidos != ''  && record.apellidos != '-'){
                listAccount[0].LastName = record.apellidos;
            }
            if(record.whatsapp != null){
                listAccount[0].Whatsapp__c = record.whatsapp;
            }
            if(record.cupoDisponible != null){
                listAccount[0].CupoDisponible__c = record.cupoDisponible;
            }
            if(record.productoInteres != null){
                listAccount[0].ProductoDeInteres__c = record.productoInteres;
            }
            if(record.cuantosContactosTenido != null){
                listAccount[0].CuantosContactosHaTenido__c = record.cuantosContactosTenido;
            }
            if(record.lineaLlamada != null){
                listAccount[0].LineaDeLlamada__c = record.lineaLlamada;
            }
            if(record.cuotaDisponible != null){
                listAccount[0].CuotaDisponible__c = record.cuotaDisponible;
            }
            if(record.ofertaEspecial != null){
                listAccount[0].TieneOfertaEspecial__c = record.ofertaEspecial;
            }
            if(record.viabilidad != null){
                listAccount[0].Viabilidad__c = record.viabilidad;
            }
            if(record.estrategia != null){
                listAccount[0].Estrategia__c = record.estrategia;
            }
            if(record.ingresos != null){
                listAccount[0].Ingresos__c = record.ingresos;
            }
            if(record.salida != null){
                listAccount[0].Salida__c = record.salida;
            }
            if(record.lectData != null){
                listAccount[0].LectData__c = record.lectData;
            }
            if(record.origen != null){
                listAccount[0].PersonLeadSource = record.origen;
                listAccount[0].Primer_Origen__c = record.origen;
            }
            if(record.ciudadResidencia != null){
                listAccount[0].BillingCity = record.ciudadResidencia;
            }
            if(record.paisResidencia != null){
                listAccount[0].BillingCountry = record.paisResidencia;
            }
            if(record.latitudResidencia != null){
                listAccount[0].BillingLatitude = Double.valueOf(record.latitudResidencia);
            }
            if(record.longitudResidencia != null){
                listAccount[0].BillingLongitude = Double.valueOf(record.longitudResidencia);
            }
            if(record.calleResidencia != null){
                listAccount[0].BillingStreet = record.calleResidencia;
            }
            if(record.descripcion != null){
                listAccount[0].Description = record.descripcion;
            }
            if(record.telefonoFijo != null){
                listAccount[0].Phone = record.telefonoFijo;
            }
            if(record.telefonoTrabajo != null){
                listAccount[0].PersonOtherPhone = record.telefonoTrabajo;
            }
            if(record.ciudadTrabajo != null){
                listAccount[0].ShippingCity = record.ciudadTrabajo;
            }
            if(record.latitudTrabajo != null){
                listAccount[0].ShippingLatitude = Double.valueOf(record.latitudTrabajo);
            }
            if(record.longitudTrabajo != null){
                listAccount[0].ShippingLongitude = Double.valueOf(record.longitudTrabajo);
            }
            if(record.calleTrabajo != null){
                listAccount[0].ShippingStreet = record.calleTrabajo;
            }
            if(record.anioInicio != null){
                listAccount[0].AnioInicio__c = record.anioInicio;
            }
            if(record.fechaNacimiento != null){
                listAccount[0].PersonBirthdate = record.fechaNacimiento;
            }
            if(record.correoElectronico != null){
                listAccount[0].PersonEmail = record.correoElectronico;
            }
            if(record.identificacion != null){
                listAccount[0].Identificacion__c = record.identificacion;
            }
            if(record.empresa != null){
                listAccount[0].Empresa__c = record.empresa;
            }
            if(record.tipoEnvioDocumentacion != null){
                listAccount[0].TipodeEnvioDocumentacion__c = record.tipoEnvioDocumentacion;
            }
            if(record.tipoIdentificacion != null){
                listAccount[0].TipodeIdentificacion__c = record.tipoIdentificacion;
            }
            if(record.tipoCliente != null){
                listAccount[0].Tipo_Cliente__c = record.tipoCliente;
            }
            if(record.sexo != null){
                listAccount[0].Sexo__c = record.sexo;
            }
            if(record.estadoCivil != null){
                listAccount[0].Estado_civil__c = record.estadoCivil;
            }
            if(record.ocupacion != null){
                listAccount[0].Ocupacion__c = record.ocupacion;
            }
            if(record.quieroQueLlamen != null){
                listAccount[0].QuieroQueMeLlamen__c = record.quieroQueLlamen;
            }
            if(record.tieneCuentaActiva != null){
                listAccount[0].TieneCuentaActiva__c = record.tieneCuentaActiva;
            }
            if(record.idCliente != null){
                listAccount[0].IdCliente__c = record.idCliente;
            }
            if(record.celular != null){
                listAccount[0].PersonMobilePhone = record.celular;
            }
            if(record.departamento != null){
                listAccount[0].Departamento__c = mapDepartamentos.get(record.departamento).Id;
            }
            if(record.tipoPagoUltimaCompraContado != null){
                listAccount[0].TipoDePagoUltimaCompraDeContado__c = record.tipoPagoUltimaCompraContado;
            }
            if(record.segmento != null){
                listAccount[0].SegmentoPanama__c = record.segmento;
            }
            if(record.aceptoContactoWhatsapp != null  && messageUser.size() == 0){
                listAccount[0].Acepto_Contacto_por_Whatsapp__c = record.aceptoContactoWhatsapp;
            }else{
                listAccount[0].Acepto_Contacto_por_Whatsapp__c = false;
            }
            if(record.gclid != null){
                listAccount[0].GCLID__c = record.gclid;
            }
            
            listAccount[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            if(record.ultimaFechaVisor != null){
                listAccount[0].Ultima_Fecha_Visor__c = record.ultimaFechaVisor;
            }
            
            if(record.tipoGestion != null){
                listAccount[0].Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.idProspecto != null){
                listAccount[0].ID_Prospecto__c = record.idProspecto;
            }
            if(record.canalAtencion != null){
                listAccount[0].Canal_de_Atencion__c = record.canalAtencion;
            }
            
            TriggerHandler.bypass('TriggerHandlerAccount');
            update listAccount[0];
            TriggerHandler.clearBypass('TriggerHandlerAccount');
        }catch(Exception e){
            throw new CustomException('Error al modificar el account en la funcion updateAccount ' +  e.getMessage());
        }
        
        
        return listAccount[0];
    }
    
    public static Map<String, Agencia__c> getAgencias(){
        Map<String, Agencia__c> mapAgencias = new Map<String, Agencia__c>();
        //Se obtienen todas las agencias disponibles...
        for(Agencia__c c : [SELECT IdAgencia__c, Id FROM Agencia__c]){
            System.debug('Dentro del For');
            System.debug(c.IdAgencia__c);
            mapAgencias.put(c.IdAgencia__c, c);
        }
        System.debug('Dentro de Fncion');
        System.debug(mapAgencias);
        return mapAgencias;
        
    }
    
    public static Map<String, Departamento__c> getDepartmento(){
        Map<String, Departamento__c> mapDepartamentos = new Map<String, Departamento__c>();
        //Se obtienen todos los departamentos disponibles...
        for(Departamento__c dep : [SELECT Name, Id FROM Departamento__c]){
            mapDepartamentos.put(dep.Name, dep);
        }
        return mapDepartamentos;
        
    }

    private static boolean isValidPhone(String phone, String empresa) {
        if(empresa == 'JP'){
            return phone.startsWith('507');
        }
        return phone.startsWith('57');
    }
    
    private static boolean isValidWhatsapp(String phone, String empresa) {
        if(empresa == 'JP'){
            return phone.startsWith('+507');
        }
        return phone.startsWith('+57');
    }

    private static String validarCelular(String celularLead, String empresa, String celularRecord){
        
        String celularOut = '';
        
            
        Boolean isCelularValidoLead = isValidPhone(celularLead, empresa);
        Boolean isCelularValidoRecord = isvalidPhone(celularRecord, empresa);

        if (isCelularValidoLead && !isCelularValidoRecord) {
            return celularOut = celularLead;
        }
        
        return celularOut = isCelularValidoRecord ? String.valueOf(celularRecord) : '';
    }
    
    private static String validarWhatsapp(String WhatsappLead, String empresa, String WhatsappRecord){
            
        String whatsappOut = '';
        
            
        Boolean isWhatsappValidoLead = isValidWhatsapp(WhatsappLead, empresa);
        Boolean isWhatsappValidoRecord = isValidWhatsapp(WhatsappRecord, empresa);

        if (isWhatsappValidoLead && !isWhatsappValidoRecord) {
            return whatsappOut = WhatsappLead;
        } 
        
        return whatsappOut = isWhatsappValidoRecord ? String.valueOf(WhatsappRecord) : '';
    }

    private static String validarEmail(String emailLead, String emailRecord){
        
        String emailOut = '';
        
        Boolean isEmailValidoLead = emailLead.toLowerCase().endsWith('con') ? false : true;
        Boolean isEmailValidoRecord = emailRecord.toLowerCase().endsWith('con') ? false : true;

        if (isEmailValidoLead && !isEmailValidoRecord) {
            return emailOut = emailLead;
        }
        
        return emailOut = isEmailValidoRecord ? emailRecord : '';
    }
    
}