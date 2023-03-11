public class JamarAsignacionEntregaCambio {
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
    @invocablevariable(Label='tipo_diagnostico' required=true) 
    public string tipo_diagnostico;
    @invocablevariable(Label='descripcion_caso' required=true) 
    public string descripcion_caso;
    @invocablevariable(Label='dano_producto' required=true) 
    public string dano_producto;
    @invocablevariable(Label='ubicacion_dano' required=true) 
    public string ubicacion_dano;
    @invocablevariable(Label='fecha_picking_e' required=true) 
    public Date fecha_picking_e;
    @invocablevariable(Label='fecha_entrega' required=true) 
    public Date fecha_entrega;
    @invocablevariable(Label='codigoBodega' required=true) 
    public string codigoBodega;
    @invocablevariable(Label='tipoCalendario' required=true) 
    public string tipoCalendario;
    
    public JamarAsignacionEntregaCambio() {}
    
    public JamarAsignacionEntregaCambio(String cod_prod,
                                        String company, 
                                        String agr, 
                                        String per, 
                                        String rem, 
                                        String tipo_sol, 
                                        String no_caso, 
                                        String tipo_diagnostico, 
                                        String descripcion_caso,
                                        String dano_producto,
                                        String ubicacion_dano,
                                       	Date fecha_picking_e,
                                       	Date fecha_entrega,
                                       	String codigoBodega,
                                       	String tipoCalendario) {
        this.cod_prod = cod_prod;
        this.company = company;
        this.agr = agr;
        this.per = per;
        this.rem = rem;
        this.tipo_sol = tipo_sol;
        this.no_caso = no_caso;
        this.tipo_diagnostico = tipo_diagnostico;
        this.descripcion_caso = descripcion_caso;
        this.dano_producto = dano_producto;
        this.ubicacion_dano = ubicacion_dano;
        this.fecha_picking_e = fecha_picking_e;
        this.fecha_entrega = fecha_entrega;
        this.codigoBodega = codigoBodega;
        this.tipoCalendario = tipoCalendario;
    }
    
    @InvocableMethod (label='Asignar Cita Entrega de Servicio')
    public static List<Response> CitaEntregaCambio(List<JamarAsignacionEntregaCambio> CitaEntrega) {
        list<Response> valueAsignacion = new list<Response> ();
        list<String> AnswerxAsignacion = new list<String> ();
        Response responseAsignacion = new Response();
        
        String cod_prod = CitaEntrega[0].cod_prod;
        String company = CitaEntrega[0].company;
        String agr = CitaEntrega[0].agr;
        String per = CitaEntrega[0].per;
        String rem = CitaEntrega[0].rem;
        String tipo_sol = CitaEntrega[0].tipo_sol;
        String no_caso = CitaEntrega[0].no_caso;
        String tipo_diagnostico = CitaEntrega[0].tipo_diagnostico;
        String descripcion_caso = CitaEntrega[0].descripcion_caso;
        String dano_producto = CitaEntrega[0].dano_producto;
        String ubicacion_dano = CitaEntrega[0].ubicacion_dano;
        Date fecha_picking_e = CitaEntrega[0].fecha_picking_e;
        Date fecha_entrega = CitaEntrega[0].fecha_entrega;
        String codigoBodega = CitaEntrega[0].codigoBodega;
        String tipoCalendario = CitaEntrega[0].tipoCalendario;
        String body = '';
        String data = '';
        
        if (tipo_sol == 'CAMBIO_PARCIAL' || tipo_sol == 'CAMBIO') {
			tipo_sol = 'CAM';
			System.debug(tipo_sol);
		}
        
        String diagnostico = tipo_diagnostico + ': ' + descripcion_caso;
        DateTime fechaPickEntDT = DateTime.newInstance(fecha_picking_e.year(), fecha_picking_e.month(), fecha_picking_e.day());
        String fechaPickEntString = fechaPickEntDT.format('yyyy-MM-dd');
        DateTime fechaEntregaDT = DateTime.newInstance(fecha_entrega.year(), fecha_entrega.month(), fecha_entrega.day());
        String fechaEntregaString = fechaEntregaDT.format('yyyy-MM-dd');
        
        try {
         	String endPoint = Endpoint__mdt.getInstance('AsignacionCitaEntregaServicio').URL__c;
            
            Map<String, Object> objson = new Map<String, Object> ();
            objson.put('company', company);
            objson.put('agr', agr);
            objson.put('per', per);
            objson.put('rem', rem);
            objson.put('cod_prod', cod_prod);
            objson.put('cod_bod', codigoBodega);
            objson.put('no_caso', no_caso);
            objson.put('fecha_picking_e', fechaPickEntString);
            objson.put('fecha_entrega', fechaEntregaString);
            objson.put('tipo_calendario', tipoCalendario);
            objson.put('tipo_sol', tipo_sol);
            objson.put('diagnostico', diagnostico);
            objson.put('dano_producto', dano_producto);
            objson.put('ubicacion_dano', ubicacion_dano);
            body = String.valueOf(JSON.Serialize(objson));
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
            
            if(success == true) {
                responseAsignacion.mensaje = message;
            	valueAsignacion.add(responseAsignacion); 
            } else {
                Log__c log = new Log__c();
				log.ClassName__c = 'JamarAsignacionEntregaCambio asignacion de cita entrega de servicio';
				log.date__c = Datetime.now();
				log.message__c = data;
				log.success__c = false;
				log.type__c = 'Fallo sistema';
				log.JSON__c = body;
				if (company == 'JA') {
					log.Empresa__c = 'Colombia';
				}
				insert log;
                responseAsignacion.mensaje = message;
            	valueAsignacion.add(responseAsignacion); 
            }
        } catch(Exception e) {
            responseAsignacion.mensaje = e.getMessage();
            System.debug('LINEA 216 EXCEPCTION: ' + e);
            Log__c log = new Log__c();
            log.ClassName__c = 'JamarAsignacionEntregaCambio asignacion de cita entrega de servicio';
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
    
    public class Response{
        @invocablevariable(Label='mensaje' required=false)
        public String mensaje;
    }
}