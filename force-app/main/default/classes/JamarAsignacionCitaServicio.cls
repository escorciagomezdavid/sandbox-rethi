/*
  Name: JamarAsignarCitaServicio
  Proposito: Hace peticion a servicio que Graba la cita de servicio.
  Autor: Daniela Sanchez
  Fecha: 09/06/2022
*/
public class JamarAsignacionCitaServicio {

	@invocablevariable(Label = 'ID_OP' required = true)
	public string idOp;
	@invocablevariable(Label = 'numero caso' required = true)
	public string numeroCaso;
	@invocablevariable(Label = 'codigo producto' required = true)
	public string codProducto;
	@invocablevariable(Label = 'codigo bodega' required = true)
	public string codBodega;
	@invocablevariable(Label = 'fecha cita' required = true)
	public string fechaCita;
	@invocablevariable(Label = 'tipo Calendario' required = true)
	public string tipoCalendario;
	@invocablevariable(Label = 'tipo Solucion' required = true)
	public string tipoSol;
    @invocablevariable(Label = 'Proceso' required = true)
	public string proceso;

	public JamarAsignacionCitaServicio() { }
	public JamarAsignacionCitaServicio(String idOp, String numeroCaso, String codProducto,
	                                   String codBodega, String fechaCita, String tipoCalendario, String tipoSol,String proceso) {
		this.idOp = idOp;
		this.numeroCaso = numeroCaso;
		this.codProducto = codProducto;
		this.codBodega = codBodega;
		this.fechaCita = fechaCita;
		this.tipoCalendario = tipoCalendario;
		this.tipoSol = tipoSol;
        this.proceso=proceso;
	}

	@InvocableMethod(label = 'Asignar cita de servicio')
	public static List<response> AsignarCitaServicio(list<JamarAsignacionCitaServicio> fechaServicio) {
		String numeroCaso = fechaServicio[0].numeroCaso;
		String fechaCita = fechaServicio[0].fechaCita;
		String codBodega = fechaServicio[0].codBodega;
		String idOp = fechaServicio[0].idOp;
		String codProducto = fechaServicio[0].codProducto;
		String tipoCalendario = fechaServicio[0].tipoCalendario;
		String tipoSol = fechaServicio[0].tipoSol;
        String proceso = fechaServicio[0].proceso;
		String fechaRecogida;
		String fechaEntrega;
		String fechaPicking;
		if (tipoSol == 'TALLER') {
			fechaPicking = fechaCita.substringAfter('|');
			fechaRecogida = fechaCita.substringBefore(':');
			String x = fechaCita.substringBefore('|');
			fechaEntrega = x.substringAfter(':');
            tipoSol = 'TAL';
		} else if (tipoSol == 'CAMBIO' || tipoSol == 'CAMBIO_PARCIAL') {
			fechaEntrega = fechaCita.substringBefore(':');
			fechaRecogida = fechaCita.substringBefore(':');
			fechaPicking = fechaCita.substringAfter(':');
            tipoSol = 'CAM';
		}
        System.debug('fechaRecogida: ' + fechaRecogida);
        System.debug('fechaEntrega: ' + fechaEntrega);
		Date format_cita_SF_Recogida = date.valueOf(fechaRecogida);
		Date format_cita_SF_Entrega = date.valueOf(fechaEntrega);
		Date format_cita_SF_Picking = date.valueOf(fechaPicking);

		/* Asignacion de datos de la Op a las variables**/
		List<String> datosOp = new List<String> ();
		for (String st : idOp.split('_')) {
			datosOp.add(st);
		}
		String empresa = datosOp[0];
		String agencia = datosOp[1];
		String periodo = datosOp[2];
		String Op = datosOp[3];
		String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
		String body = '';
		response rp = new response();
		list<String> Answerx = new list<String> ();
		list<response> value = new list<response> ();
		try {
			Map<String, Object> objson = new Map<String, Object> ();
			objson.put('company', empresa);
			objson.put('agr', agencia);
			objson.put('per', periodo);
			objson.put('rem', Op);
			objson.put('cod_prod', codProducto);
			objson.put('cod_bod', codBodega);
			objson.put('no_caso', numeroCaso);
			objson.put('fecha_picking', fechaPicking);
			objson.put('fecha_recogida', fechaRecogida);
			objson.put('fecha_entrega', fechaEntrega);
			objson.put('tipo_calendario', tipoCalendario);
			objson.put('tipo_sol', tipoSol);
			body = String.valueOf(JSON.Serialize(objson));
            String metodo = 'POST';
			HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, body, metodo,'25000');
            System.debug('response: ' + response);
			Answerx.add(response.getBody());
			String data = Answerx[0];
			Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
			Boolean success = Boolean.ValueOf(jsonParsed.get('success'));
			String message = String.ValueOf(jsonParsed.get('message'));
            Case caso = new Case();
            caso = [select ID from Case where CaseNumber =: numeroCaso];
			if (success == true) {
                if(proceso=='AUTOMATICO'){  
                    System.debug('entro');
                    caso.Fecha_Entrega__c = format_cita_SF_Entrega;
                    caso.Fecha_Recogida__c = format_cita_SF_Recogida;
                    caso.Fecha_Picking__c = format_cita_SF_Picking;
                    update caso;
                }else{
                    rp.citaEntrega = format_cita_SF_Entrega;
                    rp.citaRecogida = format_cita_SF_Recogida;
                    rp.citaPicking = format_cita_SF_Picking;
                    value.add(rp);
                }
                System.debug('value: ' + value);
				return value;
			} else {
                if(proceso=='AUTOMATICO'){
                    caso.Caso_SP__c = message;   
                   update caso;
                }else{
                    rp.mensajeConfirmacion = message;
                    value.add(rp);                  
                }
				 return value;
			}
		} catch(Exception e) {
			Log__c log = new Log__c();
			log.ClassName__c = 'Asignacion cita de servicio - Cambio';
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
		@invocablevariable(Label = 'Cita entrega' required = true)
		public Date citaEntrega;
		@invocablevariable(Label = 'Cita Recogida' required = true)
		public Date citaRecogida;
		@invocablevariable(Label = 'Cita picking' required = true)
		public Date citaPicking;
		@invocablevariable(Label = 'Mensaje' required = true)
		public String mensajeConfirmacion;
	}
}