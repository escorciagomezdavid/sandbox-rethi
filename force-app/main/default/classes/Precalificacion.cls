/*************************************************************************
Nombre de la Clase: Pre - Calificacion
Versión : 1.0
Fecha de Creación :  11 Dicimebre 2022
Funcionalidad: Contiene los metodos para el proceso de calificacion de credito de un cliente. Se realizan llamados
                a los servicios que continen los procedimientos que albergan la logica de negocio.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       17/12/2022       Versión Original
*************************************************************************/
public with sharing class Precalificacion {
    
    public static String processTypeIdentify(String typeIdentify){

        switch on typeIdentify {
           when 'CEDULA DE CIUDADANIA' {
               return 'CC';
           }
           when 'PASAPORTE' {
               return '41';
           }
           when 'NIT' {
               return 'NT';
           }
           when 'CEDULA DE EXTRANJERIA' {
               return '22';
           }
           when 'TARJETA DE EXTRANJERIA' {
               return '21';
           }
        }
        return 'Error Calculate';
        }

    public static String processDate(Integer value, String unit_measure){
        Date date_now = Date.today();
        if (unit_measure == 'Anos'){
            Integer ano = date_now.year();
            Integer new_ano = ano - value;
            Date new_date = Date.newInstance(new_ano, date_now.month(), date_now.day());
            System.debug(String.valueOf(new_date));
            return String.valueOf(new_date);            
        } else if (unit_measure == 'Meses'){
            Integer days = value * 30;
            Date date_calculate = date_now - days;
            System.debug(String.valueOf(date_calculate));
            return String.valueOf(date_calculate);
        }
        return 'Error Calculate';
     }

    public static list<String> processConvertListConcatUnderScoreVariable(String value){

        List<String> res = value.split('_', -1);
        System.debug(res);
        return res;
     }

    public static List<ResponseGetClienteWithEstudio> getClientWithEstudio(String empresa, String n_ide, String estudio, String agencia_estudio){
        String url = Endpoint__mdt.getInstance('ClienteEstudio').URL__c + empresa + '/' + n_ide + '/' + estudio + '/' + agencia_estudio;
        System.debug(url);
        HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(url, null, 'GET', '30000');
        System.debug(response.getBody());
        List<ResponseGetClienteWithEstudio> response_parse = ResponseGetClienteWithEstudio.parse(response.getBody());
        return response_parse;
    }


}