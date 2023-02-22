/*
  Name: EndPointsCase
  Proposito: Endpoints a consultar del API
  Author: Daniela Sanchez
  Fecha: 2/04/2022
*/
@RestResource(UrlMapping = '/v1/Case/*')
global class EndpointsCase {
	@HttpPost
	global static ResponseCase validarTipoGarantia() {
		ResponseCase rc = new ResponseCase();
		middlwareCase Middlware = new middlwareCase();
		String jsonInput = '';
		try {
			RestRequest requestBody = RestContext.request;
			jsonInput = requestBody.requestBody.toString();
			Middlware = (middlwareCase) JSON.deserialize(jsonInput, middlwareCase.class);
			if (Middlware.Caso != null) {
				Boolean clienteExiste = CaseClass.ValidacionCliente(Middlware.Caso.identificacion);
				if (clienteExiste == true) {
					if (Middlware.Caso.proceso == 'VALIDACION GARANTIA') {
						if (Middlware.Caso.identificacion != null && Middlware.Caso.numeroOp != null && Middlware.Caso.codigoProducto != null) {
							List<GarantiaResponse> cases = CaseClass.validacionGarantia(Middlware.Caso.codigoProducto, Middlware.Caso.numeroOp, Middlware.Caso.identificacion);
							rc.message = 'Exitoso';
							rc.statusCode = 200;
							rc.success = True;
							rc.data = cases;
						} else {
							rc.message = 'datos incompletos para validar el tipo de garantia.';
							rc.statusCode = 200;
							rc.success = True;
						}
					}
					return rc;
				} else {
					rc.message = 'No existe cliente.';
					rc.statusCode = 200;
					rc.success = True;
					return rc;
				}

			} else {
				rc.message = 'Error procesando el body.';
				rc.statusCode = 400;
				rc.success = False;
				return rc;
			}
		} catch(Exception e) {
			rc.message = e.getMessage();
			rc.statusCode = 400;
			rc.success = False;
			return rc;
		}
		//return null;
	}

	@HttpGet
	global static ResponseTrackingCase TrackingCaso() {
		ResponseTrackingCase rc = new ResponseTrackingCase();
		RestRequest req = RestContext.request;
		try {
			String identificacion = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
			if (identificacion != null || identificacion != '') {
				List<TrackingCase> datos = CaseClass.DatosTrackingCaso(identificacion);
				if (datos.isEmpty()) {
					rc.message = 'No tiene casos de garantia disponibles en salesforce.';
					rc.statusCode = 200;
					rc.success = True;
					rc.data = datos;
					return rc;
				} else {
					rc.message = 'Exitoso';
					rc.statusCode = 200;
					rc.success = True;
					rc.data = datos;
					return rc;
				}
			} else {
				rc.message = 'Sin parametro de identificacion';
				rc.statusCode = 200;
				rc.success = True;
				return rc;
			}

		}
		catch(Exception e) {
			rc.message = 'Fallo en la peticion.';
			rc.statusCode = 400;
			rc.success = False;
			return rc;
		}
	}


}