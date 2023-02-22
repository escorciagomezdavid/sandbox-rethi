@IsTest
public class IRespuestaPrecalificacion_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"ps_responseClob\": {'+
		'        \"success\": true,'+
		'        \"message\": \"OK\",'+
		'        \"data\": {'+
		'            \"c_emp\": \"\",'+
		'            \"c_agr\": \"\",'+
		'            \"c_est\": \"\",'+
		'            \"n_ide\": \"\",'+
		'            \"estado\": \"\",'+
		'            \"subestado\": \"\",'+
		'            \"piloto\": \"\",'+
		'            \"pilexpress\": \"N\",'+
		'            \"cupo_max\": 4010000,'+
		'            \"cupo_disp\": 4010000,'+
		'            \"puntajelisim\": 872,'+
		'            \"cuotasugmax\": 200000,'+
		'            \"lectura_data\": \"\",'+
		'            \"accsug_credito\": \"G2\",'+
		'            \"accsug_tj\": \"G2\",'+
		'            \"tipo_cliente\": \"SNL\",'+
		'            \"des_tcliente\": \"CLIENTE NUEVO\",'+
		'            \"pot_tj\": \"\",'+
		'            \"calcularlectura\": \"NO\",'+
		'            \"segmento\": \"\",'+
		'            \"usuario\": \"\",'+
		'            \"pasesaldo\": 0,'+
		'            \"aplicascore\": \"E\",'+
		'            \"ususimulador\": \"\",'+
		'            \"tipomodelo\": \"\",'+
		'            \"act_pottj\": \"\",'+
		'            \"act_cupo\": \"\",'+
		'            \"ct_estado\": \"\",'+
		'            \"cue\": \"\",'+
		'            \"tcre\": \"\",'+
		'            \"agecue\": \"\",'+
		'            \"total\": null,'+
		'            \"saldo\": null,'+
		'            \"fup\": \"\",'+
		'            \"estcar\": \"\",'+
		'            \"mostrar_menspiloto\": \"\",'+
		'            \"tipoprecalf\": \"EVALUATION\",'+
		'            \"scorefinal\": 915.5,'+
		'            \"accsuglisim\": \"\",'+
		'            \"fecaccsug\": \"28/06/22\",'+
		'            \"acciones_sug\": \"0;1000000;G2|1000001;10000000;G2|10000001;15000000;G5|15000001;100000000;G5|\",'+
		'            \"desc_accsugcr\": \"CON UN FIADOR EMPLEADO,PENSIONADO O INDEPENDIENTE FORMAL\",'+
		'            \"desc_accsugtj\": \"CON UN FIADOR EMPLEADO,PENSIONADO O INDEPENDIENTE FORMAL\",'+
		'            \"identifica_datacredito\": \"\",'+
		'            \"codmodelo\": \"\",'+
		'            \"evaltipocliente\": \"\",'+
		'            \"tipo_estudio\": \"\",'+
		'            \"programa\": \"\",'+
		'            \"modulo\": \"\",'+
		'            \"maquina\": \"\"'+
		'        }'+
		'    },'+
		'    \"ps_nuCodError\": null,'+
		'    \"ps_vcMensError\": null,'+
		'    \"success\": true'+
		'}';
		IRespuestaPrecalificacion obj = IRespuestaPrecalificacion.parse(json);
		System.assert(obj != null);
	}
}