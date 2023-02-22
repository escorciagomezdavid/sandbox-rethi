public class ObtenerVias  {

    @InvocableMethod(Label='Obtener Via')
    public static list<String> getVia(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/ways';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}