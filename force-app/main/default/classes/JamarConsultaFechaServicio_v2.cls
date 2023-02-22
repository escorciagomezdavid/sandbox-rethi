/*
  Name: JamarConsultaFechaServicio_v2
  Proposito:    Hace peticion a nuevo servicio que devuelve un conjunto de fechas disponibles de servicio y asigna una fecha de servicio
                de forma automatica.
  Autor: David Escorcia Gomez
  Fecha: 23/08/2022
 
*/
public class JamarConsultaFechaServicio_v2 {
    
    @invocablevariable(Label='cod_prod' required=true) 
    public string cod_prod;
    @invocablevariable(Label='company' required=true) 
    public string company;
    @invocablevariable(Label='agr' required=true) 
    public string agr;
    @invocablevariable(Label='per' required=true) 
    public string per;
    @invocablevariable(Label='rem' required=true) 
    public string rem;
    @invocablevariable(Label='tipo_sol' required=true) // CAMBIO, CAMBIO_PARCIAL, TALLER
    public string tipo_sol;
    @invocablevariable(Label='no_caso' required=true) 
    public string no_caso;

    public JamarConsultaFechaServicio_v2() {}
    
    public JamarConsultaFechaServicio_v2(String cod_prod, String company, String agr, String per, String rem, String tipo_sol, String no_caso){
        this.cod_prod = cod_prod;
        this.company = company;
        this.agr = agr;
        this.per = per;
        this.rem = rem;
        this.tipo_sol = tipo_sol;
        this.no_caso = no_caso;
    }

    @InvocableMethod (label='Consultar Fecha de Servicio')
    public static List<response> ConsultaServicio(List<JamarConsultaFechaServicio_v2> JamarConsultaFechaServicio){

        //CONSULTA FECHA
        list <String> AnswerxConsulta = new list<String>();
        list <response_consulta_fecha> valueConsulta = new list<response_consulta_fecha>();
        response_consulta_fecha responseConsulta = new response_consulta_fecha();
        
        String cod_prod = JamarConsultaFechaServicio[0].cod_prod;
        String company = JamarConsultaFechaServicio[0].company;
        String agr = JamarConsultaFechaServicio[0].agr;
        String per = JamarConsultaFechaServicio[0].per;
        String rem = JamarConsultaFechaServicio[0].rem;
        String tipo_sol = JamarConsultaFechaServicio[0].tipo_sol;
        String no_caso = JamarConsultaFechaServicio[0].no_caso;
        String body;
		String fecha;

        //ASIGNA FECHA
        list<String> AnswerxAsignacion = new list<String> ();
        list<response> valueAsignacion = new list<response> ();
        response responseAsignacion = new response();

        // String codProducto = cod_prod;
        // String tipoSol = tipo_sol;
        String fechaRecogida;
        String fechaEntrega;
        String fechaPicking;

        // String empresa =  company;
        // String agencia = agr;
        // String periodo = per;
        // String Op = rem;
        
        //AMBAS
        String data;

        if (tipo_sol == 'CAMBIO_PARCIAL' || tipo_sol == 'CAMBIO') {
			tipo_sol = 'CAM';
			System.debug(tipo_sol);
		} else if (tipo_sol == 'TALLER') {
            tipo_sol = 'TAL';
        }
        
        try{
            String url = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c; 
            String method = 'POST';
            Map<String, Object> objson = new Map<String, Object>();
            objson.put('cod_prod',cod_prod);
            objson.put('company',company);
            objson.put('agr',agr);
            objson.put('per',per);
            objson.put('rem',rem);  
            objson.put('tipo_sol',tipo_sol);          	
            System.debug('LINEA 89 objson: ' + objson);
            body = String.valueOf(JSON.Serialize(objson));
            System.debug(body);
            HttpResponse responseConsultaEndpoint = JamarConsumoHTTP.callServiceExternalWithTimeOut(url, body, method,'25000');

            Integer codigo = responseConsultaEndpoint.getStatusCode();
			AnswerxConsulta.add(responseConsultaEndpoint.getBody());
			data = AnswerxConsulta[0];

            if (codigo == 400) {
                Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
                System.debug('LINEA 100 JSONPARSED: ' + jsonParsed);
                Object detailResponse = jsonParsed.get('detail');
                String str = JSON.serialize(detailResponse);
                System.debug(str);
                String substring = str.substringAfter('message":"');
                System.debug(substring);
                String message = substring.substringBefore('","success');
                System.debug('No Hay Calendario: ' + message);
				responseAsignacion.error = message;
                valueAsignacion.add(responseAsignacion);
				return valueAsignacion;
            }

            if (codigo != 400 && codigo != 200) {
                Log__c log = new Log__c();
				log.ClassName__c = 'JamarConsultarFechaServicio_v2 proceso de consulta de fecha de servicio';
				log.date__c = Datetime.now();
				log.message__c = data;
				log.success__c = false;
				log.type__c = 'Fallo sistema';
				log.JSON__c = body;
				if (company == 'JA') {
					log.Empresa__c = 'Colombia';
				}
				insert log;
                Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
                String message = String.ValueOf(jsonParsed.get('message'));
                responseAsignacion.error = message;
                valueAsignacion.add(responseAsignacion);
                return valueAsignacion;
            }

            JamarInterfaceFechaServicio IFechas = new JamarInterfaceFechaServicio();
			IFechas = JamarInterfaceFechaServicio.parse(data);

            System.debug('LINEA 129: ' + data);

            fechaRecogida = String.valueOf(IFechas.fechasCalendario[0].FECHA_CITA);
            fechaPicking = String.valueOf(IFechas.fechasCalendario[0].FECHA_PICKING);

            fecha = fechaRecogida + ':' + fechaPicking;

            System.debug('LINEA 136 fechaRecogida : fechaPicking ' + fecha);
            
            if (tipo_sol == 'TAL') {
                fechaEntrega = String.valueOf(IFechas.fechasCalendario[0].FECHA_ENTREGA);
                fecha = fechaRecogida+ '|' + fechaEntrega  + ':' + fechaPicking;
                System.debug('LINEA 141 fechaRecogida | fechaEntrega : fechaPicking ' + fecha);
            }

            responseConsulta.fechaCita = fecha;
            responseConsulta.codigoBodega = IFechas.COD_BODEGA;
            responseConsulta.tipoCalendario = IFechas.TIPO_CALENDARIO;
            System.debug('LINEA 145 responseConsulta ' + responseConsulta);
            valueConsulta.add(responseConsulta);
            System.debug('LINEA 147 valueConsulta ' + valueConsulta);

            //ASIGNACION DE CITA

            String fechaCita = valueConsulta[0].fechaCita;
            String codigoBodega = valueConsulta[0].codigoBodega;
            String tipoCalendario = valueConsulta[0].tipoCalendario;

            System.debug('fechaCita: '  + fechaCita);
            System.debug('codigoBodega: '  + codigoBodega);
            System.debug('tipoCalendario: '  + tipoCalendario);

            if (tipo_sol == 'TAL') {
                fechaPicking = fechaCita.substringAfter(':');
                String x = fechaCita.substringBefore(':');
                fechaEntrega = x.substringAfter('|');
                fechaRecogida = fechaCita.substringBefore('|');
                
                System.debug('LINEA 158 fechaRecogida si tipo_sol es TAL ' + fechaRecogida);
                System.debug('LINEA 158 fechaPicking si tipo_sol es TAL ' + fechaPicking);
                System.debug('LINEA 158 fechaEntrega si tipo_sol es TAL ' + fechaEntrega); // SUBIR ESTO A PRD ...!!!!!!!!! 
            } 
            
            if (tipo_sol == 'CAM') {
                fechaEntrega = fechaCita.substringBefore(':');
                fechaRecogida = fechaCita.substringBefore(':');
                fechaPicking = fechaCita.substringAfter(':');
                System.debug('LINEA 168 fechaRecogida si tipo_sol es CAM ' + fechaRecogida);
            }

            Date format_cita_SF_Recogida = date.valueOf(fechaRecogida);
            Date format_cita_SF_Entrega = date.valueOf(fechaEntrega);
            Date format_cita_SF_Picking = date.valueOf(fechaPicking);

            String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
            body = '';
    
            Map<String, Object> objson2 = new Map<String, Object> ();
            objson2.put('company', company);
            objson2.put('agr', agr);
            objson2.put('per', per);
            objson2.put('rem', rem);
            objson2.put('cod_prod', cod_prod);
            objson2.put('cod_bod', codigoBodega);
            objson2.put('no_caso', no_caso);
            objson2.put('fecha_picking', fechaPicking);
            objson2.put('fecha_recogida', fechaRecogida);
            objson2.put('fecha_entrega', fechaEntrega);
            objson2.put('tipo_calendario', tipoCalendario);
            objson2.put('tipo_sol', tipo_sol);
            body = String.valueOf(JSON.Serialize(objson2));
            System.debug('LINEA 192 body asignacionCita ' + body);
            String metodo = 'POST';
            HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, body, metodo,'25000');
            AnswerxAsignacion.add(response.getBody());
            data = AnswerxAsignacion[0];
            System.debug('203 Data:  ' + data);
            Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
            Boolean success = Boolean.ValueOf(jsonParsed.get('success'));
            String message = String.ValueOf(jsonParsed.get('message'));
            System.debug('Message:  ' + message);
            
            if (success == true) {
                responseAsignacion.fecha_entrega = format_cita_SF_Entrega;
                responseAsignacion.fecha_recogida = format_cita_SF_Recogida;
                responseAsignacion.fecha_picking = format_cita_SF_Picking;
                responseAsignacion.error = message;
                valueAsignacion.add(responseAsignacion);
                return valueAsignacion;
            } else {
                // String message = String.ValueOf(jsonParsed.get('message'));
                responseAsignacion.error = message;
                valueAsignacion.add(responseAsignacion);
                return valueAsignacion;
            }

        } catch(Exception e){
            responseAsignacion.error = e.getMessage();
            System.debug('LINEA 216 EXCEPCTION: ' + e);
            Log__c log = new Log__c();
            log.ClassName__c = 'JamarConsultaFechaServicio_v2 proceso asignacion de cita';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
            log.success__c = false;
            log.type__c = 'Consumo en WS';
            log.JSON__c = body;
            if (company == 'JA') {
				log.Empresa__c = 'Colombia';
			}
            insert log; 
        }  
        return valueAsignacion;
    }
    
    public class response_consulta_fecha{
        public String calendario;
        public String calendarioPicking;
        public String fechaCita;
        public String tipoCalendario;
        public String codigoBodega;
        public String mensaje;
    }

    public class response{
        @invocablevariable(Label='fecha_entrega' required=false)
        public Date fecha_entrega;
        
        @invocablevariable(Label='fecha_recogida' required=false)
        public Date fecha_recogida;
        
        @invocablevariable(Label='fecha_picking' required=false)
        public Date fecha_picking;
        
        // @invocablevariable(Label='fecha_empaque' required=false)
        // public String fecha_empaque;
        
        // @invocablevariable(Label='fecha_desarme' required=false)
        // public String fecha_desarme;

        @invocablevariable(Label='error' required=false)
        public String error;
    }
}