public class JamarConsultaFechasEntrega {
    
    @invocablevariable(Label='Empresa' required=true)
    public string empresa;
    @invocablevariable(Label='ID_OP' required=true)
    public string idOp;
    @invocablevariable(Label='tipo de Orden' required=true)
    public string tipo;
    
    public JamarConsultaFechasEntrega(){
        
    }
    public JamarConsultaFechasEntrega(String empresa, String idOp, String tipo){
        this.empresa = empresa;
        this.idOp = idOp;
        this.tipo = tipo;               
    }
    
    @InvocableMethod (label='Consultar Fecha de Entrega')
    public static List<response> ConsultaEntrega(list<JamarConsultaFechasEntrega> JamarConsultaFechaEntrega){
        list <String> Answerx = new list<String>();
        list <response> value = new list<response>();
        response rp = new response();
        String empresa = JamarConsultaFechaEntrega[0].empresa;
        String tipo = JamarConsultaFechaEntrega[0].tipo;
        String idOp = JamarConsultaFechaEntrega[0].idOp;
        String body = '';
        List<String> datosOp = new List<String>();
        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String Op = datosOp[3];

        try{
            String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
            String url= endPoint + empresa +'/delivery-date'; 
            String method = 'POST';
            Map<String, Object> objson = new Map<String, Object>();
            objson.put('numOrden',Op);
            objson.put('numCantCitas','6');
            objson.put('tipoDoc',tipo);
            
            System.debug(objson);
            body = String.valueOf(JSON.Serialize(objson));
            System.debug(body);
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, body, method,null);
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            
            Object dataResponse = jsonParseds.get('response');
            String str = JSON.serialize(dataResponse);
            System.debug(str);
            Integer erroCode = Integer.valueOf(jsonParseds.get('erroCode'));
            System.debug(erroCode);
            String substring1 = str.substringBefore('message');
            String fin = substring1.removeEnd('"');
            String substring2 = fin.substringAfter('data');
            String inicio1 = substring2.removeStart('"');
            String inicio2 = inicio1.removeStart(':');
            String exception1 = inicio2.removeStart('[{');
            String exception2 = exception1.removeEnd('}],');
            System.debug(exception2);
            System.debug(inicio2);
            if(exception2 == ''){
                rp.calendario = 'No Hay Calendario';
                value.add(rp);
                System.debug(value);
                return value;
            }else{
                List<JamarInterfaceFechasEntregas> IFechasList = new List <JamarInterfaceFechasEntregas>();	
                IFechasList = JamarInterfaceFechasEntregas.parse(inicio2);
                System.debug(IFechasList[0].Fechas[0].Fecha);
                String dataFinalForComponent = '';
                for(Integer i=0; i <IFechasList[0].Fechas.size(); i++ ){
                    String valor = String.valueOf(IFechasList[0].Fechas[i].Fecha); //2021-09-13
                    Date x = Date.valueOf(valor);
                    DateTime dt = DateTime.newInstance(x.year(), x.month(),x.day());
                    String format = 'EEEE,dd-MMMM-YYYY';
                    String fecha = dt.format(format);
                    String diaSub= fecha.substringBefore(',');
                    String fechaF = fecha.substringAfter(',');
                    List<String> fechaList = new List<String>();
                    for(String st : fechaF.split('-')){         
                        fechaList.add(st);
                    }
                    String dia = fechaList[0];
                    String mes = fechaList[1];
                    String ano = fechaList[2];
                    System.debug(fecha);
                    String mesSpanish = meses(mes);
                    String diaSpanish = dias(diaSub);
                    String fechaFormateada = diaSpanish+','+dia+'-'+mesSpanish+'-'+ano;
                    dataFinalForComponent = dataFinalForComponent + ';' +fechaFormateada;
                } 
                System.debug(dataFinalForComponent);
                String calendar = dataFinalForComponent.substring(1);           
                rp.calendario = calendar;
                value.add(rp);
                return value;                    
            }			
        }catch(Exception e){
            System.debug(e);
            Log__c log = new Log__c();
            log.ClassName__c = 'Consulta_Cita_Entrega';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = body;
            //log.Empresa__c = empresa;
            insert log; 
        }        
        return value;
    }
    
    public class Producto{
        public String codigo_producto;
        public String cantidad_producto;
        public Boolean agregar;
    }
    
    public class response{
        @invocablevariable(Label='calendario' required=true)
        public String calendario;
    }
    
    public static String meses (string fecha){
        Map<String,String> meses = new Map<String,String>();
        String mes;
        meses.put('January','Enero');
        meses.put('February','Febrero');
        meses.put('March','Marzo');
        meses.put('April','Abril');
        meses.put('May','Mayo');
        meses.put('June','Junio');
        meses.put('July','Julio');
        meses.put('August','Agosto');
        meses.put('September','Septiembre');
        meses.put('October','Octubre');
        meses.put('November','Noviembre');
        meses.put('December','Diciembre');
        
        for(String m : meses.keySet()){
            if(m == fecha){
                mes = meses.get(m);
            }
        }
        return mes;
    }
    
    public static String dias (string fecha){
        Map<String,String> semana = new Map<String,String>();
        String dia;
        semana.put('Monday','Lunes');
        semana.put('Tuesday','Martes');
        semana.put('Wednesday','Miercoles');
        semana.put('Thursday','Jueves');
        semana.put('Friday','Viernes');
        semana.put('Saturday','Sabado');
        semana.put('Sunday','Domingo');
        
        for(String m : semana.keySet()){
            if(m == fecha){
                dia = semana.get(m);
            }
        }
        return dia;
    }
    
}