public class ObtenerTipoCotizantes {
    
    
    @InvocableMethod(Label='Obtener Cotizantes')
    public static list<String> getTypeCotizantes(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'contributor_list';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }

}