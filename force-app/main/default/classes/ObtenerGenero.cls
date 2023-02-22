public class ObtenerGenero  {

    @InvocableMethod(Label='Obtener Genero')
    public static list<String> getGenre(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'genero';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}