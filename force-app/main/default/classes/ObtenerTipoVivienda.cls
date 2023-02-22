public class ObtenerTipoVivienda  {

     @InvocableMethod(Label='Obtener Tipo Vivienda')
    public static list<String> getTypeHousing(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'type_housing';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}