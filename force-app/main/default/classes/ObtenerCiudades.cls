public class ObtenerCiudades  {

    @invocablevariable(Label='cod_departamento' required=true)
    public string cod_departamento;

    public ObtenerCiudades(){}
    public ObtenerCiudades(String cod_departamento){
        this.cod_departamento = cod_departamento;  
    }

    @InvocableMethod(Label='Obtener Ciudades')
    public static list<String> getCities(list<ObtenerCiudades> obtenerCiudades){
        String cod_dep = obtenerCiudades[0].cod_departamento;
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/cities/' + cod_dep;
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}