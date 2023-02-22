public class ObtenerInteriores1 {

    @InvocableMethod(Label='Obtener interiores 1')
    public static list<String> getInteriores1() {
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'interiors_1/JA';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}