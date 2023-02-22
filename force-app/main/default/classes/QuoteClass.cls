public  class QuoteClass {
    public String idCotizacion;
    public String empresa;
    public String idProspectoInterno;
    public String usuarioCreacion;
    public String usuarioModificacion;
    public String usuarioAnulacion;
    public String codigoAgencia;
    public String tipoCotizacion;
    public Integer vigencia;
    public Date fechaVencimiento;
    public Boolean facturasUnidas;
    public String tipoCierre;
    public Date fechaCierre;
    public String motivoCierre;
    public String usuarioCierre;
    public String origenVenta;
    public String estado;
    public String codigoVendedor;
    public String nombreVendedor;
    public String canalAtencion;
    public Date fechaCreacion;
    
    public QuoteClass() {
        
    }
    
    
    public static List<Quote> getQuoteWithId(String idQuote){
        List<Quote> quote = new List<Quote>();
        quote = [SELECT Id, OpportunityId, QuoteNumber FROM Quote WHERE IdQuote__c =: idQuote];
        return quote;
    }
     public static List<Quote> getQuoteWithIdOpportunity(String id){
        List<Quote> quote = new List<Quote>();
        quote = [SELECT Id, OpportunityId, QuoteNumber FROM Quote WHERE OpportunityId =: id and Status =: 'Activo'];
        return quote;
    }
    
    public static Quote createdQuote(MiddlewareClass middle, Opportunity op){
        Quote qt = new Quote();
                
        try{
              	List<Pricebook2> pb =  getListaPrecios();
                QuoteClass quote = new QuoteClass();
                Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
                quote = middle.Quote;
                qt.OpportunityId = op.Id;
                qt.Pricebook2Id = pb[0].Id;
                if(quote.idCotizacion != null){
                    qt.IdQuote__c = quote.idCotizacion;
                    qt.Name = op.Name;
                }
                if(quote.empresa != null){
                    qt.Empresa__c = quote.empresa; 
                }
                if(quote.idProspectoInterno != null){
                    qt.Identificaci_n_Prospecto_Interno__c = quote.idProspectoInterno;
                }
                if(quote.fechaCreacion != null){
                    qt.Fecha_Creacion__c = quote.fechaCreacion;
                }
                if(quote.usuarioCreacion != null){
                    qt.Usuario_Creacion__c = quote.usuarioCreacion;
                }
                if(quote.usuarioModificacion != null){
                    qt.Usuario_de_Modificacion__c = quote.usuarioModificacion;
                }
                if(quote.usuarioAnulacion != null){
                    qt.Usuario_de_Anulacion__c = quote.usuarioAnulacion;
                }
                if(quote.codigoAgencia != null){
                    qt.Agencia__c = mapAgencias.get(quote.codigoAgencia).Id;
                }
                if(quote.tipoCotizacion != null){
                    qt.Tipo_Cotizacion__c = quote.tipoCotizacion;
                }
                if(quote.vigencia != null){
                    qt.Vigencia__c = quote.vigencia;
                }
                if(quote.fechaVencimiento != null){
                    qt.ExpirationDate = quote.fechaVencimiento;
                }
                if(quote.facturasUnidas != null){
                    qt.Facturas_Unidas__c = quote.facturasUnidas;
                }
                if(quote.tipoCierre != null){
                    qt.Tipo_Cierre__c = quote.tipoCierre;
                }
                if(quote.fechaCierre != null){
                    qt.Fecha_Cierre__c = quote.fechaCierre;
                }
                if(quote.motivoCierre != null){
                    qt.Motivo_Cierre__c = quote.motivoCierre;
                }
                if(quote.usuarioCierre != null){
                    qt.Usuario_Cierre__c = quote.usuarioCierre;
                }
                if(quote.origenVenta != null){
                    qt.Origen_Venta__c = quote.origenVenta;
                }
                if(quote.estado != null){
                    qt.Status = quote.estado;
                }
                if(quote.nombreVendedor != null){
                    qt.Nombre_Vendedor__c = quote.nombreVendedor;
                }
                if(quote.codigoVendedor != null){
                    qt.Codigo_Vendedor__c = quote.codigoVendedor;
                }
                if(quote.canalAtencion != null){
                    qt.Canal_de_Atencion__c = quote.canalAtencion;
                }
            insert qt;
        }catch(Exception e){
            throw new CustomException('Linea: ' + e.getLineNumber() + '. Error al insertar la cotizacion en la funcion createdQuote ' +  e.getMessage());
        }
        
        return qt;
    }
    
    public static Quote updateQuote(MiddlewareClass middle){
        QuoteClass quoteEntry = new QuoteClass();
        List<Quote> qt = new List<Quote>();
        try{
            quoteEntry = middle.Quote;
            Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
            qt = getQuoteWithId(quoteEntry.idCotizacion);
            
            if(quoteEntry.idCotizacion != null){
                qt[0].IdQuote__c = quoteEntry.idCotizacion;
            }
            if(quoteEntry.empresa != null){
                qt[0].Empresa__c = quoteEntry.empresa; 
            }
             if(quoteEntry.fechaCreacion != null){
                qt[0].Fecha_Creacion__c = quoteEntry.fechaCreacion;
            }
            if(quoteEntry.idProspectoInterno != null){
                qt[0].Identificaci_n_Prospecto_Interno__c = quoteEntry.idProspectoInterno;
            }
            
            if(quoteEntry.usuarioCreacion != null){
                qt[0].Usuario_Creacion__c = quoteEntry.usuarioCreacion;
            }
            if(quoteEntry.usuarioModificacion != null){
                qt[0].Usuario_de_Modificacion__c = quoteEntry.usuarioModificacion;
            }
            if(quoteEntry.usuarioAnulacion != null){
                qt[0].Usuario_de_Anulacion__c = quoteEntry.usuarioAnulacion;
            }
            if(quoteEntry.codigoAgencia != null){
                qt[0].Agencia__c = mapAgencias.get(quoteEntry.codigoAgencia).Id;
            }
            if(quoteEntry.tipoCotizacion != null){
                qt[0].Tipo_Cotizacion__c = quoteEntry.tipoCotizacion;
            }
            if(quoteEntry.vigencia != null){
                qt[0].Vigencia__c = quoteEntry.vigencia;
            }
            if(quoteEntry.fechaVencimiento != null){
                qt[0].ExpirationDate = quoteEntry.fechaVencimiento;
            }
            if(quoteEntry.facturasUnidas != null){
                qt[0].Facturas_Unidas__c = quoteEntry.facturasUnidas;
            }
            if(quoteEntry.tipoCierre != null){
                qt[0].Tipo_Cierre__c = quoteEntry.tipoCierre;
            }
            if(quoteEntry.fechaCierre != null){
                qt[0].Fecha_Cierre__c = quoteEntry.fechaCierre;
            }
            if(quoteEntry.motivoCierre != null){
                qt[0].Motivo_Cierre__c = quoteEntry.motivoCierre;
            }
            if(quoteEntry.usuarioCierre != null){
                qt[0].Usuario_Cierre__c = quoteEntry.usuarioCierre;
            }
            if(quoteEntry.origenVenta != null){
                qt[0].Origen_Venta__c = quoteEntry.origenVenta;
            }
            if(quoteEntry.estado != null){
                qt[0].Status = quoteEntry.estado;
            }
            if(quoteEntry.codigoVendedor != null){
                qt[0].Codigo_Vendedor__c = quoteEntry.codigoVendedor;
            }
            if(quoteEntry.nombreVendedor != null){
                qt[0].Nombre_Vendedor__c = quoteEntry.nombreVendedor;
            }
            if(quoteEntry.canalAtencion != null){
                qt[0].Canal_de_Atencion__c = quoteEntry.canalAtencion;
            }
            update qt;
        }catch(Exception e){
            throw new CustomException('Error al modificar la cotizacion en la funcion updateQuote ' +  e.getMessage());
        }
        return qt[0];
    }
    
    @future
    public static void syncQuoteAndUpdateOpportunity(String idOpportunity, String idQuote){
        try{
            List<Opportunity> opp = [SELECT ID, VentaTotal__c, Id_Cotizacion__c, Canal_de_Atencion__c, Origen_Venta__c FROM Opportunity where Id =: idOpportunity FOR UPDATE];
            List<Quote> qt = [SELECT ID, GrandTotal, IdQuote__c, Canal_de_Atencion__c, Origen_Venta__c FROM Quote where Id =: idQuote FOR UPDATE];
            opp[0].SyncedQuoteId = qt[0].Id;
            opp[0].VentaTotal__c = qt[0].GrandTotal;
            opp[0].Id_Cotizacion__c = qt[0].IdQuote__c;
            opp[0].Canal_de_Atencion__c = qt[0].Canal_de_Atencion__c;
            opp[0].Origen_Venta__c = qt[0].Origen_Venta__c;
        	update opp[0]; 
        }catch(CustomException e){ 
            throw new CustomException('Error en la sincronizacion de la Cotizacion');
        }
        
    }
    
    public static List<Pricebook2> getListaPrecios(){
           List<Pricebook2> listaPrecios = new List<Pricebook2>();
		   listaPrecios = [SELECT Id FROM Pricebook2 FOR UPDATE];
           return listaPrecios;
    }

}