@IsTest
public class ProcesaRespuestaPrecalificacion_test  {
    @invocablevariable(Label='Response Servicio Precalificacion' required=true)
    public string response_service;
    
    public ProcesaRespuestaPrecalificacion_test(){
        this.response_service = '{'+
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
    }
    
    @isTest static void processResponseTest(){
        list<String> lstResponse = new list<String>();
        ProcesaRespuestaPrecalificacion_test test = new ProcesaRespuestaPrecalificacion_test();
        
        ProcesaRespuestaPrecalificacion ProcesaRespuesta = new ProcesaRespuestaPrecalificacion(test.response_service);
        list<ProcesaRespuestaPrecalificacion> procesaRes = new list<ProcesaRespuestaPrecalificacion>();
        procesaRes.add(ProcesaRespuesta);
        ProcesaRespuestaPrecalificacion.processResponse(procesaRes);
        System.assert(test.response_service == ProcesaRespuestaPrecalificacion.processResponse(procesaRes)[0]);
    }
    
    @isTest static void processResponseTestFallo(){
        String response_service = '{'+
            '    \"ps_responseClob\": {'+
            '        \"success\": null,'+
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
            '    \"success\": null'+
            '}';
         ProcesaRespuestaPrecalificacion ProcesaRespuesta = new ProcesaRespuestaPrecalificacion(response_service);
        list<ProcesaRespuestaPrecalificacion> procesaRes = new list<ProcesaRespuestaPrecalificacion>();
        procesaRes.add(ProcesaRespuesta);
        ProcesaRespuestaPrecalificacion.processResponse(procesaRes);
        //System.assert(response_service == ProcesaRespuestaPrecalificacion.processResponse(procesaRes)[0]);
        
        /*
        ProcesaRespuestaPrecalificacion_test test = new ProcesaRespuestaPrecalificacion_test();
        ProcesaRespuestaPrecalificacion ProcesaRespuesta = new ProcesaRespuestaPrecalificacion(response_serviceFallo);
        list<ProcesaRespuestaPrecalificacion> procesaRes = new list<ProcesaRespuestaPrecalificacion>();
        procesaRes.add(ProcesaRespuesta);
        ProcesaRespuestaPrecalificacion.processResponse(procesaRes);
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(ProcesaRespuestaPrecalificacion.processResponse(procesaRes)[0]); 
        String dataResponse = String.valueOf(jsonParseds.get('success'));
        System.debug(jsonParseds.get('success'));
        System.debug(dataResponse);
        System.assert('true' == dataResponse);
        System.assertEquals('true', dataResponse);
        System.assert(response_serviceFallo == ProcesaRespuestaPrecalificacion.processResponse(procesaRes)[0]); */
    }
}