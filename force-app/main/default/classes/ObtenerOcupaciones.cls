public class ObtenerOcupaciones  {

    @InvocableMethod(Label='Obtener Ocupaciones')
    public static list<String> getOcupacion(){
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'occupations'; 
        HttpResponse response =JamarConsumoHTTP.callServiceExternalWithTimeOut(url, '', 'GET', '30000');
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}