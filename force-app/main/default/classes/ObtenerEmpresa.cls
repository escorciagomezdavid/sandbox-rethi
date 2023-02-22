public class ObtenerEmpresa  {
    
    @InvocableVariable(Label='empresa' required=True)
    public String empresa;
    
    public ObtenerEmpresa(){}
    public ObtenerEmpresa(String empresa){
        this.empresa = empresa;
    }
    
    @InvocableMethod(Label='Obtener empresa')
    public static list<String> getEmpresa(List<ObtenerEmpresa> obtenerEmpresa){
        String empresa = obtenerEmpresa[0].empresa;
        empresa = empresa.toUpperCase();
        String url = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'enterprise_list/?nom_empresa=' + empresa;
        System.debug(url);
        HttpResponse response =JamarConsumoHTTP.callServiceExternalWithTimeOut(url, '', 'GET', '30000');
        list<String> lstResponse = new list<String>();
        lstResponse.add(response.getBody());
        return lstResponse;
    }
}