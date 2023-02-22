public class ObtenerTipoContrato  {
    @InvocableMethod(Label='Obtener Tipo Contrado')
    public static list<String> getTipoContrato(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'contract_type';
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}