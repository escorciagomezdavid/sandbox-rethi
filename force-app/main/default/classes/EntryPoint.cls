@RestResource(UrlMapping='/v2/googleBootAPI/')
global class EntryPoint {
    @HttpPost
    global static ResponseClass entryPointAccess(){ 
        MiddlewareClass middleware = new MiddlewareClass();
        RecordClass record = new RecordClass();
        ResponseClass responseApi = new ResponseClass();
        Log__c log = new Log__c();
        List<String> setOrigenes = new List<String>();
        List<Account> account = new List<Account>();
        Account accountNew = new Account();
        List<Opportunity>opportunityWithOutIdOp = new List<Opportunity>();
        RestRequest requestBody = RestContext.request;
        Boolean existeCuenta = false;
        Boolean existeLead 	 = false;
        String jsonInput = '';
        Boolean jsonConOp	 = false;
        Boolean jsonConProducto = false;
        Boolean opportunityConIdOp = false;
        Boolean opportunitySinIdOp = false;
        Boolean jsonConQuote = false;
        Boolean jsonConProductQuote = false;
        Boolean existeQuote = false;
        Boolean leadConvertido = false;
        Boolean opAntigua = false;
        Boolean tieneIdCotizacion = false;
        Database.LeadConvertResult lcr;
        
        
        
        try{
            /**
            * Validaciones Generales
            * Empresa, Correo sea valido si viene correo, origenes, apeelido
            * 1. Validaciones Generales
            * 2. Cotizacion
            * 3. Objeto Log
            * **/
            if(requestBody == null){
               throw new CustomException('Error al intentar procesar la solicitud Body Null. ');
        	}
            jsonInput = requestBody.requestBody.toString();
            try{ 
                middleware = (MiddlewareClass)JSON.deserialize(jsonInput, MiddlewareClass.class);
               }catch(Exception e){
                    throw new CustomException('Error al intentar procesar la solicitud Body Null. ' + e.getMessage());
               }
            if(middleware.Record.correoElectronico != null && middleware.Record.origen != null && middleware.Record.correoElectronico != '' && middleware.Record.origen != ''){
                UtilitiesClass.validations(middleware);
            }
            
            if(middleware.Record.identificacion != null && middleware.Record.identificacion != '' ){
                System.debug('Validacion de Identidad OK');
                System.debug(middleware.Record.identificacion);
                List<Account> cuentasExistentes = RecordClass.getAccountIdCliente(middleware.Record.idCliente);
                System.debug('Validacion de Cuentas');
                System.debug(cuentasExistentes);
                if(cuentasExistentes.size() >= 1){
                    System.debug('Validacion de Cuentas es = 1');
                    System.debug('Existe Cuenta');
                    existeCuenta = True;
                }
                List<Lead> leadExistentes = RecordClass.getLeadIdCliente(middleware.Record.idCliente);
                System.debug('Validacion de Lead');
                if(leadExistentes.size() >= 1){
                    System.debug('Existe Lead');
                    existeLead = True;
                }
                if(middleware.Oportunidad != null){
                     System.debug('Json Con Opportuidad');
                    jsonConOp = True;
                }
                if(middleware.Productos != null){
                    System.debug('Json Con Productos de Opportunidad');
                    jsonConProducto = True;
                }
                if(middleware.Quote != null){
                    System.debug('Json Con Cotizacion');
                    jsonConQuote = True;
                }
                if(middleware.ProductosQuote != null){
                    System.debug('Json Con Productos de Cotizacion');
                    jsonConProductQuote = True;
                }
                if(existeLead && existeCuenta || existeLead && jsonConOp || existeLead && jsonConQuote ){
                     System.debug('Entro Proceso de Conversion');
                    /**
                    * Proceso de conversion
                    * **/
                    lcr = RecordClass.convertProcessor(middleware);
                    if(lcr.isSuccess()){
                         System.debug('Lead Convertido');
                        leadConvertido = True;
                    }
                }
                else if (existeCuenta){
                    /**
                    * Proceso de Actualizacion Cuenta
                    * **/
                    System.debug('Proceso de Actualizacion Cuenta');
                    RecordClass.updateAccount(middleware);
                }
                /**
                else if(jsonConOp || jsonConQuote && existeCuenta == false && leadConvertido == false) {
   
                    System.debug('Proceso de Creacion Cuenta');
                   accountNew =  RecordClass.createdNewAccount(middleware);
                }
				**/
                else if(existeLead){
                    /**
                    * Proceso de Actualizacion del lead
                    * **/
                    System.debug('Proceso de Actualizacion Lead');
                    RecordClass.updateLead(middleware);
                }
                else {
                    /**
                    * Proceso de Creacion del lead
                    * **/
                     //System.debug('Proceso de Creacion Lead');
                    //RecordClass.createdNewLead(middleware);
                    List<Lead> leadWithEmailAndPhone = new List<Lead>();
               		List<Account> accountWithEmailAndPhone = new List<Account>();
                	if(middleware.Record.correoElectronico != null && middleware.Record.correoElectronico != '' && middleware.Record.celular != null && middleware.Record.celular != '' ){
               
                    		accountWithEmailAndPhone = RecordClass.getAccountEmailPhone(middleware.Record.correoElectronico, middleware.Record.celular, middleware.Record.empresa);
                    		leadWithEmailAndPhone = RecordClass.getLeadEmailPhone(middleware.Record.correoElectronico, middleware.Record.celular, middleware.Record.empresa);
							System.debug('accountWithEmailAndPhone ---------------------');
                        	System.debug(accountWithEmailAndPhone);
                            if(accountWithEmailAndPhone.size() >= 1 && jsonConQuote == false && jsonConOp == false){
                                
                                if(accountWithEmailAndPhone[0].Identificacion__c != null)
                                {
                                    if(accountWithEmailAndPhone[0].Identificacion__c != middleware.Record.identificacion){
                                        	RecordClass.createdNewLead(middleware);
                                    } 
                                    /** Validar Con Jose todos los casos de uso
                                    else{
                                        
                                        List<Opportunity> opportinityOpen = OpportunityClass.getOpportunityOtherStage(accountWithEmailAndPhone[0]);
                                        System.debug('opportinityOpen ----------------------');
                                        System.debug(opportinityOpen.size());
                                        
                                        if(opportinityOpen.size() == 1){
                                                OpportunityClass.updateOpportunityWithId(opportinityOpen[0].id, middleware);
                                            	RecordClass.updateAccount(middleware);
                                        }else if (opportinityOpen.size() >= 2){
                                            List<Opportunity> opportinityOpenMore = OpportunityClass.getOpportunityLastDate(accountWithEmailAndPhone[0]);
                                            OpportunityClass.updateOpportunityWithId(opportinityOpenMore[0].id, middleware);
                                            RecordClass.updateAccount(middleware);
                                        }
                                        else{
                                              OpportunityClass.createdOpportunityOtherStage(accountWithEmailAndPhone[0], middleware, leadConvertido, 'Contactado');
                                              RecordClass.updateAccount(middleware);
                                        }
                                        //RecordClass.updateAccount(middleware);
                                    }
									**/
                                }
                                /** Validar Con Jose todos los casos de uso
                                else{
                                    	List<Opportunity> opportinityOpen = OpportunityClass.getOpportunityOtherStage(accountWithEmailAndPhone[0]);
                                        System.debug('opportinityOpen ----------------------');
                                        System.debug(opportinityOpen.size());
                                        
                                        if(opportinityOpen.size() == 1){
                                                OpportunityClass.updateOpportunityWithId(opportinityOpen[0].id, middleware);
                                            	RecordClass.updateAccount(middleware);
                                        }else if (opportinityOpen.size() >= 2){
                                            List<Opportunity> opportinityOpenMore = OpportunityClass.getOpportunityLastDate(accountWithEmailAndPhone[0]);
                                            OpportunityClass.updateOpportunityWithId(opportinityOpenMore[0].id, middleware);
                                            RecordClass.updateAccount(middleware);
                                        }
                                        else{
                                              OpportunityClass.createdOpportunityOtherStage(accountWithEmailAndPhone[0], middleware, leadConvertido, 'Contactado');
                                              RecordClass.updateAccount(middleware);
                                        }
                                    //RecordClass.updateAccount(middleware);
                                }
								**/
        
                            }
                        	else if(leadWithEmailAndPhone.size() >= 1  && jsonConQuote == false && jsonConOp == false){                                
                                if(leadWithEmailAndPhone.size() >= 1)
                                {
                                     if(leadWithEmailAndPhone[0].Identificacin__c != null)
                                     {
                                                if(leadWithEmailAndPhone[0].Identificacin__c != middleware.Record.identificacion){
                                                        RecordClass.createdNewLead(middleware);
                                                }
                                         		else{
                                                    RecordClass.updateLeadWithId(middleware, leadWithEmailAndPhone[0].id);
                                                }
                                        }
                                    	else{
                                             RecordClass.updateLeadWithId(middleware, leadWithEmailAndPhone[0].id);  
                                     }
                                }
                                else
                                {
                                    RecordClass.createdNewLead(middleware);
                                }
                            }
                        	else{
                                if((jsonConOp || jsonConQuote) && existeCuenta == false && leadConvertido == false){
                                    
                                    list<Account> account_list =  RecordClass.getAccountIdCliente(middleware.Record.idCliente);
                                    if(account_list.size() >= 1){
                                        accountNew = account_list[0];
                                        RecordClass.updateAccount(middleware);
                                    }else{
                                        accountNew =  RecordClass.createdNewAccount(middleware);
                                    }
                                }else{
                                    RecordClass.createdNewLead(middleware);
                                }
                            }
                    }
                    else{
                        if((jsonConOp || jsonConQuote) && existeCuenta == false && leadConvertido == false){
                            list<Account> account_list =  RecordClass.getAccountIdCliente(middleware.Record.idCliente);
                            if(account_list.size() >= 1){
                                   accountNew = account_list[0];
                                   RecordClass.updateAccount(middleware);
                            }else{
                                   accountNew =  RecordClass.createdNewAccount(middleware);
                            }
                        }else{
                            RecordClass.createdNewLead(middleware);
                        }
                        
                    } 
                }
                if(jsonConOp){
                    /**
                    * Proceso de Opportunidad Con id OP
                    * **/
                    
                    /****
                     * Validacion OP ANTIGUA PARA CUENTAS Y PARA LEAD
                     ***/
                    if(existeLead){
                        /**
                        * Validacion Op Antigua Lead
                        * **/
                        try{
                            
                            System.debug('leadExistentes[0].Ultima_Fecha_Ingreso__c != null');
                            System.debug(leadExistentes[0].Ultima_Fecha_Ingreso__c);	
                            if(leadExistentes[0].Ultima_Fecha_Ingreso__c != null){
                                 	DateTime ultimaFechaIngresoCuenta = leadExistentes[0].Ultima_Fecha_Ingreso__c;
                                    Date convertUltimaFechaIngreso = Date.newInstance(ultimaFechaIngresoCuenta.year(), ultimaFechaIngresoCuenta.month(), ultimaFechaIngresoCuenta.day());
                                    if(middleware.Oportunidad.emisionOrdenPedido < convertUltimaFechaIngreso){
                                        opAntigua = True;
                                    }
                            }
                        }catch(Exception e){
                                throw new CustomException('Error en Calculo de Fechas Lead to Oportunitty');
                        }
                        
                       
                    }
                    else if (existeCuenta){
                        /**
                        * Validacion Op Antigua Cuenta
                        * **/
                        
                        opportunityWithOutIdOp = OpportunityClass.getOpportunityWithAccount(cuentasExistentes[0]);
                        System.debug('OP VIEJA');
                        if(!opportunityWithOutIdOp.isEmpty()){
                            
                            for(Opportunity op : opportunityWithOutIdOp){
                                System.debug('OP VIEJA');
                                if(middleware.Oportunidad !=null && middleware.Oportunidad.emisionOrdenPedido != null){
                                    System.debug('OP VIEJA');
                                    if(op.Ultima_Fecha_Ingreso__c != null){
                                        System.debug('OP VIEJA');
                                        DateTime ultimaFechaIngreso = op.Ultima_Fecha_Ingreso__c; // Converitmos Ultimo ingreso en dateTime
                                        Date convertUltimaFechaIngreso = Date.newInstance(ultimaFechaIngreso.year(), ultimaFechaIngreso.month(), ultimaFechaIngreso.day()); // COnvertimos Ultimo ingreso a Date
                                        if(middleware.Oportunidad.emisionOrdenPedido < convertUltimaFechaIngreso){
                                         	System.debug('OP VIEJA');
                                            opAntigua = True;
                                        }
                                    }
                                }
                            }
                        }
                        /**
                        DateTime ultimaFechaIngresoCuenta = cuentasExistentes[0].Ultima_Fecha_Ingreso__c;
                        Date convertUltimaFechaIngreso = Date.newInstance(ultimaFechaIngresoCuenta.year(), ultimaFechaIngresoCuenta.month(), ultimaFechaIngresoCuenta.day());
                        if(middleware.Oportunidad.emisionOrdenPedido < convertUltimaFechaIngreso){
                            opAntigua = True;
                        }
						**/
                    }
                    
                    account = RecordClass.getAccountIdCliente(middleware.Record.idCliente); // Obtenemos el cliente con el IDcLIENTE    
                    if(account.size() == 0){
                        account[0] = accountNew;
                    }
                    List<Opportunity> opportunityWithIdOp = OpportunityClass.getOpportunityWithIdOp(middleware); //Obtenemos la oportunidad si existe en SF con idOp
                    List<Opportunity> opportunityContactado = OpportunityClass.getOpportunityContactado(account[0]); // Obtenemos Oportunidad en estado contactado del cliente si existe para sobreescribir
                    List<Opportunity> opportunityCotizacion = OpportunityClass.getOpportunityWithIdCotizacion(middleware.Oportunidad.idCotizacion, account[0]); // Obtenemos Oportunidad en estado Cotizacion del cliente si existe para sobreescribir
					/**
					 * Entra por aca y casi toda la logica esta en el else
					 * **/
                    
                    if(opportunityWithIdOp.size() >=1){
                            /**
                            * Actualizamos OP si existe en SF con IdOp__c
                            * **/
                            OpportunityClass.updateOpportunity(middleware);     
                    }
                    else if(opportunityWithIdOp.size() == 0){
                          /**
                            * Creamos OP y se asigna a Cliente
                            * **/
                            if(opportunityContactado.size() >= 1 && opAntigua == false){
                                 /**
                                 * opAntigua = > esta variable nos ayuda a saber si la op es antigua y no se monte sobre la contactado
                                * Validamos que si Tenemos una Opportunidad sin id op en etapa contactado y que no esta cerrada ganada o cerrada perdida
                                * updateOpportunityContactado = > con esta funcion lo que hacemos es que montamos sobre esa opportunidad la op entrante
                                * **/
                                OpportunityClass.updateOpportunityContactado(middleware);                                
                            }
                            else if (opportunityCotizacion.size() >= 1){
                                System.debug('Entro 1');
                                if(opportunityCotizacion[0].IdOP__c == null){
                                     System.debug('Entro 2');
                                    /**
                                     * Si existe una oportunidiad en etpa cotizacion, con una cotizacion ejemplo 001 e ingresa de nuestro sistema un OP con id cotizacion 001 esta se monta sobre la oportunidad abierta en cotizacion
                                     * **/
                                        OpportunityClass.updateOpportunityContizacion(middleware);
                                }
                                else if(opportunityCotizacion[0].IdOP__c != middleware.Oportunidad.idOP){
                                     System.debug('Entro 3');
                                     OpportunityClass.createdOpportunityWithIdOp(account[0], middleware, leadConvertido);
                                }else{
                                     System.debug('Entro 4');
                                    OpportunityClass.updateOpportunityContizacion(middleware);
                                }
    
                             }else{
                                  System.debug('Entro 5');
                                  OpportunityClass.createdOpportunityWithIdOp(account[0], middleware, leadConvertido);
                    
                             }
                           	
                            if(cuentasExistentes.size() >= 1){
                                    opportunityWithOutIdOp = OpportunityClass.getOpportunityWithAccount(cuentasExistentes[0]);
                            }else{
                                   opportunityWithOutIdOp = OpportunityClass.getOpportunityWithAccount(account[0]);

                            }
                            if(opAntigua && opportunityWithOutIdOp.size() == 0 ){
                                /**
                                * Proceso de Creacion de oportunidad en etapa contactado si la op entraste es anterior a la ult fecha ingreso del cliente o Prospecto
                                * **/
                                OpportunityClass.createdOpportunityOtherStage(account[0], middleware, leadConvertido, 'Contactado');
                            }
                    }
                    
                }
                
                else if(existeCuenta && jsonConQuote == false) {
                    System.debug('Entro En Existe Cuenta jsonConQuote == false');
                    /**
                    * 
                    * No viene con la estructura de la opportunidad valdiaciones y procesamiento
                    * **/
                    account = RecordClass.getAccountIdCliente(middleware.Record.idCliente);
                    List<Opportunity> opportunitySinIdIOpExistente = OpportunityClass.getOpportunityContactado(account[0]);
                    
                    if(opportunitySinIdIOpExistente.size() >= 1){
                        /**
                        * Actualizamso opportunidad en etapa contactado si ya tiene una abierta
                        * **/
                        OpportunityClass.updateOpportunityWithOutIdOp(account[0], middleware);
                    }
                    else {
                        List<Opportunity> opportinityOpen = OpportunityClass.getOpportunityOtherStage(account[0]);
                        
                        
                        System.debug('opportinityOpen ----------------------');
                        System.debug(opportinityOpen.size());
                        
                        if(opportinityOpen.size() == 1){
                            	OpportunityClass.updateOpportunityWithId(opportinityOpen[0].id, middleware);
                        }else if (opportinityOpen.size() >= 2){
                            List<Opportunity> opportinityOpenMore = OpportunityClass.getOpportunityLastDate(account[0]);
                            OpportunityClass.updateOpportunityWithId(opportinityOpenMore[0].id, middleware);
                        }
                        else{
                              OpportunityClass.createdOpportunityOtherStage(account[0], middleware, leadConvertido, 'Contactado');
                        }
                    }
                }
                
                if(jsonConProducto){
                    /**
                     * Procesamiento de Productos de la op
                     * **/
                    ProductClass.producTratament(middleware);
                }
				
                
                /**
                * proceso de cotizacion
                * **/
                
                if(jsonConQuote){
                    List<Quote> qt = QuoteClass.getQuoteWithId(middleware.Quote.idCotizacion);
                    if(qt.size() >= 1){
                        /**
                         * Existe una cotizacion con Id cotizacion
                         * **/
                        existeQuote = True;
                    }
                    
                    if(existeQuote){
                        /**
                         * Si Existe Cotizacion la actualizamos
                         * **/
                        QuoteClass.updateQuote(middleware);
                    }
                    else{
                        /**
                         * 
                         * Procesamiento si no existe la cotizacion en Salesforce
                         * account = > Buscamos el cliente por el idCLiente
                         * opportunitySinIdIOpExistente => Buscamos si el cliente tiene oportunidades en contactado
                         * quote => Podemos guardar la respuesta de las funciones
                         * 
                         * **/
                       	account = RecordClass.getAccountIdCliente(middleware.Record.idCliente);
                        List<Opportunity> opportunitySinIdIOpExistente = OpportunityClass.getOpportunityContactado(account[0]);
                        List<Opportunity> opportunityWithIdCotizacion  = OpportunityClass.getOpportunityCotizacion(middleware.Quote.idCotizacion);
                        Quote quote  = new Quote();
                        if(opportunityWithIdCotizacion.size() >= 1){
                            quote = QuoteClass.createdQuote(middleware, opportunityWithIdCotizacion[0]);
                            QuoteClass.syncQuoteAndUpdateOpportunity(opportunityWithIdCotizacion[0].id, quote.id);
                        }
                        else if(opportunitySinIdIOpExistente.size() >= 1 ){
                            /**
                             * Validamos si opportunitySinIdIOpExistente existe la oportunidad en contactado
                             * quoteOpportunity => buscamos si esa oportunidad tiene Cotizacones activas
                             * **/
                            List<Quote> quoteOpportunity = QuoteClass.getQuoteWithIdOpportunity(opportunitySinIdIOpExistente[0].id);
                            if(quoteOpportunity.size() == 0){
                                /**
                                 * Si no tiene cotizaciones activas le creamos una cotizacion a esa oportunidad en estado contactado existente
                                 * **/
                                System.debug('OKKKK');
                                System.debug(opportunitySinIdIOpExistente[0]);
                                quote = QuoteClass.createdQuote(middleware, opportunitySinIdIOpExistente[0]);
                                /**
                                 * Actualizamos la oportunidad a Cotizacion
                                 * **/
                                OpportunityClass.updateOpportunityWithOutIdOpStage(account[0], middleware, 'Cotización');
                                QuoteClass.syncQuoteAndUpdateOpportunity(opportunitySinIdIOpExistente[0].Id, quote.id);
                                
                            }
                            
                            else{
                                /**
                                 * Si esa op tiene cotizaciones activas procedemos a crearle al cliente una nueva oportunidad en etapa cotizacion con la cotizacion entrante
                                 * **/
                                Opportunity op = OpportunityClass.createdOpportunityOtherStage(account[0], middleware, leadConvertido, 'Cotización');
                                quote = QuoteClass.createdQuote(middleware, op);
                                QuoteClass.syncQuoteAndUpdateOpportunity(op.id, quote.id);
                            
                            }
                            
                        }
                        else{
                            /**
                             * Si no tiene opportunidades en etapa contactado creamos nueva oportunidad
                             * **/
                              Opportunity op = OpportunityClass.createdOpportunityOtherStage(account[0], middleware, leadConvertido, 'Cotización');
                              quote = QuoteClass.createdQuote(middleware, op);
                              QuoteClass.syncQuoteAndUpdateOpportunity(op.id, quote.id);
    
                          	 
                        }
                        
                        
                        
                        if(jsonConProductQuote){
                            /**
                             * Procesamiento producto de cotizacion solo para creacion
                             * **/
                            ProductQuoteClass.createdProductQuote(middleware, quote);
                        }
                    }
                    
                }
            }
            else{
                /**
                * proceso con el correo
                * **/
                if(middleware.Record.correoElectronico != null && middleware.Record.correoElectronico !=  '' && middleware.Record.celular != null && middleware.Record.celular != '')
                {
 					
                    
                    List<Account> acct = RecordClass.getAccountEmailPhone(middleware.Record.correoElectronico, middleware.Record.celular, middleware.Record.empresa);
                    
                    if(acct.size() == 1){
                        List<Opportunity> opportinityOpen = OpportunityClass.getOpportunityOtherStage(acct[0]);
                        System.debug('opportinityOpen ----------------------');
                        System.debug(opportinityOpen.size());
                        
                        if(opportinityOpen.size() == 1){
                            	OpportunityClass.updateOpportunityWithId(opportinityOpen[0].id, middleware);
                            	RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }else if (opportinityOpen.size() >= 2){
                            List<Opportunity> opportinityOpenMore = OpportunityClass.getOpportunityLastDate(acct[0]);
                            OpportunityClass.updateOpportunityWithId(opportinityOpenMore[0].id, middleware);
                            RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }
                        else{
                              OpportunityClass.createdOpportunityOtherStage(acct[0], middleware, leadConvertido, 'Contactado');
                              RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }
                        
                        
                    }
                    /**
                    else if(acct.size() > 2){
                        List<Opportunity> opportinityOpen = OpportunityClass.getOpportunityOtherStage(acct[0]);
                        System.debug('opportinityOpen ----------------------');
                        System.debug(opportinityOpen.size());
                        
                        if(opportinityOpen.size() == 1){
                            	OpportunityClass.updateOpportunityWithId(opportinityOpen[0].id, middleware);
                            	RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }else if (opportinityOpen.size() >= 2){
                            List<Opportunity> opportinityOpenMore = OpportunityClass.getOpportunityLastDate(acct[0]);
                            OpportunityClass.updateOpportunityWithId(opportinityOpenMore[0].id, middleware);
                            RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }
                        else{
                              OpportunityClass.createdOpportunityOtherStage(acct[0], middleware, leadConvertido, 'Contactado');
                              RecordClass.updateAccountWithIdCliente(middleware, acct[0].id);
                        }
                    }
					**/
                    
                    else {
                        List<Lead>leadWithEmailAndPhone = RecordClass.getLeadEmailPhone(middleware.Record.correoElectronico, middleware.Record.celular, middleware.Record.empresa);
                        if(leadWithEmailAndPhone.size() == 1){
                            RecordClass.updateLeadWithId(middleware, leadWithEmailAndPhone[0].id);
                        }
                        else if(leadWithEmailAndPhone.size() > 2){
                            List<Lead>leadLast = RecordClass.getLeadLastDate(middleware.Record.correoElectronico, middleware.Record.celular, middleware.Record.empresa);
                            RecordClass.updateLeadWithId(middleware, leadLast[0].id);
                        }else {
                            if(middleware.Record.correoElectronico != null && middleware.Record.correoElectronico !=  '')
                            {
                                 List<Lead> leadWithEmail = new List<Lead>();
                                leadWithEmail = RecordClass.getLeadEmail(middleware.Record.correoElectronico, middleware.Record.empresa);
                                System.debug('proceso con el correo');
                                System.debug(leadWithEmail);
                                if(leadWithEmail.size() >= 1){
                                 
                                    System.debug('Actualizar Lead');
                                    RecordClass.updateLeadWithEmail(middleware);
                                }
                                else if (leadWithEmail.IsEmpty()){
                                  
                                    System.debug('Crear Lead con Email');
                                    RecordClass.createdNewLead(middleware);
                                }
                            }
                            /** Validacion Jose
                            else {
                                RecordClass.createdNewLead(middleware);
                            }
							**/
                        }
                    }
                    
                    
					
                }
            
                else if(middleware.Record.correoElectronico != null && middleware.Record.correoElectronico !=  ''){
                    List<Lead> leadWithEmail = new List<Lead>();
                    leadWithEmail = RecordClass.getLeadEmail(middleware.Record.correoElectronico, middleware.Record.empresa);
                    System.debug('proceso con el correo');
                    System.debug(leadWithEmail);
                    if(leadWithEmail.size() >= 1){
                     
                        System.debug('Actualizar Lead');
                        RecordClass.updateLeadWithEmail(middleware);
                    }
                    else if (leadWithEmail.IsEmpty()){
                      
                        System.debug('Crear Lead con Email');
                        RecordClass.createdNewLead(middleware);
                    }
                }
                else{
                    RecordClass.createdNewLead(middleware);
                }
               
            }
            
        }
        catch(CustomException e){
            responseApi.message = e.getMessage();
            responseApi.statusCode = 400;
            responseApi.success = false;
            log.ClassName__c = 'GoogleBotAPI';
            log.date__c = Datetime.now();
            log.message__c =  e.getMessage();
            log.success__c = false;
            log.type__c = 'Procesamiento de peticion al ws';
            log.JSON__c = jsonInput;
            if(middleware.Record != null){
                if(middleware.Record.pais == 'Panama' || middleware.Record.pais == null || middleware.Record.pais == ''){
               			log.Empresa__c = 'Panamá';
                }else{
                    	log.Empresa__c = 'Colombia';
                }
                
            }else {
                		log.Empresa__c = 'Colombia';
            }
            insert log;
            return responseApi;
        }
        
        responseApi.message = 'Respuesta procesada correctamente';
        responseApi.statusCode = 200;
        responseApi.success = True;
        
        return responseApi;
    }
}