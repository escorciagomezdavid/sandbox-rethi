public class ProcesaRespuestaPrecalificacion {
    
    @invocablevariable(Label='Response Servicio Precalificacion' required=true)
    public string response_service;
    
    public ProcesaRespuestaPrecalificacion(){}
    public ProcesaRespuestaPrecalificacion(String response_service){
        this.response_service = response_service;  
    }
    
    @invocableMethod(label = 'ProcesaRespuestaPrecalificacion')
    public static list<String> processResponse(list<ProcesaRespuestaPrecalificacion> procesaRespuestaPrecalificacion){
        list<String> lstResponse = new list<String>();
        String response =  procesaRespuestaPrecalificacion[0].response_service;
        
        IRespuestaPrecalificacion response_parse = IRespuestaPrecalificacion.parse(response);
        
        if(response_parse.success != null){
            lstResponse.add(response);
            System.debug(lstResponse);
            if(response_parse.success == true){
                
                Map<String, Object> objson = new Map<String, Object>();
                String response_ps_nuCodError = String.valueOf(response_parse.ps_nuCodError);
                String message = response_parse.ps_vcMensError + ' ' + 'Codigo Error: ' + response_ps_nuCodError;
                objson.put('deatil',message);
                String body = String.valueOf(JSON.Serialize(objson));
                lstResponse.add(response);
            }
            return lstResponse;
        }else{
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(response);
            String dataResponse = String.valueOf(jsonParseds.get('detail'));
            if(dataResponse != null && dataResponse != ''){
                lstResponse.add(response);
            }else{
                Map<String, Object> objson = new Map<String, Object>();
                objson.put('detail','Error no controlado por favor validar con Sistemas');
                String body = String.valueOf(JSON.Serialize(objson));
                lstResponse.add(body);
            }
            
        }
        
        return lstResponse;
    }
    
}