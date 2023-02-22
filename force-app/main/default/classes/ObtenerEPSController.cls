public class ObtenerEPSController  {
    @InvocableMethod(Label='Obtener EPS')
    public static list<String> getEPS() {
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'eps_list';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}