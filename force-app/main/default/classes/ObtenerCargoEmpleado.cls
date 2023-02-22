public class ObtenerCargoEmpleado  {

    @InvocableMethod(Label='Obtener Cargo')
    public static list<String> getCargo(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'job_titles';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}