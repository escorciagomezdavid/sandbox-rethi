public class ObtenerActividades {
	@invocablevariable(Label='cod_ocupacion' required=true)
    public string cod_ocupacion;

	public ObtenerActividades(){}
    public ObtenerActividades(String cod_ocupacion){
        this.cod_ocupacion = cod_ocupacion; 
    }

    @InvocableMethod(Label='Obtener Actividades Independiente')
    public static list<String> getActividades(list<ObtenerActividades> obtenerActividades){
        String cod_ocu = obtenerActividades[0].cod_ocupacion;
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c + 'activities/' + cod_ocu;
        HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, '', 'GET',null);
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}