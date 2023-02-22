public class ObtenerEstadoCivil  {
    @InvocableMethod(Label='Obtener Estado Civil')
    public static list<String> getEstadoCivil(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'estado_civil';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}