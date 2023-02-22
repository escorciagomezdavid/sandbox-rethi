public class JamarConsultaFechaArmado {
    

                @invocablevariable(Label='Empresa' required=true)
                        public string empresa;
                @invocablevariable(Label='country' required=true)
                            public string country;
                @invocablevariable(Label='Op' required=true)
                            public string numeroOp;
                @invocablevariable(Label='periodoOp' required=true)
                            public string periodoOp;
                @invocablevariable(Label='agencia' required=true)
                            public string agencia;
                @invocablevariable(Label='fecha' required=true)
                            public Date fecha;
    
    				public JamarConsultaFechaArmado(){}
                    public JamarConsultaFechaArmado(String empresa, String country, String numeroOp,String periodoOp, String agencia, Date fecha){
                                      this.empresa=empresa;
                                      this.country=country;
                                      this.numeroOp = numeroOp;
                                      this.periodoOp = periodoOp;
                                      this.agencia = agencia;
                                      this.fecha = fecha;
                    }

                 @InvocableMethod (label='Consultar Fecha de Armado')
            public static List<response> ConsultaArmado (list<JamarConsultaFechaArmado> JamarConsultaFechaArmado){
                list <String> Answerx = new list<String>();
                response rp = new response();
                List<response> respons = new List<response>();
                String empresa = JamarConsultaFechaArmado[0].empresa;
                String country = JamarConsultaFechaArmado[0].country;
                String numeroOp = JamarConsultaFechaArmado[0].numeroOp;
                String periodoOp = JamarConsultaFechaArmado[0].periodoOp;
                String agencia = JamarConsultaFechaArmado[0].agencia;
                String codeModel = '02';
                Date fecha = JamarConsultaFechaArmado[0].fecha;
                String mydate = '';
                String periodo = '';
                String body = '';
                
                if(fecha.month()>=10){
                    mydate = fecha.year() + '' + fecha.month()+ ''+ fecha.day();
                    periodo=fecha.year() + '' + fecha.month();
                }else{
                    mydate = fecha.year() + '' +0+ fecha.month()+ ''+ fecha.day();
                    periodo = fecha.year() + '' +0+ fecha.month();
                }
                System.debug(periodo);
                System.debug(mydate);     
                try{
                    String url = 'https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/'+empresa+'/assembly-express';
                    Map<String, Object> objson = new Map<String, Object>();
                        objson.put('country',country);
                        objson.put('codeModel',codeModel);
                        objson.put('codeResource','');
                        objson.put('period',periodo);
                        objson.put('rem',numeroOp);
                        objson.put('perRem', periodoOp);
                        objson.put('agency', agencia);
                        objson.put('service','');
                        objson.put('date', mydate);
                    body = String.valueOf(JSON.Serialize(objson));
                    System.debug(body);
                    Http http = new Http();
                        HttpRequest request = new HttpRequest();
                        request.setEndpoint(url);
                        request.setMethod('POST');
                        request.setHeader('Content-Type', 'application/json');
                        request.setBody(body);
                        HttpResponse response = http.send(request);
                    Answerx.add(response.getbody());
                    String data = Answerx[0];
                    Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
                    String calendario = String.ValueOf(jsonParseds.get('calendar'));
                    String tecnic = String.ValueOf(jsonParseds.get('tecnico'));
                    String recurso = String.ValueOf(jsonParseds.get('recurso'));
                    Set<String> sString = new Set<String>();
                    String  dataFinalForComponent = '';                  
                    for(String c : calendario.split(';')){
                        String subfecha = c.substring(0, 10);
                        sString.add(subfecha);
                    }
                   List<String> contenedor = new list<String>(sString);
                   System.debug(contenedor);
                    for(Integer i=0;i<contenedor.size();i++){
                        String valor =  String.valueOf(contenedor[i]);
                        Date x = Date.valueOf(valor);
                        DateTime dt = DateTime.newInstance(x.year(), x.month(),x.day());
                        String format = 'EEEE,dd-MMMM-YYYY';
                        String fechas = dt.format(format);
                        System.debug(fechas);
                        String diaSub= fechas.substringBefore(',');
                    	String fechaF = fechas.substringAfter(',');
                        List<String> fechaStr = new list<String>();
                        for(String st : fechaF.split('-')){         
                         fechaStr.add(st);
                     	}
                        String dia = fechaStr[0];
                        String mes = fechaStr[1];
                        String ano = fechaStr[2];
                        String mesSpanish = meses(mes);
                        String diaSpanish = dias(diaSub);
                        String fechaFormateada = diaSpanish+','+dia+'-'+mesSpanish+'-'+ano;
                        System.debug(fechaFormateada);
                        dataFinalForComponent = dataFinalForComponent + ';' +fechaFormateada;
                    }
                        rp.calendarioOutput = dataFinalForComponent.substring(1);
                        rp.tecnico =  tecnic;
                        rp.codigoRecurso= recurso;
                        respons.add(rp);
                            System.debug(url); //debuguear
                            System.debug(body);
                            System.debug(respons);
                            return respons; 
                               
                }catch(Exception e){
                        Log__c log = new Log__c();
                        log.ClassName__c = 'Consulta_Cita_Armado';
                        log.date__c = Datetime.now();
                        log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
                        log.success__c = false;
                        log.type__c = 'Consumo en ws';
                        log.JSON__c = body;
                        //log.Empresa__c = empresa;
                        insert log;                 
                }
                return respons;
            }  
                    
                    public class response{
                        @invocableVariable(Label='Calendario' required=true)
                        public String calendarioOutput; 
                        @invocableVariable(Label='tecnico' required=true)
                        public string tecnico;  
                        @invocableVariable(Label='codigo recurso' required=true)
                        public string codigoRecurso;  
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