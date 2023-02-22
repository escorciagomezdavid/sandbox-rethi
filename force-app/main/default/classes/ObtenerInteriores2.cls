public class ObtenerInteriores2 {

    @InvocableMethod(Label='Obtener interiores 2')
    public static list<String> ObtenerInteriores2() {
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'interiors_2/JA';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}