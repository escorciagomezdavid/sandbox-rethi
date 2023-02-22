public class ProductQuoteClass {
    private String idCotizacionDetalle;
    private String idCotizacion;
    private String empresa;
    private Integer cantidad;
    private double numeroCuotas;
    private Double valorCuotas;
    private String  estadoCotizacion;
    private String usuarioAnulacion;
    private String usuarioCreacion;
    private String usuarioModificacion;
    private Date fechaAnulacion;
    private String codigoProducto;
    private Double valor;
    private Double valorF;

    public ProductQuoteClass() {

    }
    
    public static List<QuoteLineItem> createdProductQuote(MiddlewareClass middle, Quote qt){
        Map<String, Product2> mapProd = new Map<String, Product2>();
        Set<String> setIdsProd = new Set<String>();
        List<ProductQuoteClass> productQuote = new List<ProductQuoteClass>();
        Map<String, PricebookEntry> mapListaPrecios = new Map<String, PricebookEntry>();
        List<QuoteLineItem> productQuotes = new List<QuoteLineItem>();
        try{
             	List<Opportunity> op = OpportunityClass.getOpportunityId(qt.OpportunityId);
                System.debug(op[0].Id);
                productQuote = middle.ProductosQuote;
                for(ProductQuoteClass p : productQuote){
                    setIdsProd.add(p.codigoProducto);
                }
                for(Product2 p : [SELECT Id, ProductCode, IdProducto__c, Description FROM Product2 WHERE IdProducto__c IN : setIdsProd]){
                    mapProd.put(p.IdProducto__c, p);
                }
                for(PricebookEntry pbe : [SELECT Id, Product2.IdProducto__c, UnitPrice FROM PricebookEntry WHERE Product2.IdProducto__c IN : setIdsProd]){
                    System.debug('Lista de Precio');
                    System.debug(pbe);
                    mapListaPrecios.put(pbe.Product2.IdProducto__c, pbe);
                }
                for(ProductQuoteClass item: productQuote ){
                    QuoteLineItem quoteProduct  = new QuoteLineItem();
                    item.valor = item.valor != null ? item.valor : 0;
                    item.valorF = item.valorF != null ? item.valorF : 0;
                    quoteProduct.QuoteId = qt.Id;
                    quoteProduct.Empresa__c = item.empresa;
                    quoteProduct.Id_detalle_Cotizacion__c  = item.idCotizacionDetalle;
                    quoteProduct.Id_Cotizacion__c  = item.idCotizacion;
                    quoteProduct.Quantity  = item.cantidad;
                    quoteProduct.Numero_de_cuotas__c  = item.numeroCuotas;
                    quoteProduct.Valor_cuotas__c  = item.valorCuotas;
                    quoteProduct.Estado_Cotizacion__c  = item.estadoCotizacion;
                    quoteProduct.Usuario_de_Anulacion__c  = item.usuarioAnulacion;
                    quoteProduct.Fecha_de_Anulacion__c  = item.fechaAnulacion;
                    quoteProduct.Product2Id = mapProd.get(item.codigoProducto).Id;
                    quoteProduct.PricebookEntryId = mapListaPrecios.get(item.codigoProducto).Id;
                    quoteProduct.UnitPrice = (item.valor / item.cantidad);
                    quoteProduct.Usuario_Creaci_n__c = item.usuarioCreacion;
                    quoteProduct.Usuario_Modificacion__c = item.usuarioModificacion;
                    quoteProduct.Precio_Full__c = item.valorF;
                    productQuotes.add(quoteProduct);
                    
                }
                if(!productQuotes.isEmpty() && productQuotes.size() > 0){
                    insert productQuotes;
                }
        }catch(Exception e){
            throw new CustomException('Error al tartar el producto de  la cotizacion en la funcion createdProductQuote ' +  e.getMessage());
        }
        return productQuotes;
    }
    
    
}