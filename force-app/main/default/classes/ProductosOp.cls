public class ProductosOp {
    @invocablevariable(Label='ID_OP' required=true)
                public string idOp;
    
    public ProductosOp(){}
     public ProductosOp(String idOp){
           this.idOp = idOp;             
                    }
   
     @InvocableMethod (label='Productos de la Op')
    public static List<String> Quantity(list<ProductosOp> Cantidad){
        String idOp= Cantidad[0].idOp;
        List<String> datosOp = new List<String>();
        list <String> Answerx = new list<String>();
        for(String st : idOp.split('_')){         
                datosOp.add(st);
            }
        String empresa = datosOp[0];
        String method = 'GET';
        List<String> output = new List<String>();
        List<OpportunityLineItem> Productos = [SELECT IdProducto__c,Display_Url__c,Armable__c,Aplica_garantia__c FROM OpportunityLineItem WHERE IdOP__c = :idOp];
        for(Integer i  = 0; i < Productos.size(); i++ ){
                        String productCodeString = Productos[i].IdProducto__c;
            for(Product2 prd : [SELECT DisplayUrl,ProductCode,Armable__c,Aplica_garantia__c FROM Product2 WHERE IdProducto__c = :productCodeString]){
                if(prd.DisplayUrl == null){
                    String url = 'https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/'+empresa+'/products/'+ prd.ProductCode+'/images';
                    System.debug(url);
                    try{
                        HttpResponse response = JamarConsumoHTTP.callServiceExternal(url,null, method,null);
                        Answerx.add(response.getBody());
                        System.debug(Answerx);
                        String data = Answerx[0];
                        System.debug(data);
                        List<JamarInterfaceProductosOp.Producto> IProductList = new List <JamarInterfaceProductosOp.Producto>();	
                        IProductList = JamarInterfaceProductosOp.parse(data);
                        System.debug(IProductList);
                        for(Integer j = 0; j<IProductList.size();j++){
                            if(IProductList[i].type =='PrimaryProductImage'){
                                Productos[i].Display_Url__c = IProductList[i].public_url;
                                Productos[i].Armable__c = prd.Armable__c;
                                Productos[i].Aplica_garantia__c = prd.Aplica_garantia__c;
                                System.debug(Productos);
                                Update Productos;
                            } 
                        }
                    }catch(Exception e){
                        Log__c log = new Log__c();
                        log.ClassName__c = 'Service - Productos de la Op';
                        log.date__c = Datetime.now();
                        log.message__c = 'Error en obtener infomracion: ' + e.getMessage() + url;
                        log.success__c = false;
                        log.type__c = 'Consumo en ws';
                        log.JSON__c = url;
                        //log.Empresa__c = empresa;
                        insert log; 
                    }                    
                }else if(Productos[i].Display_Url__c == null){                    
                    Productos[i].Display_Url__c = prd.DisplayUrl;
                    Productos[i].Armable__c = prd.Armable__c;
                    Productos[i].Aplica_garantia__c = prd.Aplica_garantia__c;
                    Update Productos;
                }else if(Productos[i].Aplica_garantia__c == null){
                     Productos[i].Armable__c = prd.Armable__c;
                     Productos[i].Aplica_garantia__c = prd.Aplica_garantia__c;
                     Update Productos;
                }else if(Productos[i].Armable__c == false){
                        Productos[i].Armable__c = prd.Armable__c;
                        Update Productos;
                    }                
            }
       }
        return null;
    }
}