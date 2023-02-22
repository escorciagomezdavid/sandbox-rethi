public with sharing class ActualizarOpAurora {
    @invocablevariable(Label='numOp' required=true)
    public string numOp;
    @invocablevariable(Label='identificacion' required=true)
    public string identificacion;

    public ActualizarOpAurora() {}
    public ActualizarOpAurora(String numOp, String identificacion) {
        this.numOp          = numOp;
        this.identificacion = identificacion;
    }

    @InvocableMethod(label = 'Crear Op desde Aurora')
    public static list <String> ActualizarOp(list<ActualizarOpAurora> ActualizarOpAurora) {
        list <String> value = new list<String>();
        list <String> Answerx = new list<String>();
        
        String numOp            = ActualizarOpAurora[0].numOp;
        String identificacion   = ActualizarOpAurora[0].identificacion;
        
        try{
            String url = Endpoint__mdt.getInstance('Validacion_Op').URL__c + numOp;
            Map<String, Object> objson = new Map<String, Object>();

            objson.put('identificacion', identificacion);
            
            String body = String.valueOf(JSON.Serialize(objson));
            
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            String disponible = String.ValueOf(jsonParseds.get('disponible'));
            value.add(disponible);
            return value;
        }catch(Exception e){
            System.debug(e);
        }
        return value;
    }
}