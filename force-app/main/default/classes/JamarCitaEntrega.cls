public class JamarCitaEntrega {
    
    @invocablevariable(Label='idOp' required=true)
    public string idOp;
    @invocablevariable(Label='tipoDoc' required=true)
    public string tipoDoc;
    @invocablevariable(Label='fechaCita' required=true)
    public string citaEntrega;
    @invocablevariable(Label='comprometeMercancia' required=true)
    public string comprMcia;
    @invocablevariable(Label='usuarioOperacion' required=true)
    public string userOperacion;
    
    public JamarCitaEntrega(){}
    public JamarCitaEntrega(String idOp,String tipoDoc, String citaEntrega, String comprMcia, String userOperacion){
        this.idOp = idOp;
        this.tipoDoc = tipoDoc;
        this.citaEntrega = citaEntrega;
        this.comprMcia = comprMcia;
        this.userOperacion = userOperacion;  
    }
    
    @InvocableMethod (label='AsignarCitaEntrega')
    public static list<String> AsignarCitaEntrega (list<JamarCitaEntrega> JamarCitaEntrega){
        
        list <String> value = new list<String>();
        list <String> Answerx = new list<String>();
        
        
        String idOp    =JamarCitaEntrega[0].idOp;
        String tipoDoc = JamarCitaEntrega[0].tipoDoc;
        String citaEntrega = JamarCitaEntrega[0].citaEntrega;
        String comprMcia = JamarCitaEntrega[0].comprMcia;
        String origenOperacion = 'SALESFORCE';
        String userOperacion = JamarCitaEntrega[0].userOperacion;
        
        /* Formatos de fecha para enviar al servicio de AWS y Salesforce **/
        String formato = citaEntrega.substringAfter(',');
        List<String> fechaList = new List<String>();
        for(String st : formato.split('-')){         
            fechaList.add(st);
        }
        String dia = fechaList[0];
        String mes = fechaList[1];
        String ano = fechaList[2];  
        String mesNum = meses(mes);
        System.debug(mesNum);
        String format_citaEntrega = dia+'/'+mesNum+'/'+ano;
        String format_SF = ano+'-'+mesNum+'-'+dia;
        System.debug(format_citaEntrega);  
        System.debug(format_SF);
        Date format_cita_SF = date.valueOf(format_SF);
        System.debug(format_cita_SF);
        /* Asignacion de datos de la Op a las variables**/
        List<String> datosOp = new List<String>();
        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String empresa = datosOp[0];
        String agencia = datosOp[1];
        String periodo = datosOp[2];
        String Op = datosOp[3]; 
        
        try{
            String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
            String url = endPoint + empresa + '/asignarCitaEntrega';
            Map<String, Object> objson = new Map<String, Object>();
            objson.put('agencia',agencia);
            objson.put('periodo',periodo);
            objson.put('numOp',Op);
            objson.put('tipoDoc',tipoDoc);
            objson.put('citaEntrega',format_citaEntrega);
            objson.put('comprMcia', comprMcia);
            objson.put('origenOper',origenOperacion);
            objson.put('userOper', userOperacion);
            String body = String.valueOf(JSON.Serialize(objson));        
            HttpResponse response2 =JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
            Answerx.add(response2.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            String mensajeCita = String.ValueOf(jsonParseds.get('ps_vcmenserror'));
            value.add(mensajeCita);
            return value;
        }catch(Exception e){
            System.debug(e);
        }
        return value;               
    } 
    public static String meses (string fecha){
        Map<String,String> meses = new Map<String,String>();
        String mes;
        meses.put('Enero','01');
        meses.put('Febrero','02');
        meses.put('Marzo','03');
        meses.put('Abril','04');
        meses.put('Mayo','05');
        meses.put('Junio','06');
        meses.put('Julio','07');
        meses.put('Agosto','08');
        meses.put('Septiembre','09');
        meses.put('Octubre','10');
        meses.put('Noviembre','11');
        meses.put('Diciembre','12');
        
        for(String m : meses.keySet()){
            if(m == fecha){
                mes = meses.get(m);
            }
        }
        return mes;
    }
    
}