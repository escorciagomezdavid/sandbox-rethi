public class ObtenerDepartamentos  {

    @InvocableMethod(Label='Obtener Departamento')
    public static list<String> getState(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/departments';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}