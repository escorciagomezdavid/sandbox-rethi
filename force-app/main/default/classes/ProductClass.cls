public class ProductClass {
    
    public String idProducto;
    public String idOp;
    public String descripcionProducto;
    public Integer cantidad;
    public double precioSinDescuento;
    public double porcentajeDescuento;
    public double diasGarantia;
    public String aplicaCambio;
    public String obsequio;
    public double valor;
    public String idDetalleOp;
    public double valorDescuento;
    public String n_ideProveedor;
    public String nomProveedor;
    
    public ProductClass() {
    }
    
    public static List<OpportunityLineItem> producTratament(MiddlewareClass middle){
        System.debug('ProductClass > producTratament() > middle' + middle);
		Boolean existe = false;
        List<OpportunityLineItem> listProdOpUpdate = new List<OpportunityLineItem>();
        Set<String> idsProdEliminar = new Set<String>();
        Set<String> setIdsProd = new Set<String>();
        Map<String, Product2> mapProd = new Map<String, Product2>();
        Map<String, PricebookEntry> mapListaPrecios = new Map<String, PricebookEntry>();
        List<OpportunityLineItem> productOpportunity  = new List<OpportunityLineItem>();
        Map<id,OpportunityLineItem> listProdOpUpdateUnique = new Map<id,OpportunityLineItem>();
        List<OpportunityLineItem> listProdOp = new List<OpportunityLineItem>();
        List<ProductClass> products = new List<ProductClass>();
        RecordClass record = new RecordClass();
         
        
        try{
            record = middle.Record;
            System.debug('36 record: ' + record);

            List<Account> accountRecord = RecordClass.getAccountIdCliente(record.idCliente);
            List<Opportunity> oportunidadProductos = new List<Opportunity>();
            oportunidadProductos = OpportunityClass.getOpportunityWithIdOp(middle);
            System.debug('41 oportunidadProductos: ' + oportunidadProductos);

            if(oportunidadProductos.isEmpty() && oportunidadProductos.size() == 0){
                oportunidadProductos = OpportunityClass.getOpportunityContactado(accountRecord[0]);
            }
            products  = middle.Productos;
            System.debug('47 products: ' + products);

            for(ProductClass p : products){
                setIdsProd.add(p.idProducto);
            }
            System.debug('52 setIdsProd: ' + setIdsProd);

            for(Product2 p : [SELECT Id, ProductCode, IdProducto__c, Description FROM Product2 WHERE IdProducto__c IN : setIdsProd]){
                mapProd.put(p.IdProducto__c, p);
            }
            System.debug('57 mapProd: ' + mapProd);

            for(PricebookEntry pbe : [SELECT Id, Product2.IdProducto__c FROM PricebookEntry WHERE Product2.IdProducto__c IN : setIdsProd]){
                mapListaPrecios.put(pbe.Product2.IdProducto__c, pbe);
            }
            System.debug('62 mapListaPrecios: ' + mapListaPrecios);

            List<OpportunityLineItem> listProductosExistentes =  getOpportunityLineItemWithId(oportunidadProductos[0]);
                for(ProductClass p : products){
                    OpportunityLineItem prod = new OpportunityLineItem();
                    prod.OpportunityId = oportunidadProductos[0].Id;
                    prod.Api_Name__c = 'APIV2';
                    prod.Product2Id = mapProd.get(p.idProducto).Id;
                    prod.Quantity = p.cantidad;
                    prod.Description = mapProd.get(p.idProducto).Description;
                    prod.PricebookEntryId = mapListaPrecios.get(p.idProducto).Id;
                    prod.TotalPrice = p.valor;
                    prod.IdProducto__c = p.idProducto;
                    prod.IdDetalleOP__c = p.idDetalleOP;
                    prod.IdOP__c = p.idOP;
                    prod.n_ideProveedor__c = p.n_ideProveedor;
                    prod.nomProveedor__c = p.nomProveedor;
                    listProdOp.add(prod);
                }
            
            System.debug('80 listProductosExistentes: ' + listProductosExistentes);
            
            if(!listProductosExistentes.isEmpty() && listProductosExistentes.size() > 0){
                delete listProductosExistentes;
            }

            System.debug('86 listProdOp: ' + listProdOp);

            if(!listProdOp.isEmpty() && listProdOp.size() > 0){
                insert listProdOp;
            }
        }catch(Exception e){
            throw new CustomException('Error en el tratamiento del producto de la oportunidad funcion producTratament ' +  e.getMessage() + '. Linea: ' +  e.getLineNumber());
        }
        return productOpportunity;
    }
    
    public static List<OpportunityLineItem> getOpportunityLineItemWithId(Opportunity op){
        List<OpportunityLineItem> productOpportunity  = new List<OpportunityLineItem>();
        productOpportunity = [SELECT Product2Id, Quantity, Description, PricebookEntryId, TotalPrice, IdProducto__c, IdDetalleOP__c, IdOP__c FROM OpportunityLineItem WHERE OpportunityId =: op.Id];
        return productOpportunity;
    }
    
    
}