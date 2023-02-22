/*
Name: JamarConsultaFechaServicio
Proposito: Hace peticion a servicio que devuelve un conjunto de fechas de servicio
Autor: Daniela Sanchez
Fecha: 06/06/2022

*/
public class JamarConsultaFechaServicio {
    @invocablevariable(Label = 'Empresa' required = true)
    public string empresa;
    @invocablevariable(Label = 'ID_OP' required = true)
    public string idOp;
    @invocablevariable(Label = 'tipo de solucion' required = true)
    public string tipoSol;
    @invocablevariable(Label = 'codigo producto' required = true)
    public string codProducto;
    @invocablevariable(Label = 'Proceso' required = true)
    public string Proceso;
    
    public JamarConsultaFechaServicio() { }
    public JamarConsultaFechaServicio(String empresa, String idOp, String tipoSol, String codProducto, String proceso) {
        this.empresa = empresa;
        this.idOp = idOp;
        this.tipoSol = tipoSol;
        this.codProducto = codProducto;
        this.proceso = proceso;
    }
    @InvocableMethod(label = 'Consultar Fecha de Servicio')
    public static List<response> ConsultaEntrega(list<JamarConsultaFechaServicio> fechaServicio) {
        String empresa = fechaServicio[0].empresa;
        String tipoSol = fechaServicio[0].tipoSol;
        String idOp = fechaServicio[0].idOp;
        String codProducto = fechaServicio[0].codProducto;
        String proceso = fechaServicio[0].proceso;
        String body = '';
        String data;
        String fecha;
        if (tipoSol == 'CAMBIO_PARCIAL' || tipoSol == 'CAMBIO') {
			tipoSol = 'CAM';
			System.debug(tipoSol);
		} else if (tipoSol == 'TALLER') {
            tipoSol = 'TAL';
        }
        response rp = new response();
        list<String> Answerx = new list<String> ();
        list<response> value = new list<response> ();
        List<String> datosOp = new List<String> ();
        for (String st : idOp.split('_')) {
            datosOp.add(st);
        }
        String agencia = datosOp[1];
        String periodo = datosOp[2];
        String Op = datosOp[3];
        String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
        try {
            Map<String, Object> objson = new Map<String, Object> ();
            objson.put('company', empresa);
            objson.put('agr', agencia);
            objson.put('per', periodo);
            objson.put('rem', Op);
            objson.put('tipo_sol', tipoSol);
            objson.put('cod_prod', codProducto);
            body = String.valueOf(JSON.Serialize(objson));
            System.debug(body);
            String metodo = 'POST';
            HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, body, metodo,'25000');
            Integer codigo = response.getStatusCode();
            Answerx.add(response.getBody());
            data = Answerx[0];
            if (codigo == 200) {
                JamarInterfaceFechaServicio IFechas = new JamarInterfaceFechaServicio();
                IFechas = JamarInterfaceFechaServicio.parse(data);                
                if (proceso == 'AUTOMATICO') {
                    String fechaRecogida = String.valueOf(IFechas.fechasCalendario[0].FECHA_CITA);
                    String fechaPicking = String.valueOf(IFechas.fechasCalendario[0].FECHA_PICKING);
                    if (tipoSol == 'TAL') {
                        String fechaEntrega = String.valueOf(IFechas.fechasCalendario[0].FECHA_ENTREGA);
                        fecha = fechaRecogida+ '|' + fechaEntrega  + ':' + fechaPicking;
                    } else {
                        fecha = fechaRecogida + ':' + fechaPicking;
                    }
                    rp.fechaCita = fecha;
                    rp.codigoBodega = IFechas.COD_BODEGA;
                    rp.tipoCalendario = IFechas.TIPO_CALENDARIO;
                    rp.mensaje='HOLA';
                    value.add(rp);
                    return value;
                } else {
                    String dataFinalForComponent = '';
                    String dataFinalForComponentPicking = '';
                    for (Integer i = 0; i<IFechas.fechasCalendario.size(); i++) {
                        // Fecha de entrega/Recogida.
                        String valor = String.valueOf(IFechas.fechasCalendario[i].FECHA_CITA);
                        Date x = Date.valueOf(valor);
                        DateTime dt = DateTime.newInstance(x.year(), x.month(), x.day());
                        String format = 'EEEE,dd-MMMM-YYYY';
                        String fechaFormat = dt.format(format);
                        String diaSub = fechaFormat.substringBefore(',');
                        String fechaF = fechaFormat.substringAfter(',');
                        List<String> fechaList = new List<String> ();
                        for (String st : fechaF.split('-')) {
                            fechaList.add(st);
                        }
                        String dia = fechaList[0];
                        String mes = fechaList[1];
                        String ano = fechaList[2];
                        String mesSpanish = meses(mes);
                        String diaSpanish = dias(diaSub);
                        String fechaFormateada = diaSpanish + ',' + dia + '-' + mesSpanish + '-' + ano;
                        dataFinalForComponent = dataFinalForComponent + ';' + fechaFormateada;
                        //Fecha de picking + entrega/recogida para manipulacion interna.
                        String valor2 = String.valueOf(IFechas.fechasCalendario[i].FECHA_PICKING);
                        if (tipoSol == 'TAL') {
                            String valor3 = String.valueOf(IFechas.fechasCalendario[i].FECHA_ENTREGA);
                            dataFinalForComponentPicking = dataFinalForComponentPicking + ';' + valor + ':' + valor3 + '|' + valor2;
                        } else {
                            dataFinalForComponentPicking = dataFinalForComponentPicking + ';' + valor + ':' + valor2;
                        }
                        
                    }
                    String calendar = dataFinalForComponent.substring(1);
                    String calendarPicking = dataFinalForComponentPicking.substring(1);
                    System.debug(calendarPicking);
                    rp.calendario = calendar;
                    rp.calendarioPicking = calendarPicking;
                    rp.codigoBodega = IFechas.COD_BODEGA;
                    rp.tipoCalendario = IFechas.TIPO_CALENDARIO;
                    value.add(rp);
                    System.debug('SALIO');
                    return value;
                }
            } else if (codigo == 400) {
                Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
                String message = String.ValueOf(jsonParsed.get('message'));
                rp.mensaje = message;
                value.add(rp);
                return value;
            } else {
                Log__c log = new Log__c();
                log.ClassName__c = 'Calendario cita de servicio';
                log.date__c = Datetime.now();
                log.message__c = data;
                log.success__c = false;
                log.type__c = 'Fallo sistema';
                log.JSON__c = body;
                if (empresa == 'JA') {
                    log.Empresa__c = 'Colombia';
                }
                insert log;
            }
        } catch(Exception e) {
            Log__c log = new Log__c();
            log.ClassName__c = 'Calendario cita de servicio - Exception';
            log.date__c = Datetime.now();
            log.message__c = 'Error en consumo AWS: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = body;
            if (empresa == 'JA') {
                log.Empresa__c = 'Colombia';
            }
            insert log;
        }
        return value;
    }
    
    public class response {
        @invocablevariable(Label = 'Calendario entrega/recogida' required = false)
        public String calendario;
        @invocablevariable(Label = 'Calendario picking' required = false)
        public String calendarioPicking;
        @invocablevariable(Label = 'fecha cita' required = false)
        public String fechaCita;
        @invocablevariable(Label = 'Tipo calendario' required = true)
        public String tipoCalendario;
        @invocablevariable(Label = 'Codigo bodega' required = true)
        public String codigoBodega;
        @invocablevariable(Label = 'mensaje de fallo' required = true)
        public String mensaje;
    }
    
    public static String meses(string fecha) {
        Map<String, String> meses = new Map<String, String> ();
        String mes;
        meses.put('January', 'Enero');
        meses.put('February', 'Febrero');
        meses.put('March', 'Marzo');
        meses.put('April', 'Abril');
        meses.put('May', 'Mayo');
        meses.put('June', 'Junio');
        meses.put('July', 'Julio');
        meses.put('August', 'Agosto');
        meses.put('September', 'Septiembre');
        meses.put('October', 'Octubre');
        meses.put('November', 'Noviembre');
        meses.put('December', 'Diciembre');
        
        for (String m : meses.keySet()) {
            if (m == fecha) {
                mes = meses.get(m);
            }
        }
        return mes;
    }
    
    public static String dias(string fecha) {
        Map<String, String> semana = new Map<String, String> ();
        String dia;
        semana.put('Monday', 'Lunes');
        semana.put('Tuesday', 'Martes');
        semana.put('Wednesday', 'Miercoles');
        semana.put('Thursday', 'Jueves');
        semana.put('Friday', 'Viernes');
        semana.put('Saturday', 'Sabado');
        semana.put('Sunday', 'Domingo');
        
        for (String m : semana.keySet()) {
            if (m == fecha) {
                dia = semana.get(m);
            }
        }
        return dia;
    }
}