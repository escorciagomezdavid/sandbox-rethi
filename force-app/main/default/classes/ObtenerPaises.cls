public class ObtenerPaises {
    @InvocableMethod(Label='Obtener Paises')
    public static list<String> getPaises(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'paises/JA';
        HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}