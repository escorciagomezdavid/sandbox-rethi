public class ObtenerBarrios  {

    @invocablevariable(Label='cod_departamento' required=true)
    public string cod_departamento;
    @invocablevariable(Label='cod_ciudad' required=true)
    public string cod_ciudad;
    
    
    public ObtenerBarrios(){}
    public ObtenerBarrios(String cod_departamento, String cod_ciudad){
        this.cod_departamento = cod_departamento; 
        this.cod_ciudad = cod_ciudad; 
    }


    @InvocableMethod(Label='Obtener Barrios')
    public static list<String> getBarrios(list<ObtenerBarrios> obtenerBarrios){
        String cod_dep = obtenerBarrios[0].cod_departamento;
        String cod_ciudad = obtenerBarrios[0].cod_ciudad;
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c + 'address/neighborhood/' + cod_dep + '/' + cod_ciudad;
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}