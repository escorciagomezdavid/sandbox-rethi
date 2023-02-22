public class JamarCitaArmado {
       		@invocablevariable(Label='Empresa' required=true)
                public string empresa;
   		    @invocablevariable(Label='CodigoPais' required=true)
                public string codigoPais;	
     		@invocablevariable(Label='fechaCita' required=true)
                public string citaArmado;
    		@invocablevariable(Label='numOp' required=true)
                public string numeroOp;
    		@invocablevariable(Label='agencia' required=true)
                public string agencia;
            @invocablevariable(Label='tecnico' required=true)
                public string tecnico;                        
    		@invocablevariable(Label='codigo Recurso' required=true)
                public string codRecurso;
            @invocablevariable(Label='Jornada' required=true)
                public string jornada;
             
    		public JamarCitaArmado(){}
            public JamarCitaArmado(String empresa,String codigoPais,String citaArmado,String numeroOp,String agencia,String tecnico,
                                  String codRecurso,String jornada){
                    this.empresa = empresa;
                    this.codigoPais = codigoPais;
                    this.citaArmado = citaArmado;
                    this.numeroOp = numeroOp;
                    this.agencia = agencia;
                    this.tecnico = tecnico;
                    this.codRecurso = codRecurso;
                    this.jornada = jornada;
                }
        @InvocableMethod (label='Asignar fecha de armado')
    public static List<response> CitaArmado (list<JamarCitaArmado> JamarCitaArmado){
        list <String> Answerx = new list<String>();
        response rp = new response();
        List<response> respons = new List<response>();
        String body = '';
        String empresa = JamarCitaArmado[0].empresa;
        String country = JamarCitaArmado[0].codigoPais;
        String numeroOp = JamarCitaArmado[0].numeroOp;
        String citaArmado = JamarCitaArmado[0].citaArmado;
        String agencia = JamarCitaArmado[0].agencia;
        String tecnico = JamarCitaArmado[0].tecnico;
        String codRecurso = JamarCitaArmado[0].codRecurso;
        String codeModel = '02';
        String unitType =JamarCitaArmado[0].jornada;
  
        /*
         * Formateo de Fechas 
        */
        String formato = citaArmado.substringAfter(',');
             List<String> fechaList = new List<String>();
             for(String st : formato.split('-')){         
                 fechaList.add(st);
             }
        String dia = fechaList[0];
        String mes = fechaList[1];
        String ano = fechaList[2];  
        String mesNum = meses(mes);
        String fecha_format_SV =ano+''+mesNum+''+dia;
        String fecha_format_SF = ano+'-'+mesNum+'-'+dia;
        Date   asignacionArmado = date.valueOf(fecha_format_SF);

        try{
            String url='https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/'+ empresa +'/assembly-express';
            Map<String, Object> objson = new Map<String, Object>();
            	objson.put('country',country);
                objson.put('codeModel',codeModel);
             	objson.put('date', fecha_format_SV);
            	objson.put('rem',numeroOp);
                objson.put('agency', agencia);
                objson.put('tecnico',tecnico);
            	objson.put('codRecurso',codRecurso);
                objson.put('unitType', unitType);
                body = String.valueOf(JSON.Serialize(objson));
                System.debug(body);
            	Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(url);
                request.setMethod('PUT');
                request.setHeader('Content-Type', 'application/json');
                request.setBody(body);
                HttpResponse response = http.send(request);
                Answerx.add(response.getbody());
                String data = Answerx[0];
                Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
                String calendario = String.ValueOf(jsonParseds.get('calendar'));
                if(calendario =='OK'){
                    rp.confirmacion = 'CITA ASIGNADA CON EXITO';
                }else{
                    rp.confirmacion = calendario;
                }        
                rp.citaArmado =  asignacionArmado;
                respons.add(rp);
                return respons;  
        }
        catch(Exception e){
            Log__c log = new Log__c();
                log.ClassName__c = 'Asignar_Cita_Armado';
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
                @invocableVariable(Label='Confirmacion Cita' required=true)
                public String confirmacion; 
                @invocableVariable(Label='cita Armado' required=true)
                public Date citaArmado;  
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