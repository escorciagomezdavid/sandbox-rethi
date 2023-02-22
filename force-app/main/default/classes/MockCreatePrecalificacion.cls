@isTest
global class MockCreatePrecalificacion implements HttpCalloutMock {
    
     global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"C_EMP":"JA","IDE":"CC","N_IDE":"1129514335","DEP":"AT","CIU":"AG","BAR":"789","DIR_ELECT":"bbbbb@gmail.com","FECHA":"2022-06-21T08:45:30","USUARIO":"APPVENDEDOR","PRI_NOM":"JENNIFER","SEG_NOM":"None","PRI_APE":"CARVAJALINO-None","SEG_APE":"None","SENAS":"sdssdsd","C_CAB":"BQ","C_PAI_NAC":"01","C_PAI":"01","NICKNAME":null,"SEXO":"F","EST_CIVIL":"S","DIR":"AU 1 1","NRO_HIJOS":0,"ILOC_TEL":"N","ILOC_COR":null,"FECHA_DOCEXPIRA":null,"FECHA_DOCEXPEDICION":"2016-10-04T00:00:00","PAIS_DOCEXPEDICION":"01","DPTO_DOCEXPEDICION":"BO","CIUDAD_DOCEXPEDICION":"CA","FECHA_NAC":"1990-05-27T00:00:00","FECHA_CAS":null,"ENVIA_EMAIL":"S","SECTOR_TRABAJO":null,"NIVEL_RIESGO":null,"CANAL_VINCULACION":null,"PROPOSITO_CR":null,"ORIGEN_FONDO":null,"PAIS_FONDO":null,"POLITICA_EXPUESTA":null,"FAM_POLITICA_EXPUESTA":null,"NOM_FAM_POLITCA_EXPUESTA":null,"EXTRECHO_COLABORADOR_PEP":null,"ESTADO_SALUD":null,"DEPTO_NAC":null,"CIUDAD_NAC":null,"C_AGR":"95","C_EST":"3386996","TIPO":"T","EMPRESA":"00001","CARGO":"17","SUMIN":null,"OBS":null,"FIADOR_T":null,"LUGAR_TRABAJO":null,"BARRIO_TRABAJO":null,"CIU_TRABAJO":null,"DPTO_TRABAJO":null,"TEL_TRABAJO":null,"PROG":null,"CODIGO_EPS":41,"SENAS_TRABAJO":null,"FIADORPRESENTE":null,"EPS_COTIZA":"C","CAB_TRABAJO":null,"PARENTESCO":null,"PAIS_TRABAJO":null,"JORNADA_TRABAJO":null,"TIPO_VIVIENDA":"3","TIPO_CONTRATO":"4","FECHA_TIEMPO_VIVIENDA":"2015-06-20T00:00:00","FECHA_TIEMPO_SERVICIO":"2015-06-20T00:00:00","OCUPACION":"2","MODULO":"FABRICA","MAQUINA":"RESTFULSERVICE","INGRESOS_PRINCIPALES":null,"ACTIVIDAD_NEGOCIO":null}]');  
    	response.setStatusCode(200);
        return response;
    }


}