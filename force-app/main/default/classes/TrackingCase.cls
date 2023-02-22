/*
  Name: TrackingCase
  Proposito: Campos que se mapean para la respuesta de la API con respecto a la informacion del tracking caso .
  Author: Daniela Sanchez
  Fecha: 7/05/2022
*/
public class TrackingCase {

	public string status;
	public string numeroCaso;
	public string tipoGarantia;
	public string tipoSolucion;
	public string tipoDiagnostico;
	public Map<String,Date> fechaEtapaCaso;
	public string numeroOp;
	public string codigoProducto;
	public string mensaje;

	public TrackingCase(){}
}