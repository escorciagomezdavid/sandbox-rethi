public class CreatePrecalificacion  {

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
     @invocablevariable(Label='Celular')
     public string celular;
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
     
     public CreatePrecalificacion(){}


    @InvocableMethod(Label='Crear Precalificacion')
    public static list<responsePC> createPrecalificacion(list<CreatePrecalificacion> createPrecalificacion){
        Map<String, Object> objson = new Map<String, Object>();
        list <String> Answerx = new list<String>();
        list<responsePC> lstResponse = new list<responsePC>();
        responsePC rp = new responsePC();
        String tipo_identificacion = Precalificacion.processTypeIdentify(createPrecalificacion[0].tipo_identificacion);
        String fecha_tiempo_vivienda = Precalificacion.processDate(createPrecalificacion[0].tiempo_vivienda, createPrecalificacion[0].unidad_medida_tiempo_vivienda);
        String fecha_tiempo_contrato = Precalificacion.processDate(createPrecalificacion[0].tiempo_contrato, createPrecalificacion[0].unidad_medida_tiempo_contrato);

        if (createPrecalificacion[0].id_op == null || createPrecalificacion[0].id_op == ''){
                rp.mensaje='No tiene Id OP';
                rp.success=false;
                lstResponse.add(rp);
                return lstResponse;
        }

        if (createPrecalificacion[0].id_estudio == null || createPrecalificacion[0].id_estudio == ''){
                rp.mensaje='No tiene Id Estudio';
                rp.success=false;
                lstResponse.add(rp);
                return lstResponse;
        }

        List<String> values_estudio = Precalificacion.processConvertListConcatUnderScoreVariable(createPrecalificacion[0].id_estudio);
        List<String> values_op = Precalificacion.processConvertListConcatUnderScoreVariable(createPrecalificacion[0].id_op);

        List<ResponseGetClienteWithEstudio> getClient = Precalificacion.getClientWithEstudio(createPrecalificacion[0].empresa_jamar, createPrecalificacion[0].identificacion, values_estudio[2], values_estudio[1]);
        
        if (getClient.isEmpty()){
            rp.mensaje='Service /prd/api/v1/catalogo/creditos/client/ Failed';
            rp.success=false;
            lstResponse.add(rp);
            return lstResponse;
        }
        System.debug(createPrecalificacion[0].ocupacion);

        objson.put('c_emp',createPrecalificacion[0].empresa_jamar);
        objson.put('ide',tipo_identificacion);
        objson.put('n_ide',createPrecalificacion[0].identificacion);
        objson.put('c_pai',createPrecalificacion[0].cod_pais);
        objson.put('dep',createPrecalificacion[0].cod_departamento);
        objson.put('ciu',createPrecalificacion[0].cod_ciudad);
        objson.put('bar',createPrecalificacion[0].cod_barrio);
        objson.put('dir_elect',createPrecalificacion[0].correo.toUpperCase());
        objson.put('fecha', getClient[0].FECHA);
        objson.put('usuario',createPrecalificacion[0].usuario);
        objson.put('pri_nom',createPrecalificacion[0].primer_nombre.toUpperCase());
        objson.put('seg_nom',createPrecalificacion[0].segundo_nombre.toUpperCase());
        objson.put('pri_ape',createPrecalificacion[0].primer_apellido.toUpperCase());
        objson.put('seg_ape',createPrecalificacion[0].segundo_apellido.toUpperCase());
        objson.put('senas',createPrecalificacion[0].senas.toUpperCase());
        objson.put('c_cab',getClient[0].C_CAB);
        objson.put('c_pai_nac', '01');
        objson.put('nickname',getClient[0].NICKNAME);
        objson.put('sexo',createPrecalificacion[0].sexo);
        objson.put('est_civil',createPrecalificacion[0].estado_civil);
        objson.put('celular',createPrecalificacion[0].celular);
        objson.put('dir',createPrecalificacion[0].direccion.toUpperCase());
        objson.put('nro_hijos',createPrecalificacion[0].numero_hijos);
        objson.put('iloc_tel',getClient[0].ILOC_TEL);
        objson.put('iloc_cor',getClient[0].ILOC_COR);
        objson.put('fecha_docexpira',getClient[0].FECHA_DOCEXPIRA);
        objson.put('fecha_docexpedicion',createPrecalificacion[0].fecha_docexpedicion);
        objson.put('pais_docexpedicion',getClient[0].PAIS_DOCEXPEDICION);
        objson.put('dpto_docexpedicion',getClient[0].DPTO_DOCEXPEDICION);
        objson.put('ciudad_docexpedicion',getClient[0].CIUDAD_DOCEXPEDICION);
        
        objson.put('fecha_nac',createPrecalificacion[0].fecha_nacimiento);
        objson.put('fecha_cas',getClient[0].FECHA_CAS);
        objson.put('sector_trabajo',getClient[0].SECTOR_TRABAJO);
        objson.put('nivel_riesgo',getClient[0].NIVEL_RIESGO);
        objson.put('canal_vinculacion',getClient[0].CANAL_VINCULACION);
        objson.put('proposito_cr',getClient[0].PROPOSITO_CR);
        objson.put('origen_fondo',getClient[0].ORIGEN_FONDO);
        objson.put('pais_fondo',getClient[0].PAIS_FONDO);
        objson.put('politica_expuesta',getClient[0].POLITICA_EXPUESTA);
        objson.put('fam_politica_expuesta',getClient[0].FAM_POLITICA_EXPUESTA);
        objson.put('nom_fam_politca_expuesta',getClient[0].NOM_FAM_POLITCA_EXPUESTA);
        objson.put('extrecho_colaborador_pep',getClient[0].EXTRECHO_COLABORADOR_PEP);
        objson.put('estado_salud',getClient[0].ESTADO_SALUD);
        objson.put('depto_nac',getClient[0].DEPTO_NAC);
        objson.put('ciudad_nac',getClient[0].CIUDAD_NAC);
        objson.put('sumin',getClient[0].SUMIN);
        objson.put('obs',getClient[0].OBS);
        objson.put('fiador_t',getClient[0].FIADOR_T);
        objson.put('lugar_trabajo',getClient[0].LUGAR_TRABAJO);
        objson.put('barrio_trabajo',getClient[0].BARRIO_TRABAJO);
        objson.put('ciu_trabajo',getClient[0].CIU_TRABAJO);
        objson.put('dpto_trabajo',getClient[0].DPTO_TRABAJO);
        objson.put('tel_trabajo',getClient[0].TEL_TRABAJO);
        objson.put('programa','SALESFORCE');
        objson.put('senas_trabajo',getClient[0].SENAS_TRABAJO);
        objson.put('fiadorpresente',getClient[0].FIADORPRESENTE);
        objson.put('cab_trabajo',getClient[0].CAB_TRABAJO);
        objson.put('parentesco',getClient[0].PARENTESCO);
        objson.put('pais_trabajo',getClient[0].PAIS_TRABAJO);
        objson.put('jornada_trabajo',getClient[0].JORNADA_TRABAJO);
        objson.put('maquina',getClient[0].MAQUINA);
        objson.put('ocupacion',createPrecalificacion[0].ocupacion);
        objson.put('empresa',createPrecalificacion[0].empresa);
        objson.put('cargo',createPrecalificacion[0].cargo);
        objson.put('codigo_eps',createPrecalificacion[0].cod_eps);
        objson.put('eps_cotiza',createPrecalificacion[0].cod_eps_cotiza);
        objson.put('tipo_vivienda',createPrecalificacion[0].cod_tipo_vivienda);
        objson.put('tipo_contrato',createPrecalificacion[0].cod_tipo_contrato);
        objson.put('fecha_tiempo_vivienda', fecha_tiempo_vivienda);
        objson.put('fecha_tiempo_servicio', fecha_tiempo_contrato);
        objson.put('ingresos_principales', String.valueOf(createPrecalificacion[0].ingresos));
        objson.put('actividad_negocio', createPrecalificacion[0].cod_actividad);
        objson.put('c_agr', values_estudio[1]);
        objson.put('c_est', values_estudio[2]);
        objson.put('tipo', createPrecalificacion[0].cod_tipo_cliente);
        objson.put('envia_email', 'S');
        objson.put('modulo', '0002');

        String body = String.valueOf(JSON.Serialize(objson));
        String url = Endpoint__mdt.getInstance('Precalificacion').URL__c;       
        String result_url = url + createPrecalificacion[0].empresa_jamar;
        System.debug(result_url);
        System.debug(body);
        HttpResponse response =JamarConsumoHTTP.callServiceExternalWithTimeOut(result_url, body, 'POST', '30000');
        Answerx.add(response.getBody());
        String data = Answerx[0];
        System.debug(data);
        Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
        rp.success = Boolean.valueOf(jsonParsed.get('success'));
        rp.mensaje = String.valueOf(jsonParsed.get('ps_vcMensError'));
        rp.json = response.getBody();
        
        
        lstResponse.add(rp);
        
        Log__c log = new Log__c();
        log.ClassName__c = 'PrecalificacionBody';
        log.date__c = Datetime.now();
        log.message__c =  'Ok';
        log.Empresa__c = 'Colombia';
        log.JSON__c = body;
        log.success__c = false;
        log.type__c = 'Procesamiento de peticion al ws';
        insert log;
        return lstResponse;
    }

    public class responsePC{
        @invocablevariable(Label='Success' required=true)
        public Boolean success;
        @invocablevariable(Label='JSON' required=true)
        public String json;
        @invocablevariable(Label='Mensaje Error' required=true)
        public String mensaje;
    } 
    
     
}