@isTest
public class Generic_test_methods_call_service {
    
    @invocablevariable(Label='id_departamento' required=true)
    public string id_departamento;
    @invocablevariable(Label='id_ciudad' required=true)
    public string id_ciudad;
  	@invocablevariable(Label='id_actividad' required=true)
    public string id_actividad;
    @invocablevariable(Label='response_service_positive' required=true)
    public string response_service_positive;
    @invocablevariable(Label='response_service_negative' required=true)
    public string response_service_negative;
    @invocablevariable(Label='response_service_negative' required=true)
    public string response_service_negative_0;
    @invocablevariable(Label='empresa' required=true)
    public string empresa;
    
    public Generic_test_methods_call_service(){
                       this.id_departamento = 'AT';
        			   this.empresa = 'JAMAR';
                       this.id_ciudad = 'AP';
                       this.id_actividad = '1';
        			   this.response_service_positive = '{"success":true,"data":{"c_emp":"","c_agr":"","c_est":"","n_ide":"","estado":"","subestado":"","piloto":"","pilexpress":"N","cupo_max":15000000,"cupo_disp":15000000,"puntajelisim":null,"cuotasugmax":733985,"lectura_data":"","accsug_credito":"","accsug_tj":"","tipo_cliente":"","des_tcliente":"","pot_tj":"","calcularlectura":"","segmento":"","usuario":"","pasesaldo":null,"aplicascore":"E","ususimulador":"","tipomodelo":"","act_pottj":"","act_cupo":"","ct_estado":"","cue":"","tcre":"","agecue":"","total":null,"saldo":null,"fup":"","estcar":"","mostrar_menspiloto":"","tipoprecalf":"","scorefinal":null,"accsuglisim":"","fecaccsug ":"","acciones_sug":"","desc_accsugcr":"","desc_accsugtj ":"","identifica_datacredito":"","codmodelo ":"","evaltipocliente":"","tipo_estudio":"","programa ":"","modulo":"","maquina":""},"ps_nuCodError":null,"ps_vcMensError":null}';
 					   this.response_service_negative = '{"detail":"Error interno al guardar datos en el paquete PkDaoMiembros en el procedimiento ProGrabar"}';
        			   this.response_service_negative_0 = '{"success":false,"data":{"c_emp":"","c_agr":"","c_est":"","n_ide":"","estado":"","subestado":"","piloto":"","pilexpress":"N","cupo_max":15000000,"cupo_disp":15000000,"puntajelisim":null,"cuotasugmax":733985,"lectura_data":"","accsug_credito":"","accsug_tj":"","tipo_cliente":"","des_tcliente":"","pot_tj":"","calcularlectura":"","segmento":"","usuario":"","pasesaldo":null,"aplicascore":"E","ususimulador":"","tipomodelo":"","act_pottj":"","act_cupo":"","ct_estado":"","cue":"","tcre":"","agecue":"","total":null,"saldo":null,"fup":"","estcar":"","mostrar_menspiloto":"","tipoprecalf":"","scorefinal":null,"accsuglisim":"","fecaccsug ":"","acciones_sug":"","desc_accsugcr":"","desc_accsugtj ":"","identifica_datacredito":"","codmodelo ":"","evaltipocliente":"","tipo_estudio":"","programa ":"","modulo":"","maquina":""},"ps_nuCodError":null,"ps_vcMensError":null}';

            }
    
    
    @istest static void test_services_obtener_tipo_cotizacion(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'contributor_list';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerTipoCotizantes.getTypeCotizantes();
        Test.stopTest();
    }
    @istest static void test_services_obtener_cargo_empleado(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'job_titles';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerCargoEmpleado.getCargo();
        Test.stopTest();
    }
    @istest static void test_services_obtener_departamentos(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/departments';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerDepartamentos.getState();
        Test.stopTest();
    }
    
    @istest static void test_services_obtener_empresas(){
        
        
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
        ObtenerEmpresa empresas = new ObtenerEmpresa(testing.empresa);
        list<ObtenerEmpresa> listEmpresas = new list<ObtenerEmpresa>();
        listEmpresas.add(empresas);
      
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'enterprise_list/?nom_empresa=JAMAR';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET', '3000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerEmpresa.getEmpresa(listEmpresas);
        Test.stopTest();
    }
    @istest static void test_services_obtener_estado_civil(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'estado_civil';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerEstadoCivil.getEstadoCivil();
        Test.stopTest();
    }
    
    @istest static void test_services_obtener_genero(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'genero';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerGenero.getGenre();
        Test.stopTest();
    }
    
    @istest static void test_services_obtener_ocupaciones(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'occupations';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerOcupaciones.getOcupacion();
        Test.stopTest();
    }
    @istest static void test_services_obtener_tipo_contrato(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'contract_type';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerTipoContrato.getTipoContrato();
        Test.stopTest();
    }
    @istest static void test_services_obtener_tipo_vivienda(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'type_housing';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerTipoVivienda.getTypeHousing();
        Test.stopTest();
    }
    
    @istest static void test_services_obtener_vias(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/ways';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerVias.getVia();
        Test.stopTest();
    }
    
    @istest static void test_services_obtener_eps(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'eps_list';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerEPSController.getEPS();
        Test.stopTest();
    }
    
    @istest static void test_services_ciudad(){
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
        ObtenerCiudades ciudades = new ObtenerCiudades(testing.id_departamento);
        list<ObtenerCiudades> listCiudades = new list<ObtenerCiudades>();
        listCiudades.add(ciudades);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/cities/AT';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerCiudades.getCities(listCiudades);
        Test.stopTest();


    }
    
     @istest static void test_services_barrio(){
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
        ObtenerBarrios barrios = new ObtenerBarrios(testing.id_departamento, testing.id_ciudad);
        list<ObtenerBarrios> listBarrios = new list<ObtenerBarrios>();
        listBarrios.add(barrios);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'address/neighborhood/AT/AP';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        
        ObtenerBarrios.getBarrios(listBarrios);
        Test.stopTest();


    }
    
     @istest static void test_services_actividades(){
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
        ObtenerActividades actividades = new ObtenerActividades(testing.id_actividad);
        list<ObtenerActividades> listActividades = new list<ObtenerActividades>();
        listActividades.add(actividades);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'activities/1';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerActividades.getActividades(listActividades);
        Test.stopTest();
    }
    @istest static void test_services_positive(){
        Test.startTest();
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
		ProcesaRespuestaPrecalificacion respuestas = new ProcesaRespuestaPrecalificacion(testing.response_service_positive);
		list<ProcesaRespuestaPrecalificacion> listRespuestas = new list<ProcesaRespuestaPrecalificacion>();
        listRespuestas.add(respuestas);
        ProcesaRespuestaPrecalificacion.processResponse(listRespuestas);
        Test.stopTest();
    }
    @istest static void test_services_negative(){
        Test.startTest();
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
		ProcesaRespuestaPrecalificacion respuestas = new ProcesaRespuestaPrecalificacion(testing.response_service_negative);
		list<ProcesaRespuestaPrecalificacion> listRespuestas = new list<ProcesaRespuestaPrecalificacion>();
        listRespuestas.add(respuestas);
        ProcesaRespuestaPrecalificacion.processResponse(listRespuestas);
        Test.stopTest();
    }
     @istest static void test_services_negative_0(){
        Test.startTest();
        Generic_test_methods_call_service testing = new Generic_test_methods_call_service();
		ProcesaRespuestaPrecalificacion respuestas = new ProcesaRespuestaPrecalificacion(testing.response_service_negative_0);
		list<ProcesaRespuestaPrecalificacion> listRespuestas = new list<ProcesaRespuestaPrecalificacion>();
        listRespuestas.add(respuestas);
        ProcesaRespuestaPrecalificacion.processResponse(listRespuestas);
        Test.stopTest();
    }
     @istest static void test_services_interiores_1(){
        
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
         String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'interiors_1/JA';
         HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
         String contentType = response.getHeader('Content-Type');
         System.assert(contentType == 'application/json');
         System.assertEquals(200, response.getStatusCode());
         ObtenerInteriores1.getInteriores1();
         Test.stopTest();
     }
    @istest static void test_services_interiores_2(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'interiors_2/JA';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerInteriores2.ObtenerInteriores2();
        Test.stopTest();
    }

    @istest static void test_services_obtener_Paises(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Generic_response_mock());
        String endPoint = Endpoint__mdt.getInstance('PrecalificacionPreload').URL__c  + 'paises/JA';
        HttpResponse response  = JamarConsumoHTTP.callServiceExternal(endPoint, '', 'GET',null);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(200, response.getStatusCode());
        ObtenerPaises.getPaises();
        Test.stopTest();
    }

}