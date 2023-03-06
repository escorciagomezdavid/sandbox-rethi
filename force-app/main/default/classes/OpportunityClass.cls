public class OpportunityClass {
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
    public DateTime ultimaFechaIngreso;
    public String tipoGestion;
    public Date ultimaFechaPrecalificacion;
    public String ejecutivoCredito;      
    public Date listoFacturarFecha;
    public Boolean listoFacturar;
    public Date fechaDespacho;
    public Date citaEntrega;
    public Boolean opDeTercero;
    public String idCotizacion;
    public String accionSugerida;
    public String canalAtencion;
    public String origenVenta;
    public String causalDesiste;
    public String etapaEntrega;
    public String recogerTienda;
    public String codigoAprobacion;
    public Double valorOrdenConPaseSaldo;
    public Double valorOrdenSinFinanciacion;
    public String agenciaVendedor;
    public String LinkCalificacionLargo;
    public String LinkCalificacionCorto;

    // --- JCASTRO 23/11/2022: Variables para proceso de Desborde
    public String completation_Stage;
    public String tipo_Validacion;
    public String tipo_Firma;


    
    public OpportunityClass() {
        
    }
    
    
    public static List<Opportunity> getOpportunityWithIdOp(MiddlewareClass  middle){
        List<Opportunity> opportunities = new List<Opportunity>();
        OpportunityClass opportunity  = new OpportunityClass();
        opportunity = middle.Oportunidad;
        opportunities = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Causal_Desiste__c, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c, CompletionStages__c, Tipo_Validacion__c, Tipo_Firma__c
                         FROM Opportunity WHERE IdOP__c =: opportunity.idOP];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunity(String  idOp){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Causal_Desiste__c, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE IdOP__c =: idOp];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityWithIdCotizacion(String  idCotizacion, Account act){
        /**
         * nO
         * **/
        List<Quote> quote = new List<Quote>();
        List<Opportunity> opportunities = new List<Opportunity>();

        
        quote = [SELECT OpportunityId FROM Quote Where IdQuote__c =: idCotizacion and AccountId =: act.Id];
        if(quote.size() >= 1){
            opportunities = [SELECT Id, Id_Cotizacion__c, IdOP__c FROM Opportunity Where Id =: quote[0].OpportunityId];
        }
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityCotizacion(QuoteClass Cotizacion){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, PriceBook2Id, Name, Causal_Desiste__c, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE Id_Cotizacion__c=: Cotizacion.idCotizacion and CEmpresa__c =: Cotizacion.empresa];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityId(String  id){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, PriceBook2Id, Name, Causal_Desiste__c, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE id =: id];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityContactado(Account account){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, PriceBook2Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE AccountId =: account.Id AND StageName =: 'Contactado' AND ( Cerrada__c !=: 'Perdida' OR Cerrada__c !=: 'Ganada') AND idOp__c =: ''];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityWithAccount(Account account){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                                  Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                                  FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                                  FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                                  Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE AccountId =: account.Id  AND ( idOp__c = '' OR idOp__c = null) AND StageName != 'Cerrado Perdido' AND StageName != 'Cerrado Ganado'];
        return opportunities;
    }
    
    public static List<Opportunity> getOpportunityCotizacion(Account account){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, PriceBook2Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE AccountId =: account.Id AND StageName =: 'Cotización' AND ( Cerrada__c !=: 'Perdida' OR Cerrada__c !=: 'Ganada') AND idOp__c = ''];
        return opportunities;
    }
    
    
    public static List<Opportunity> getOpportunityOtherStage(Account account){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, PriceBook2Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE AccountId =: account.Id AND StageName !=: 'Cerrado Perdido' AND StageName !=: 'Cerrado Ganado'];
        return opportunities;
    }
    
    
    public static List<Opportunity> getOpportunityLastDate(Account account){
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities = [SELECT Id, PriceBook2Id, StageName, VentaTotal__c, Seguro__c, CloseDate, AgenciaPedido__c, Periodo__c, IdOP__c, CodigoVendedor__c, NombreDeVendedor__c, EmisionOrdenPedido__c,
                         Cuotas__c, DireccionDeDespacho__c, EstadoOrdenPedido__c, IdEstudio__c, EtapaDelCredito__c, ExisteEnInventario__c, CotizacionPedidoEnviada__c, CompletacionDeCredito__c, OrdenPedidoAprobada__c,
                         FechaEntrega__c, PIN__c, PropuestaDePago__c, PedidoFaturado__c, Cerrada__c, MotivoDePerdida__c, FechaFacturacion__c, IdCliente__c, FechaCompletacionCredito__c, FechaAprobacion__c,
                         FechaEnvioCotizacion__c, ConcatPendCred__c, Numero_OP__c, Tipo_de_Registro__c, Ultima_Fecha_Ingreso__c, Name, Codigo_Aprobacion__c, Valor_orden_de_pedido_con_pase_saldo__c, 
                         Valor_orden_de_pedido_de_financiacion__c, LinkCalificacionLargo__c, LinkCalificacionCorto__c
                         FROM Opportunity WHERE AccountId =: account.Id AND ( Cerrada__c !=: 'Perdida' AND Cerrada__c !=: 'Ganada')  ORDER BY Ultima_Fecha_Ingreso__c desc LIMIT 1];
        return opportunities;
    }
    
    public static Opportunity updateOpportunity(MiddlewareClass  middle){
        System.debug('updateOpportunity');
        List<Opportunity> opportunities = new List<Opportunity>();
        OpportunityClass opportunity = new OpportunityClass();
        Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
        Map<String, Departamento__c> mapDepartamentos = RecordClass.getDepartmento();
        List<Opportunity> op = new List<Opportunity>();
      
        try{
            op = getOpportunityWithIdOp(middle);
            opportunity = middle.Oportunidad;
            op[0].Api_Name__c = 'APIV2';
            op[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(opportunity.idOP != null){
                op[0].IdOP__c = opportunity.idOP;
            }
            
            op[0].Causal_Desiste__c = opportunity.causalDesiste;
            op[0].Etapa_Entrega__c = opportunity.etapaEntrega;
            op[0].Canal_de_Atencion__c = opportunity.canalAtencion;
            op[0].Origen_Venta__c = opportunity.origenVenta;
            op[0].Accion_Sugerida__c = opportunity.accionSugerida;
            op[0].VentaTotal__c = opportunity.ventaTotal;
            op[0].CloseDate = opportunity.fechaCierre;
            op[0].Cuotas__c = opportunity.cuotas;
            op[0].DireccionDeDespacho__c = opportunity.direccionDespacho;
            op[0].EtapaDelCredito__c = opportunity.etapaCredito;
            op[0].CompletacionDeCredito__c = opportunity.completacionCredito;
            op[0].ConcatPendCred__c = opportunity.completacionCredito;
            op[0].OrdenPedidoAprobada__c = opportunity.ordenPedidoAprobada;
            op[0].FechaEntrega__c = opportunity.fechaEntrega;
            op[0].PIN__c = opportunity.pin;
            op[0].PropuestaDePago__c = opportunity.propuestaPago;
            op[0].PedidoFaturado__c = opportunity.pedidoFactura;
            op[0].Cerrada__c = opportunity.cerrada;
            op[0].MotivoDePerdida__c = opportunity.motivoPerdida;
            op[0].TipoDePago__c = opportunity.tipoPago;
            op[0].FechaFacturacion__c = opportunity.fechaFacturacion;
            op[0].FechaCompletacionCredito__c = opportunity.fechaCompletacionCredito;
            op[0].FechaAprobacion__c = opportunity.fechaAprobacion;
            op[0].FechaEnvioCotizacion__c = opportunity.fechaCreacionOP;
            op[0].Ejecutivo_de_Credito__c = opportunity.ejecutivoCredito;
            op[0].Ultima_Fecha_de_Pre_Calificacion__c = opportunity.ultimaFechaPrecalificacion;
            op[0].Listo_Facturar_Fecha__c = opportunity.listoFacturarFecha;
            op[0].Listo_a_Factruar__c = opportunity.listoFacturar;
            op[0].Fecha_Despacho__c = opportunity.fechaDespacho;
            op[0].Cita_Entrega__c = opportunity.citaEntrega;
            op[0].Codigo_Aprobacion__c = opportunity.codigoAprobacion;
            op[0].Valor_orden_de_pedido_con_pase_saldo__c = opportunity.valorOrdenConPaseSaldo;
            op[0].Valor_orden_de_pedido_de_financiacion__c = opportunity.valorOrdenSinFinanciacion;

            if (opportunity.LinkCalificacionLargo != null){
                op[0].LinkCalificacionLargo__c = opportunity.LinkCalificacionLargo;
            }
            //BRIAN
            if (opportunity.LinkCalificacionCorto != null){
                op[0].LinkCalificacionCorto__c = opportunity.LinkCalificacionCorto;
            }
            //BRIAN
            
            if(opportunity.recogerTienda != null){
                op[0].Recoge_en_Tienda__c = opportunity.recogerTienda;
            }
     
            if(opportunity.idCotizacion != null){
                op[0].Id_Cotizacion__c = opportunity.idCotizacion;
            }
            if(opportunity.etapa != null){
                op[0].StageName = opportunity.etapa;
            }

            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Inicio ---
            if(opportunity.completation_Stage != null){
                op[0].CompletionStages__c = opportunity.completation_Stage;
            }
            if(opportunity.tipo_Validacion != null){
                op[0].Tipo_Validacion__c = opportunity.tipo_Validacion;
            }
            if(opportunity.tipo_Firma != null){
                op[0].Tipo_Firma__c = opportunity.tipo_Firma;
            }
            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Fin ---

            if(opportunity.seguro != null){
                op[0].Seguro__c = opportunity.seguro;
            }
    
            if(opportunity.agenciaPedido != null){
                op[0].AgenciaPedido__c = mapAgencias.get(opportunity.agenciaPedido).Id;
            }
            if(opportunity.agenciaVendedor != null){
                op[0].Agencia_Vendedor__c = mapAgencias.get(opportunity.agenciaVendedor).Id;
            }
            if(opportunity.periodo != null){
                op[0].Periodo__c = opportunity.periodo;
            }
            if(opportunity.codigoVendedor != null){
                op[0].CodigoVendedor__c = opportunity.codigoVendedor;
            }
            if(opportunity.nombreVendedor != null){
                op[0].NombreDeVendedor__c = opportunity.nombreVendedor;
            }
            if(opportunity.emisionOrdenPedido != null){
                op[0].EmisionOrdenPedido__c = opportunity.emisionOrdenPedido;
            }
            if(opportunity.estadoOrdenPedido != null){
                op[0].EstadoOrdenPedido__c = opportunity.estadoOrdenPedido;
            }
            if(opportunity.idEstudio != null){
                op[0].IdEstudio__c = opportunity.idEstudio;
            }
            if(opportunity.existeInventario != null){
                op[0].ExisteEnInventario__c = opportunity.existeInventario;
            }
            if(opportunity.cotizacionPedidoEnviada != null){
                op[0].CotizacionPedidoEnviada__c = opportunity.cotizacionPedidoEnviada;
            }
            if(opportunity.origen != null){
                op[0].LeadSource = opportunity.origen;
            }
            if(opportunity.idCliente != null){
                op[0].IdCliente__c = opportunity.idCliente;
            }
            if(opportunity.tipoVenta != null){
                op[0].Type = opportunity.tipoVenta;
            }
            if(opportunity.numeroOrdenPedido != null){
                op[0].Numero_OP__c = String.valueOf(opportunity.numeroOrdenPedido);
            }
            if(opportunity.tipoOportunidad != null){
                if(opportunity.tipoOportunidad == 'Contado'){
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                }else{
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                }
            }  
            if(opportunity.opDeTercero != null){
                op[0].OP_de_terceros__c = opportunity.opDeTercero;
            }
                update op[0];
            }catch(Exception e){
                throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunity ' +  e.getMessage());
            }
        
        return op[0];
    }
    
    public static Opportunity updateOpportunityContactado(MiddlewareClass  middle){
        System.debug('updateOpportunityContactado');
        List<Opportunity> opportunities = new List<Opportunity>();
        OpportunityClass opportunity = new OpportunityClass();
        Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
        Map<String, Departamento__c> mapDepartamentos = RecordClass.getDepartmento();
        List<Opportunity> op = new List<Opportunity>();
    	RecordClass record = new RecordClass();

        try{
            record = middle.Record;
            List<Account> accRecord = RecordClass.getAccountIdCliente(record.idCliente);
            op = getOpportunityContactado(accRecord[0]);
            opportunity = middle.Oportunidad;
            op[0].Api_Name__c = 'APIV2';
            op[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(opportunity.idOP != null){
                op[0].IdOP__c = opportunity.idOP;
            }
            
            op[0].Causal_Desiste__c = opportunity.causalDesiste;
            op[0].Etapa_Entrega__c = opportunity.etapaEntrega;
            op[0].Canal_de_Atencion__c = opportunity.canalAtencion;
            op[0].Origen_Venta__c = opportunity.origenVenta;
            op[0].Accion_Sugerida__c = opportunity.accionSugerida;
            op[0].VentaTotal__c = opportunity.ventaTotal;
            op[0].CloseDate = opportunity.fechaCierre;
            op[0].Cuotas__c = opportunity.cuotas;
            op[0].DireccionDeDespacho__c = opportunity.direccionDespacho;
            op[0].EtapaDelCredito__c = opportunity.etapaCredito;
            op[0].CompletacionDeCredito__c = opportunity.completacionCredito;
            op[0].ConcatPendCred__c = opportunity.completacionCredito;
            op[0].OrdenPedidoAprobada__c = opportunity.ordenPedidoAprobada;
            op[0].FechaEntrega__c = opportunity.fechaEntrega;
            op[0].PIN__c = opportunity.pin;
            op[0].PropuestaDePago__c = opportunity.propuestaPago;
            op[0].PedidoFaturado__c = opportunity.pedidoFactura;
            op[0].Cerrada__c = opportunity.cerrada;
            op[0].MotivoDePerdida__c = opportunity.motivoPerdida;
            op[0].TipoDePago__c = opportunity.tipoPago;
            op[0].FechaFacturacion__c = opportunity.fechaFacturacion;
            op[0].FechaCompletacionCredito__c = opportunity.fechaCompletacionCredito;
            op[0].FechaAprobacion__c = opportunity.fechaAprobacion;
            op[0].FechaEnvioCotizacion__c = opportunity.fechaCreacionOP;
            op[0].Ejecutivo_de_Credito__c = opportunity.ejecutivoCredito;
            op[0].Ultima_Fecha_de_Pre_Calificacion__c = opportunity.ultimaFechaPrecalificacion;
            op[0].Listo_Facturar_Fecha__c = opportunity.listoFacturarFecha;
            op[0].Listo_a_Factruar__c = opportunity.listoFacturar;
            op[0].Fecha_Despacho__c = opportunity.fechaDespacho;
            op[0].Cita_Entrega__c = opportunity.citaEntrega;
            op[0].Codigo_Aprobacion__c = opportunity.codigoAprobacion;

            if (opportunity.LinkCalificacionLargo != null){
                op[0].LinkCalificacionLargo__c = opportunity.LinkCalificacionLargo;
            }
            //BRIAN
            if (opportunity.LinkCalificacionCorto != null){
                op[0].LinkCalificacionCorto__c = opportunity.LinkCalificacionCorto;
            }
            //BRIAN
            
            if(opportunity.recogerTienda != null){
                op[0].Recoge_en_Tienda__c = opportunity.recogerTienda;
            }
     
            if(opportunity.idCotizacion != null){
                op[0].Id_Cotizacion__c = opportunity.idCotizacion;
            }
            if(opportunity.etapa != null){
                op[0].StageName = opportunity.etapa;
            }

            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Inicio ---
            if(opportunity.completation_Stage != null){
                op[0].CompletionStages__c = opportunity.completation_Stage;
            }
            if(opportunity.tipo_Validacion != null){
                op[0].Tipo_Validacion__c = opportunity.tipo_Validacion;
            }
            if(opportunity.tipo_Firma != null){
                op[0].Tipo_Firma__c = opportunity.tipo_Firma;
            }
            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Fin ---

            if(opportunity.seguro != null){
                op[0].Seguro__c = opportunity.seguro;
            }
    
            if(opportunity.agenciaPedido != null){
                op[0].AgenciaPedido__c = mapAgencias.get(opportunity.agenciaPedido).Id;
            }
            if(opportunity.agenciaVendedor != null){
                op[0].Agencia_Vendedor__c = mapAgencias.get(opportunity.agenciaVendedor).Id;
            }
            if(opportunity.periodo != null){
                op[0].Periodo__c = opportunity.periodo;
            }
            if(opportunity.codigoVendedor != null){
                op[0].CodigoVendedor__c = opportunity.codigoVendedor;
            }
            if(opportunity.nombreVendedor != null){
                op[0].NombreDeVendedor__c = opportunity.nombreVendedor;
            }
            if(opportunity.emisionOrdenPedido != null){
                op[0].EmisionOrdenPedido__c = opportunity.emisionOrdenPedido;
            }
            if(opportunity.estadoOrdenPedido != null){
                op[0].EstadoOrdenPedido__c = opportunity.estadoOrdenPedido;
            }
            if(opportunity.idEstudio != null){
                op[0].IdEstudio__c = opportunity.idEstudio;
            }
            if(opportunity.existeInventario != null){
                op[0].ExisteEnInventario__c = opportunity.existeInventario;
            }
            if(opportunity.cotizacionPedidoEnviada != null){
                op[0].CotizacionPedidoEnviada__c = opportunity.cotizacionPedidoEnviada;
            }
            if(opportunity.origen != null){
                op[0].LeadSource = opportunity.origen;
            }
            if(opportunity.idCliente != null){
                op[0].IdCliente__c = opportunity.idCliente;
            }
            if(opportunity.tipoVenta != null){
                op[0].Type = opportunity.tipoVenta;
            }
            if(opportunity.numeroOrdenPedido != null){
                op[0].Numero_OP__c = String.valueOf(opportunity.numeroOrdenPedido);
            }
            if(opportunity.tipoOportunidad != null){
                if(opportunity.tipoOportunidad == 'Contado'){
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                }else{
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                }
            }  
            if(opportunity.opDeTercero != null){
                op[0].OP_de_terceros__c = opportunity.opDeTercero;
            }
            update op[0];
        }catch(Exception e){
            throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunityContactado ' +  e.getMessage());
        }
        
        return op[0];
    }
    
    
    public static Opportunity updateOpportunityContizacion(MiddlewareClass  middle){
        System.debug('updateOpportunityContizacion');
        List<Opportunity> opportunities = new List<Opportunity>();
        OpportunityClass opportunity = new OpportunityClass();
        Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
        Map<String, Departamento__c> mapDepartamentos = RecordClass.getDepartmento();
        List<Opportunity> op = new List<Opportunity>();
    	RecordClass record = new RecordClass();
       

        
        try{
            record = middle.Record;
            List<Account> accRecord = RecordClass.getAccountIdCliente(record.idCliente);
            opportunity = middle.Oportunidad;
            op = getOpportunityWithIdCotizacion(opportunity.idCotizacion, accRecord[0]);
            op[0].Api_Name__c = 'APIV2';
            op[0].SyncedQuoteId = null;
            op[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(opportunity.idOP != null){
                op[0].IdOP__c = opportunity.idOP;
            }
            
            op[0].Causal_Desiste__c = opportunity.causalDesiste;
            op[0].Etapa_Entrega__c = opportunity.etapaEntrega;
            op[0].Canal_de_Atencion__c = opportunity.canalAtencion;
            op[0].Origen_Venta__c = opportunity.origenVenta;
            op[0].Accion_Sugerida__c = opportunity.accionSugerida;
            op[0].VentaTotal__c = opportunity.ventaTotal;
            op[0].CloseDate = opportunity.fechaCierre;
            op[0].Cuotas__c = opportunity.cuotas;
            op[0].DireccionDeDespacho__c = opportunity.direccionDespacho;
            op[0].EtapaDelCredito__c = opportunity.etapaCredito;
            op[0].CompletacionDeCredito__c = opportunity.completacionCredito;
            op[0].ConcatPendCred__c = opportunity.completacionCredito;
            op[0].OrdenPedidoAprobada__c = opportunity.ordenPedidoAprobada;
            op[0].FechaEntrega__c = opportunity.fechaEntrega;
            op[0].PIN__c = opportunity.pin;
            op[0].PropuestaDePago__c = opportunity.propuestaPago;
            op[0].PedidoFaturado__c = opportunity.pedidoFactura;
            op[0].Cerrada__c = opportunity.cerrada;
            op[0].MotivoDePerdida__c = opportunity.motivoPerdida;
            op[0].TipoDePago__c = opportunity.tipoPago;
            op[0].FechaFacturacion__c = opportunity.fechaFacturacion;
            op[0].FechaCompletacionCredito__c = opportunity.fechaCompletacionCredito;
            op[0].FechaAprobacion__c = opportunity.fechaAprobacion;
            op[0].FechaEnvioCotizacion__c = opportunity.fechaCreacionOP;
            op[0].Ejecutivo_de_Credito__c = opportunity.ejecutivoCredito;
            op[0].Ultima_Fecha_de_Pre_Calificacion__c = opportunity.ultimaFechaPrecalificacion;
            op[0].Listo_Facturar_Fecha__c = opportunity.listoFacturarFecha;
            op[0].Listo_a_Factruar__c = opportunity.listoFacturar;
            op[0].Fecha_Despacho__c = opportunity.fechaDespacho;
            op[0].Cita_Entrega__c = opportunity.citaEntrega;
            op[0].Codigo_Aprobacion__c = opportunity.codigoAprobacion;
            op[0].Valor_orden_de_pedido_con_pase_saldo__c = opportunity.valorOrdenConPaseSaldo;
            op[0].Valor_orden_de_pedido_de_financiacion__c = opportunity.valorOrdenSinFinanciacion;

            if (opportunity.LinkCalificacionLargo != null){
                op[0].LinkCalificacionLargo__c = opportunity.LinkCalificacionLargo;
            }
            //BRIAN
            if (opportunity.LinkCalificacionCorto != null){
                op[0].LinkCalificacionCorto__c = opportunity.LinkCalificacionCorto;
            }
            //BRIAN
            
            if(opportunity.recogerTienda != null){
                op[0].Recoge_en_Tienda__c = opportunity.recogerTienda;
            }
     
            if(opportunity.idCotizacion != null){
                op[0].Id_Cotizacion__c = opportunity.idCotizacion;
            }
            if(opportunity.etapa != null){
                op[0].StageName = opportunity.etapa;
            }

            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Inicio ---
            if(opportunity.completation_Stage != null){
                op[0].CompletionStages__c = opportunity.completation_Stage;
            }
            if(opportunity.tipo_Validacion != null){
                op[0].Tipo_Validacion__c = opportunity.tipo_Validacion;
            }
            if(opportunity.tipo_Firma != null){
                op[0].Tipo_Firma__c = opportunity.tipo_Firma;
            }
            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Fin ---

            if(opportunity.seguro != null){
                op[0].Seguro__c = opportunity.seguro;
            }
    
            if(opportunity.agenciaPedido != null){
                op[0].AgenciaPedido__c = mapAgencias.get(opportunity.agenciaPedido).Id;
            }
            if(opportunity.agenciaVendedor != null){
                op[0].Agencia_Vendedor__c = mapAgencias.get(opportunity.agenciaVendedor).Id;
            }
            if(opportunity.periodo != null){
                op[0].Periodo__c = opportunity.periodo;
            }
            if(opportunity.codigoVendedor != null){
                op[0].CodigoVendedor__c = opportunity.codigoVendedor;
            }
            if(opportunity.nombreVendedor != null){
                op[0].NombreDeVendedor__c = opportunity.nombreVendedor;
            }
            if(opportunity.emisionOrdenPedido != null){
                op[0].EmisionOrdenPedido__c = opportunity.emisionOrdenPedido;
            }
            if(opportunity.estadoOrdenPedido != null){
                op[0].EstadoOrdenPedido__c = opportunity.estadoOrdenPedido;
            }
            if(opportunity.idEstudio != null){
                op[0].IdEstudio__c = opportunity.idEstudio;
            }
            if(opportunity.existeInventario != null){
                op[0].ExisteEnInventario__c = opportunity.existeInventario;
            }
            if(opportunity.cotizacionPedidoEnviada != null){
                op[0].CotizacionPedidoEnviada__c = opportunity.cotizacionPedidoEnviada;
            }
            if(opportunity.origen != null){
                op[0].LeadSource = opportunity.origen;
            }
            if(opportunity.idCliente != null){
                op[0].IdCliente__c = opportunity.idCliente;
            }
            if(opportunity.tipoVenta != null){
                op[0].Type = opportunity.tipoVenta;
            }
            if(opportunity.numeroOrdenPedido != null){
                op[0].Numero_OP__c = String.valueOf(opportunity.numeroOrdenPedido);
            }
            if(opportunity.tipoOportunidad != null){
                if(opportunity.tipoOportunidad == 'Contado'){
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
                }else{
                    op[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
                }
            }  
            if(opportunity.opDeTercero != null){
                op[0].OP_de_terceros__c = opportunity.opDeTercero;
            }
            update op[0];
        }catch(Exception e){
            throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunityContizacion ' +  e.getMessage());
        }
        return op[0];
    }
    
    public static Opportunity updateOpportunityWithOutIdOp(Account account, MiddlewareClass  middle){
        System.debug('updateOpportunityWithOutIdOp');
        List<Opportunity> op = new List<Opportunity> ();
        List<Account> acct = new List<Account>();
        RecordClass record = new RecordClass();
         
        try{
            record = middle.Record;
             acct = RecordClass.getAccountIdCliente(record.idCliente);
            
             op = getOpportunityContactado(acct[0]);
             System.debug('OPPPPS');
                System.debug(op);
             op[0].Api_Name__c = 'APIV2';
             op[0].Tipo_de_Registro__c = account.Tipo_de_Registro__c;
             if(record.origen != null){
                op[0].LeadSource = record.origen;
             }
             op[0].Description = account.Description;
             op[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            update op[0];
        }catch(Exception e){
            throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunityWithOutIdOp ' +  e.getMessage());
        }
         return op[0];
    }
    
    public static Opportunity updateOpportunityWithId(String id, MiddlewareClass  middle){
        System.debug('updateOpportunityWithId');
        List<Opportunity> op = getOpportunityId(id);
        Opportunity ops = new Opportunity();
        
         try{
            ops = op[0];
            RecordClass record = new RecordClass();
            record = middle.Record;
            /**       
            if(record.nombreVendedor != null){
                ops.NombreDeVendedor__c = record.nombreVendedor;
            }
			**/
            if(record.origen != null){
                ops.LeadSource = record.origen;
            }
            if(record.descripcion != null){
                ops.Description = record.descripcion;
            }
            ops.Ultima_Fecha_Ingreso__c = DateTime.now();
            
            if(record.tipoGestion != null){
                ops.Tipo_de_Registro__c = record.tipoGestion;
            }
     
            if(record.canalAtencion != null){
                ops.Canal_de_Atencion__c = record.canalAtencion;
            }
            update ops;
        }catch(Exception e){
            throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunityWithId ' +  e.getMessage());
        }
         return ops;
    }
    
    
    
    public static Opportunity updateOpportunityWithOutIdOpStage(Account account, MiddlewareClass  middle, String Stage){
        System.debug('updateOpportunityWithOutIdOpStage');
        List<Opportunity> op = new List<Opportunity> ();
         List<Account> acct = new List<Account>();
         RecordClass record = new RecordClass();
         
          try{
             record = middle.Record;
             acct = RecordClass.getAccountIdCliente(record.idCliente);
            
             op = getOpportunityContactado(acct[0]);
             op[0].Api_Name__c = 'APIV2'; 
             op[0].Tipo_de_Registro__c = account.Tipo_de_Registro__c;
             op[0].StageName = Stage;
             if(record.origen != null){
                op[0].LeadSource = record.origen;
             }
             op[0].Description = account.Description;
             op[0].Ultima_Fecha_Ingreso__c = DateTime.now();
            update op[0];
        }catch(Exception e){
            throw new CustomException('Error al modificar la oportunidad en la funcion updateOpportunityWithOutIdOpStage ' +  e.getMessage());
        }
         return op[0];
    }
    
    public static Opportunity createdOpportunityOtherStage(Account account, MiddlewareClass  middle, Boolean leadConvertido, String Stage){
        System.debug('createdOpportunityOtherStage');
        Opportunity op = new Opportunity();
        RecordClass record = new RecordClass();
        
         try{
            
            record = middle.Record;
            op.AccountId = account.Id;
            op.Api_Name__c = 'APIV2';
            if(record.tipoGestion != null){
                op.Tipo_de_Registro__c = record.tipoGestion;
            }
            if(record.origen != null){
                op.Primer_Origen__c = record.origen;
                op.LeadSource = record.origen;
            }
            
            op.Ultima_Fecha_Ingreso__c = DateTime.now();
            if(record.tienda != null){
                op.Oportunidad_Visor__c = True;
            }
            op.Name = record.nombre + ' ' + record.apellidos;
            op.StageName = Stage;
            op.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
            op.CloseDate = Date.today().addMonths(1);
            op.IdCliente__c = record.empresa + '_' + record.identificacion;
            if(leadConvertido){
                op.Convertido__c = true;
            }
             
             
            insert op;
        }catch(Exception e){
            throw new CustomException('Error al insertar la oportunidad en la funcion createdOpportunityOtherStage ' +  e.getMessage());
        }
        return op;
    }
    
    
    public static Opportunity createdOpportunityWithIdOp(Account account, MiddlewareClass  middle, Boolean leadConvertido){
        System.debug('createdOpportunityWithIdOp');
        Opportunity ops = new Opportunity();
        OpportunityClass transformMiddle = new OpportunityClass();
        RecordClass record = new RecordClass();
        List<Pricebook2> listaPrecios = getListaPrecios();
        Map<String, Agencia__c> mapAgencias = RecordClass.getAgencias();
        Map<String, Departamento__c> mapDepartamentos = RecordClass.getDepartmento();
        
        
        try{
            record = middle.Record;
        	transformMiddle = middle.Oportunidad;
            String idTROpp = '';
            if(transformMiddle.tipoOportunidad == 'Contado'){
                System.debug(' ** TIPO CONTADO ** ');
                 idTROpp = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Contado').getRecordTypeId();
            }else{
                System.debug(' ** TIPO CREDITO ** ');
                 idTROpp = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Venta Crédito').getRecordTypeId();
            }
            ops.Api_Name__c = 'APIV2';
            ops.Canal_de_Atencion__c = transformMiddle.canalAtencion;
            ops.Etapa_Entrega__c = transformMiddle.etapaEntrega;
            ops.Causal_Desiste__c = transformMiddle.causalDesiste;
            ops.Recoge_en_Tienda__c = transformMiddle.recogerTienda;
            ops.Origen_Venta__c = transformMiddle.origenVenta;
            ops.AccountId = account.Id;
            ops.RecordTypeId = idTROpp;
            ops.Name = record.nombre + ' ' + record.apellidos;
            ops.StageName = transformMiddle.etapa;

            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Inicio ---
            if(transformMiddle.completation_Stage != null){
                ops.CompletionStages__c = transformMiddle.completation_Stage;
            }
            if(transformMiddle.tipo_Validacion != null){
                ops.Tipo_Validacion__c = transformMiddle.tipo_Validacion;
            }
            if(transformMiddle.tipo_Firma != null){
                ops.Tipo_Firma__c = transformMiddle.tipo_Firma;
            }
            // --- JCASTRO 23/11/2022: Agregar campos para proceso de Desborde Fin ---

            ops.VentaTotal__c = transformMiddle.ventaTotal;
            ops.Seguro__c = transformMiddle.seguro;
            ops.CloseDate = transformMiddle.fechaCierre;
            if(transformMiddle.agenciaPedido != null){
                ops.AgenciaPedido__c = mapAgencias.get(transformMiddle.agenciaPedido).Id;
            }
            if(transformMiddle.agenciaVendedor != null){
                ops.Agencia_Vendedor__c = mapAgencias.get(transformMiddle.agenciaVendedor).Id;
            }
            
            ops.LinkCalificacionLargo__c = transformMiddle.LinkCalificacionLargo;
            //BRIAN
            ops.LinkCalificacionCorto__c = transformMiddle.LinkCalificacionCorto;
            //BRIAN
            ops.Periodo__c = transformMiddle.periodo;
            ops.Accion_Sugerida__c = transformMiddle.accionSugerida;
            ops.CodigoVendedor__c = transformMiddle.codigoVendedor;
            ops.NombreDeVendedor__c = transformMiddle.nombreVendedor;
            ops.EmisionOrdenPedido__c = transformMiddle.emisionOrdenPedido;
            ops.Cuotas__c = transformMiddle.cuotas;
            ops.DireccionDeDespacho__c = transformMiddle.direccionDespacho;
            ops.EstadoOrdenPedido__c = transformMiddle.estadoOrdenPedido;
            ops.Id_Cotizacion__c = transformMiddle.idCotizacion;
            ops.IdEstudio__c = transformMiddle.idEstudio;
            ops.EtapaDelCredito__c = transformMiddle.etapaCredito;
            //ops.ExisteEnInventario__c = transformMiddle.existeInventario;
            ops.ExisteEnInventario__c = transformMiddle.existeInventario != null ? transformMiddle.existeInventario : false;
            ops.CotizacionPedidoEnviada__c = transformMiddle.cotizacionPedidoEnviada;
            ops.CompletacionDeCredito__c = transformMiddle.completacionCredito;
            ops.ConcatPendCred__c = transformMiddle.completacionCredito;
            ops.OrdenPedidoAprobada__c = transformMiddle.ordenPedidoAprobada;
            ops.FechaEntrega__c = transformMiddle.fechaEntrega;
            ops.PIN__c = transformMiddle.pin;
            ops.PropuestaDePago__c = transformMiddle.propuestaPago;
            ops.PedidoFaturado__c = transformMiddle.pedidoFactura;
            ops.Cerrada__c = transformMiddle.cerrada;
            ops.MotivoDePerdida__c = transformMiddle.motivoPerdida;
            ops.IdOP__c = transformMiddle.idOP;
            //ops.Pricebook2Id = '01sf2000001lc6fAAA';
            ops.Pricebook2Id = listaPrecios[0].Id;
            ops.LeadSource = transformMiddle.origen;
            ops.TipoDePago__c = transformMiddle.tipoPago;
            ops.FechaFacturacion__c = transformMiddle.fechaFacturacion;
            ops.IdCliente__c = transformMiddle.idCliente;
            ops.FechaCompletacionCredito__c = transformMiddle.fechaCompletacionCredito;
            ops.FechaAprobacion__c = transformMiddle.fechaAprobacion;
            ops.FechaEnvioCotizacion__c = transformMiddle.fechaCreacionOP;
            ops.Type = transformMiddle.tipoVenta;
            ops.Numero_OP__c = String.valueOf(transformMiddle.numeroOrdenPedido);
            ops.Primer_Origen__c = transformMiddle.origen;
            ops.Codigo_Aprobacion__c = transformMiddle.codigoAprobacion;
            if(leadConvertido){
                ops.Convertido__c = true;
            }
            ops.Ultima_Fecha_Ingreso__c = DateTime.now();
            ops.Tipo_de_Registro__c = transformMiddle.tipoGestion;
            ops.Ejecutivo_de_Credito__c = transformMiddle.ejecutivoCredito;
            ops.Ultima_Fecha_de_Pre_Calificacion__c = transformMiddle.ultimaFechaPrecalificacion;
            ops.Valor_orden_de_pedido_con_pase_saldo__c = transformMiddle.valorOrdenConPaseSaldo;
            ops.Valor_orden_de_pedido_de_financiacion__c = transformMiddle.valorOrdenSinFinanciacion;
            
            
            System.debug(' ** ETAPA OP ** ' + ops.StageName);
            System.debug(' ** MOTIVO PERDIDA ** ' + ops.MotivoDePerdida__c);
            if(transformMiddle.listoFacturarFecha != null){
                ops.Listo_Facturar_Fecha__c = transformMiddle.listoFacturarFecha;
            }
            if(transformMiddle.listoFacturar != null){
                ops.Listo_a_Factruar__c = transformMiddle.listoFacturar;
            }
            if(transformMiddle.fechaDespacho != null){
                ops.Fecha_Despacho__c = transformMiddle.fechaDespacho;
            }
            if(transformMiddle.citaEntrega != null){
                ops.Cita_Entrega__c = transformMiddle.citaEntrega;
            }
            if(transformMiddle.opDeTercero != null){
                ops.OP_de_terceros__c = transformMiddle.opDeTercero;
            }
            insert ops;
        }
        catch(Exception e){
            throw new CustomException('Error al insertar el registro de oportunidad ' +  e.getMessage());
        }
        
        return ops;
    }
    
    public static List<Pricebook2> getListaPrecios(){
           List<Pricebook2> listaPrecios = new List<Pricebook2>();
		   listaPrecios = [SELECT Id FROM Pricebook2];
           return listaPrecios;
    }
    
    public static String format(List<String> values) {
            if (values == null) return null;
            return String.join(values, ';');
	}
    
    
}