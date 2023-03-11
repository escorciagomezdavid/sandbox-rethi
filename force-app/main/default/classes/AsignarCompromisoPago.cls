/*
  Name: AsignarCompromisoPago
  Proposito: Registrar los compromisos de pagos creados en salesforce en la tabla de db.
  Autor: Andrés Tarra Ruiz
  Fecha: 24/02/2023
*/
public class AsignarCompromisoPago {
	@invocablevariable(Label = 'id cartera' required = true)
	public string idCartera;
	@invocablevariable(Label = 'fecha plazo' required = true)
	public date fechaPlazo;
	@invocablevariable(Label = 'valor compromiso' required = true)
	public integer valorCompromiso;
    @invocablevariable(Label = 'codigo causal' required = true)
	public String codigoCausal;
    @invocablevariable(Label = 'observacion' required = true)
	public String observacion;
    @invocablevariable(Label = 'usuario' required = true)
	public String usuario;

	public AsignarCompromisoPago() { }
	public AsignarCompromisoPago(string idCartera, date fechaPlazo, integer valorCompromiso, string codigoCausal, string observacion, string usuario) {
		this.idCartera = idCartera;
		this.fechaPlazo = fechaPlazo;
		this.valorCompromiso = valorCompromiso;
        this.codigoCausal = codigoCausal;
        this.observacion = observacion;
        this.usuario = usuario;
	}

	@InvocableMethod(label = 'Asignar compromiso de pago')
	public static List<response> AsignarCompromiso(list<AsignarCompromisoPago> compromiso) {
        String idCartera = compromiso[0].idCartera;
		Date fechaPlazo = compromiso[0].fechaPlazo;
		Integer valorCompromiso = compromiso[0].valorCompromiso;
        String codigoCausal = compromiso[0].codigoCausal;
        String observacion = compromiso[0].observacion;
        String usuario = compromiso[0].usuario;
        
        //Cartera__c getCartera = [SELECT IdCartera__c from Cartera__c where AccountId__c = :idCliente and Estado_de_la_cuenta__c = 'ACTIVO'];
        
        //String IdCartera = getCartera.IdCartera__c;
        List<String> datosCartera = new List<String> ();
        for (String ct : idCartera.split('_')) {
            datosCartera.add(ct);
        }
        String empresa = datosCartera[0];
        String agencia = datosCartera[1];
        String tipoCredito = datosCartera[2];
        String numCuenta = datosCartera[3];
        
		String endPoint = Endpoint__mdt.getInstance('AsignacionCompromisoPago').URL__c;
		String body = '';
		response rp = new response();
		list<String> Answerx = new list<String> ();
		list<response> value = new list<response> ();
        
        DateTime dt = DateTime.newInstance(fechaPlazo.year(), fechaPlazo.month(), fechaPlazo.day());
        // Formatos
        String formattedDate = dt.format('dd-MM-yyyy');
        String formattedValorCompromiso = String.valueOf(valorCompromiso);
        String formattedUsuario = usuario.toUpperCase();
            
		try {
			Map<String, Object> objson = new Map<String, Object> ();
			objson.put('empresa', empresa);
			objson.put('agencia', agencia);
			objson.put('tipo_credito', tipoCredito);
			objson.put('num_cuenta', numCuenta);
			objson.put('fecha_plazo', formattedDate);
			objson.put('valor_compromiso', formattedValorCompromiso);
            objson.put('observacion', observacion);
            objson.put('usuario', formattedUsuario);
            objson.put('cod_causal', codigoCausal);
			body = String.valueOf(JSON.Serialize(objson));
            System.debug('body: ' + body);
            String metodo = 'POST';
			HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, body, metodo,'25000');
            System.debug('response: ' + response);
			Answerx.add(response.getBody());
			String data = Answerx[0];
			Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
			Boolean success = Boolean.ValueOf(jsonParsed.get('success'));
			String message = String.ValueOf(jsonParsed.get('message'));
			if (success == true) {
                rp.mensajeConfirmacion = message;
                value.add(rp);
			} else {
                rp.mensajeConfirmacion = message;
                value.add(rp);
			}
		} catch(Exception e) {
			Log__c log = new Log__c();
			log.ClassName__c = 'Asignacion Compromiso de Pago';
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
		@invocablevariable(Label = 'Mensaje' required = true)
		public String mensajeConfirmacion;
	}
}