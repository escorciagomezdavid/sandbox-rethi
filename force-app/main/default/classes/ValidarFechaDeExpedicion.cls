/*************************************************************************
Nombre de la Clase: Validacion fecha de Expedicion
Versión : 1.0
Fecha de Creación :  17 Noviembre 2022
Funcionalidad: Devuelve respuesta de validacion de la fecha de expedicion
               de un cliente, si es correcto = true o si es equivocado=false
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Brian Coronel       17/11/2022       Versión Original
* Daniela Sanchez     12/12/2022       Organiza y hace mejoras al codigo como manejo de excepciones y label custom para el endpoint.
*************************************************************************/
public with sharing class ValidarFechaDeExpedicion {
    
    @invocablevariable(Label='Numero de identificación')
    public string identificacion;

    @invocablevariable(Label='Id Estudio')
    public String id_estudio;

    @InvocableVariable(Label='fecha de expedición del documento' required=True)
    public Datetime fecha_expedicion;

    public validarFechaDeExpedicion() {}

    @InvocableMethod(Label='Obtener fechaExpedicion')
    public static list<String> getFechaDeExpedicion(List<validarFechaDeExpedicion> validarFechaDeExpedicion){
        Map<String, Object> objson = new Map<String, Object>();
        list <String> Answerx = new list<String>();
        list<String> lstResponse = new list<String>();

        if (validarFechaDeExpedicion[0].id_estudio == null || validarFechaDeExpedicion[0].id_estudio == ''){
            lstResponse.add('No tiene Id Estudio');
            return lstResponse;
        }

        List<String> values_estudio = Precalificacion.processConvertListConcatUnderScoreVariable(validarFechaDeExpedicion[0].id_estudio);
        System.debug(validarFechaDeExpedicion[0].fecha_expedicion);
        String fecha = validarFechaDeExpedicion[0].fecha_expedicion.formatGmt('dd/MM/yyyy');
        System.debug(fecha);
        objson.put('c_agr', values_estudio[1]);
        objson.put('c_est', values_estudio[2]);
        objson.put('n_ide', validarFechaDeExpedicion[0].identificacion);
        objson.put('fecha_exp', fecha);
        String body = String.valueOf(JSON.serialize(objson));
        String url = Endpoint__mdt.getInstance('ValidacionExpedicion').URL__c+values_estudio[0];
        try{
            HttpResponse response =JamarConsumoHTTP.callServiceExternalWithTimeOut(url,body,'POST','30000');
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
            String rp = String.valueOf(jsonParsed.get('success'));
            System.debug(rp);
            lstResponse.add(rp);
            return lstResponse;
        }catch(Exception e){
            Log__c log = new Log__c();
            log.ClassName__c = 'PrecalificacionBody';
            log.date__c = Datetime.now();
            log.message__c =  'Ok';
            log.Empresa__c = 'Colombia';
            log.JSON__c = body;
            log.success__c = false;
            log.type__c = 'Procesamiento de peticion al ws';
            insert log;
        }

        return lstResponse;
    }


}