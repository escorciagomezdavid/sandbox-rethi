@isTest
public class CreatePrecalificacion_test {
    
     @invocablevariable(Label='Empresa Jamar')
     public string empresa_jamar;
     @invocablevariable(Label='Tipo Identificacion')
     public string tipo_identificacion;
     @invocablevariable(Label='Identificacion')
     public string identificacion;
     @invocablevariable(Label='Codigo Pais')
     public string cod_pais;
     @invocablevariable(Label='Codigo Departamento')
     public string cod_departamento;
     @invocablevariable(Label='Codigo Ciudad')
     public string cod_ciudad;
     @invocablevariable(Label='Codigo Barrio')
     public string cod_barrio;
     @invocablevariable(Label='Señas')
     public string senas;
     @invocablevariable(Label='Direccion')
     public string direccion;
     @invocablevariable(Label='Correo')
     public string correo;
     @invocablevariable(Label='Usuario')
     public string usuario;
     @invocablevariable(Label='Primer Nombre')
     public string primer_nombre;
     @invocablevariable(Label='Segundo Nombre')
     public string segundo_nombre;
     @invocablevariable(Label='Primer Apellido')
     public string primer_apellido;
     @invocablevariable(Label='Segundo Apellido')
     public string segundo_apellido;
     @invocablevariable(Label='Sexo')
     public string sexo;
     @invocablevariable(Label='Estado Civil')
     public string estado_civil;
     @invocablevariable(Label='Numero de Hijos')
     public Integer numero_hijos;
     @invocablevariable(Label='Fecha Nacimiento')
     public Date fecha_nacimiento;
     @invocablevariable(Label='Ocupacion')
     public String ocupacion;
     @invocablevariable(Label='Empresa')
     public string empresa;
     @invocablevariable(Label='Cargo')
     public string cargo;
     @invocablevariable(Label='Codigo EPS')
     public string cod_eps;
     @invocablevariable(Label='EPS Cotiza')
     public string cod_eps_cotiza;
     @invocablevariable(Label='Tipo Vivienda')
     public string cod_tipo_vivienda;
     @invocablevariable(Label='Tipo Contrato')
     public string cod_tipo_contrato;
     @invocablevariable(Label='Tiempo Vivienda')
     public Integer tiempo_vivienda;
     @invocablevariable(Label='Unidad de medida Tiempo Vivienda')
     public String unidad_medida_tiempo_vivienda;
     @invocablevariable(Label='Tiempo Contrato')
     public Integer tiempo_contrato;
     @invocablevariable(Label='Unidad de medida Tiempo Contrato')
     public String unidad_medida_tiempo_contrato;
     @invocablevariable(Label='Ingresos')
     public Integer ingresos;
     @invocablevariable(Label='Codigo Actividad')
     public String cod_actividad;
     @invocablevariable(Label='Id OP')
     public String id_op;
     @invocablevariable(Label='Id Estudio')
     public String id_estudio;
     @invocablevariable(Label='Tipo Cliente')
     public String cod_tipo_cliente;
     @invocablevariable(Label='Fecha de expedicion de documento')
     public Date fecha_docexpedicion;
    
    public CreatePrecalificacion_test(){
        this.empresa_jamar = 'JA'; 
        this.tipo_identificacion = 'CC'; 
        this.identificacion = '1129514335';
        this.cod_departamento = 'AT';
        this.cod_ciudad = 'BQ';
        this.cod_barrio = '0013';
        this.direccion = 'CR 8 51B 75';
        this.correo = 'BRAYANSILVERAQ@HOTMAIL.COM';
        this.primer_nombre = 'JENNIFER';
        this.segundo_nombre = 'SOFIA';
        this.primer_apellido = 'CARVAJALINO';
        this.segundo_apellido = 'SIERRA';
        this.estado_civil = 'S';
        this.ocupacion = '2';
        this.empresa = '00001';
        this.cargo = '17';
        this.cod_eps = '41';
        this.cod_eps_cotiza = 'C';
        this.cod_tipo_vivienda = '3';
        this.cod_tipo_contrato = '4';
        this.tiempo_vivienda = 7;
        this.unidad_medida_tiempo_vivienda = 'Anos';
        this.tiempo_contrato = 7;
        this.unidad_medida_tiempo_contrato = 'Anos';
        this.ingresos = 3000000;
        this.id_op = 'JA_01_2022_2929470';
        this.id_estudio = 'JA_95_3386996';
    }

    public class PrecalificacionMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse response = new HttpResponse();
            if (req.getEndpoint() == 'https://ubnwg71a4h.execute-api.us-east-1.amazonaws.com/prd/api/v1/catalogo/creditos/client/JA/1129514335/3386996/95') {               
                response.setHeader('Content-Type', 'application/json');
                response.setBody('[{"C_EMP":"JA","IDE":"CC","N_IDE":"1129514335","DEP":"AT","CIU":"AG","BAR":"789","DIR_ELECT":"bbbbb@gmail.com","FECHA":"2022-06-21T08:45:30","USUARIO":"APPVENDEDOR","PRI_NOM":"JENNIFER","SEG_NOM":"None","PRI_APE":"CARVAJALINO-None","SEG_APE":"None","SENAS":"sdssdsd","C_CAB":"BQ","C_PAI_NAC":"01","C_PAI":"01","NICKNAME":null,"SEXO":"F","EST_CIVIL":"S","DIR":"AU 1 1","NRO_HIJOS":0,"ILOC_TEL":"N","ILOC_COR":null,"FECHA_DOCEXPIRA":null,"FECHA_DOCEXPEDICION":"2016-10-04T00:00:00","PAIS_DOCEXPEDICION":"01","DPTO_DOCEXPEDICION":"BO","CIUDAD_DOCEXPEDICION":"CA","FECHA_NAC":"1990-05-27T00:00:00","FECHA_CAS":null,"ENVIA_EMAIL":"S","SECTOR_TRABAJO":null,"NIVEL_RIESGO":null,"CANAL_VINCULACION":null,"PROPOSITO_CR":null,"ORIGEN_FONDO":null,"PAIS_FONDO":null,"POLITICA_EXPUESTA":null,"FAM_POLITICA_EXPUESTA":null,"NOM_FAM_POLITCA_EXPUESTA":null,"EXTRECHO_COLABORADOR_PEP":null,"ESTADO_SALUD":null,"DEPTO_NAC":null,"CIUDAD_NAC":null,"C_AGR":"95","C_EST":"3386996","TIPO":"T","EMPRESA":"00001","CARGO":"17","SUMIN":null,"OBS":null,"FIADOR_T":null,"LUGAR_TRABAJO":null,"BARRIO_TRABAJO":null,"CIU_TRABAJO":null,"DPTO_TRABAJO":null,"TEL_TRABAJO":null,"PROG":null,"CODIGO_EPS":41,"SENAS_TRABAJO":null,"FIADORPRESENTE":null,"EPS_COTIZA":"C","CAB_TRABAJO":null,"PARENTESCO":null,"PAIS_TRABAJO":null,"JORNADA_TRABAJO":null,"TIPO_VIVIENDA":"3","TIPO_CONTRATO":"4","FECHA_TIEMPO_VIVIENDA":"2015-06-20T00:00:00","FECHA_TIEMPO_SERVICIO":"2015-06-20T00:00:00","OCUPACION":"2","MODULO":"FABRICA","MAQUINA":"RESTFULSERVICE","INGRESOS_PRINCIPALES":null,"ACTIVIDAD_NEGOCIO":null}]');  
                response.setStatusCode(200);
                System.debug('1- ENTRO AQUI');
                return response;
            } else if (req.getEndpoint() == 'https://dev.appsjamar.com/crm/saveprequalification/api/v1/save-form-prequalification/JA') {
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"success": true,"ps_vcMensError": "CORREGIR EL NÚMERO DE IDENTIFICACIÓN. SI ES CORRECTO Y EL PROBLEMA PERSISTE DIRECCIONAR AL CLIENTE A LAS OF DE DATACREDITO."}');  
                response.setStatusCode(200);
                System.debug('2-ENTRO AQUI');
                return response;
            } else {
                System.debug('PQ ENTRO AQUI');
                return null;
            }
        }
    }
    
    static testMethod void test_create_precalificacion(){
        Test.startTest();
		CreatePrecalificacion precal = new CreatePrecalificacion();
        list<CreatePrecalificacion> lstprec = new list<CreatePrecalificacion>();
        precal.empresa_jamar = 'JA'; 
        precal.tipo_identificacion = 'CEDULA DE CIUDADANIA'; 
        precal.identificacion = '1129514335';
        precal.cod_pais = '01';
        precal.cod_departamento = 'AT';
        precal.cod_ciudad = 'BQ';
        precal.cod_barrio = '0013';
        precal.direccion = 'CR 8 51B 75';
        precal.correo = 'BRAYANSILVERAQ@HOTMAIL.COM';
        precal.primer_nombre = 'JENNIFER';
        precal.segundo_nombre = '';
        precal.primer_apellido = 'CARVAJALINO';
        precal.segundo_apellido = '';
        precal.senas = 'CASA GRANDE';
        precal.estado_civil = 'S';
        precal.celular = '3456789743';
        precal.numero_hijos = 0;
        precal.ocupacion = '2';
        precal.empresa = '00001';
        precal.cargo = '17';
        precal.cod_eps = '41';
        precal.cod_eps_cotiza = 'C';
        precal.cod_tipo_vivienda = '3';
        precal.cod_tipo_contrato = '4';
        precal.tiempo_vivienda = 7;
        precal.unidad_medida_tiempo_vivienda = 'Anos';
        precal.tiempo_contrato = 7;
        precal.unidad_medida_tiempo_contrato = 'Anos';
        precal.ingresos = 3000000;
        precal.id_op = 'JA_01_2022_2929470';
        precal.id_estudio = 'JA_95_3386996';
        lstprec.add(precal);

        Test.setMock(HttpCalloutMock.class, new PrecalificacionMock());
        HttpResponse response2  = JamarConsumoHTTP.callServiceExternalWithTimeOut('https://ubnwg71a4h.execute-api.us-east-1.amazonaws.com/prd/api/v1/catalogo/creditos/client/JA/1129514335/3386996/95', '', 'GET','30000');
        String contentType2 = response2.getHeader('Content-Type');
        System.debug(response2.getBody());
        System.assert(contentType2 == 'application/json');
        System.assertEquals(200, response2.getStatusCode());

        String bod = '{"c_pai_nac":"01","envia_email":"S","tipo":"T","c_est":"338699","c_agr":"95","actividad_negocio":null,"ingresos_principales":3000000,"fecha_tiempo_servicio":"2015-06-16","fecha_tiempo_vivienda":"2015-06-16","tipo_contrato":"4","tipo_vivienda":"3","eps_cotiza":"C","codigo_eps":"41","cargo":"17","empresa":"00001","ocupacion":"2","fecha_nac":"1990-05-27","nro_hijos":0,"dir":"CR 8 51B 75","est_civil":"S","sexo":"F","senas":"DASDA","seg_ape":null,"pri_ape":"CARVAJALINO","seg_nom":null,"pri_nom":"JENNIFER","usuario":"","dir_elect":"BRAYANSILVERAQ@HOTMAIL.COM","bar":"0013","ciu":"BQ","dep":"AT","c_pai":"01","n_ide":"1129514335","ide":"CC","c_emp":"JA","modulo":"0002"}';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut('https://dev.appsjamar.com/crm/saveprequalification/api/v1/save-form-prequalification/JA', bod, 'POST','30000');
        String contentType = response.getHeader('Content-Type');
        System.debug(response.getBody());
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        CreatePrecalificacion.createPrecalificacion(lstprec);
        Test.stopTest();
        
    }

    static testMethod void test_create_precalificacionSinIdOp(){
        Test.startTest();
		CreatePrecalificacion precal = new CreatePrecalificacion();
        list<CreatePrecalificacion> lstprec = new list<CreatePrecalificacion>();
        precal.empresa_jamar = 'JA'; 
        precal.tipo_identificacion = 'CC'; 
        precal.identificacion = '1129514335';
        precal.cod_pais = '01';
        precal.cod_departamento = 'AT';
        precal.cod_ciudad = 'BQ';
        precal.cod_barrio = '0013';
        precal.direccion = 'CR 8 51B 75';
        precal.correo = 'BRAYANSILVERAQ@HOTMAIL.COM';
        precal.primer_nombre = 'JENNIFER';
        precal.segundo_nombre = '';
        precal.primer_apellido = 'CARVAJALINO';
        precal.segundo_apellido = '';
        precal.senas = 'CASA GRANDE';
        precal.estado_civil = 'S';
        precal.celular = '3456789743';
        precal.numero_hijos = 0;
        precal.ocupacion = '2';
        precal.empresa = '00001';
        precal.cargo = '17';
        precal.cod_eps = '41';
        precal.cod_eps_cotiza = 'C';
        precal.cod_tipo_vivienda = '3';
        precal.cod_tipo_contrato = '4';
        precal.tiempo_vivienda = 7;
        precal.unidad_medida_tiempo_vivienda = 'Anos';
        precal.tiempo_contrato = 7;
        precal.unidad_medida_tiempo_contrato = 'Anos';
        precal.ingresos = 3000000;
        precal.id_op = '';
        precal.id_estudio = 'JA_95_3386996';
        lstprec.add(precal);
        System.debug(lstprec);

        CreatePrecalificacion.createPrecalificacion(lstprec);
        Test.stopTest();
        
    }

    
    static testMethod void test_create_precalificacionSinEstudio(){
        Test.startTest();
		CreatePrecalificacion precal = new CreatePrecalificacion();
        list<CreatePrecalificacion> lstprec = new list<CreatePrecalificacion>();
        precal.empresa_jamar = 'JA'; 
        precal.tipo_identificacion = 'CC'; 
        precal.identificacion = '1129514335';
        precal.cod_pais = '01';
        precal.cod_departamento = 'AT';
        precal.cod_ciudad = 'BQ';
        precal.cod_barrio = '0013';
        precal.direccion = 'CR 8 51B 75';
        precal.correo = 'BRAYANSILVERAQ@HOTMAIL.COM';
        precal.primer_nombre = 'JENNIFER';
        precal.segundo_nombre = '';
        precal.primer_apellido = 'CARVAJALINO';
        precal.segundo_apellido = '';
        precal.senas = 'CASA GRANDE';
        precal.estado_civil = 'S';
        precal.celular = '3456789743';
        precal.numero_hijos = 0;
        precal.ocupacion = '2';
        precal.empresa = '00001';
        precal.cargo = '17';
        precal.cod_eps = '41';
        precal.cod_eps_cotiza = 'C';
        precal.cod_tipo_vivienda = '3';
        precal.cod_tipo_contrato = '4';
        precal.tiempo_vivienda = 7;
        precal.unidad_medida_tiempo_vivienda = 'Anos';
        precal.tiempo_contrato = 7;
        precal.unidad_medida_tiempo_contrato = 'Anos';
        precal.ingresos = 3000000;
        precal.id_op = 'JA_01_2022_2929470';
        precal.id_estudio = '';
        lstprec.add(precal);
        System.debug(lstprec);

        CreatePrecalificacion.createPrecalificacion(lstprec);
        Test.stopTest();
        
    }

    @IsTest static void test_Precalificacion1(){
        
        Precalificacion.processTypeIdentify('PASAPORTE');
        Precalificacion.processDate(7, 'Meses');
    }

    @IsTest static void test_Precalificacion2(){
        Precalificacion.processTypeIdentify('NIT');       
    }

    @IsTest static void test_Precalificacion3(){
        Precalificacion.processTypeIdentify('CEDULA DE EXTRANJERIA');             
    }

    @IsTest static void test_Precalificacion4(){
        Precalificacion.processTypeIdentify('TARJETA DE EXTRANJERIA');
    }


}