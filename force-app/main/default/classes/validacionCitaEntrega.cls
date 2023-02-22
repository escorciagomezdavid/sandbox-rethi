public class validacionCitaEntrega {
    @invocablevariable(Label='idOp' required=true)
    public string idOp;
    @invocablevariable(Label='fechaCita' required=true)
    public string citaEntrega;
    
    public class response{
        @invocablevariable(Label='mensaje de confirmacion' required=true)
        public string confirmacion;
        @invocablevariable(Label='fecha' required=true)
        public Date Fecha;
    }
    public validacionCitaEntrega(){}
    public validacionCitaEntrega(String idOp,String citaEntrega){
        this.idOp = idOp;
        this.citaEntrega = citaEntrega;
    }
    
    @InvocableMethod (label='validacionCitaEntrega')
    public static list<response> validarCitaEntrega (list<validacionCitaEntrega> JamarCitaEntrega){
        
        list <response> value = new list<response>();
        list <String> Answerx = new list<String>();
        list <String> Answerx2 = new list<String>();
        response rp = new response();
        
        String idOp    =JamarCitaEntrega[0].idOp;
        String citaEntrega = JamarCitaEntrega[0].citaEntrega;
        String mensajeCita ='';
        List<Opportunity> identificacion= [Select Identificaci_n_del_cliente__c from Opportunity where IdOP__c = :idOp];
        String n_ide = identificacion[0].Identificaci_n_del_cliente__c;
        System.debug(n_ide);
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
            String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
            String url2 = endPoint + empresa + '/validacionCitaEntrega?n_ide=' + n_ide + '&rem=' + Op + '&c_agr=' + agencia + '&per=' + periodo;
            HttpResponse response2 = JamarConsumoHTTP.callServiceExternal(url2, null, 'GET',null);
            Answerx.add(response2.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            String cita = String.ValueOf(jsonParseds.get('data'));
            System.debug(cita);
            String substring2 = cita.substringAfter('CITA_ENTREGA');
            System.debug(substring2);
            String inicio1 = substring2.removeStart('"');
            System.debug(inicio1);
            String inicio2 = inicio1.removeStart('=');
            System.debug(inicio2);
            String citaEnt = inicio2.removeEnd('})');
            System.debug(citaEnt);
            if(citaEnt != null && citaEnt != ''){
                mensajeCita ='CITA ASIGNADA CON EXITO';
            }else{
                mensajeCita = 'NO SE PUDO ASIGNAR LA CITA DE ENTREGA';
            }
            rp.confirmacion = mensajeCita;
            rp.fecha = format_cita_SF;
            value.add(rp);
            return value;                            
        }catch(Exception e){
            
            Log__c log = new Log__c();
            log.ClassName__c = 'Validacion_Cita_Entrega';
            log.date__c = Datetime.now();
            log.message__c = 'Error en validacion de entrega: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = '';
            insert log;    
            
            System.debug(e.getMessage());
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