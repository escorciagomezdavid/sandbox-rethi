/*
  Name: JamarConsultaFechaServicio_v2
  Proposito:    Hace peticion test a nuevo servicio que devuelve un conjunto de fechas disponibles de servicio y asigna una fecha de servicio
                de forma automatica.
  Autor: Brian Coronel Ortiz
  Fecha: 02/09/2022
*/

@IsTest
public class JamarConsultaFechaServicio_v2_test {
    
    @invocablevariable(Label='cod_prod' required=true) 
    public string cod_prod;
    @invocablevariable(Label='company' required=true) 
    public string company;
    @invocablevariable(Label='agr' required=true) 
    public string agr;
    @invocablevariable(Label='per' required=true) 
    public string per;
    @invocablevariable(Label='rem' required=true) 
    public string rem;
    @invocablevariable(Label='tipo_sol' required=true) 
    public string tipo_sol;
    @invocablevariable(Label='no_caso' required=true) 
    public string no_caso;
    
    
    public JamarConsultaFechaServicio_v2_test() {
      this.cod_prod = '7023140';
      this.company = 'JA';
      this.agr = '95';
      this.per = '2022';
      this.rem = '3098985';
      this.tipo_sol = 'CAM'; 
      this.no_caso = '481101'; 
    }

    @istest 
    static void TestConsultaCalendario() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, testeo.tipo_sol, testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      Test.startTest();
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962", "no_caso": "481101"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

    @istest 
    static void TestAsignaCalendario() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, testeo.tipo_sol, testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28""fecha_cita": "2022-06-29","fecha_entrega": "2022-07-15""tipo_calendario": "N","tipo_sol": "CAM"}', 'POST', '10000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": True, "message": "Cita asignada exitosamente"}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestConsultaCalendarioCamParcial() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'CAM_PARCIAL', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM_PARCIAL","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioCamParcial() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'CAM_PARCIAL', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28""fecha_cita": "2022-06-29","fecha_entrega": "2022-07-15""tipo_calendario": "N","tipo_sol": "CAM_PARCIAL"}', 'POST', '25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": True, "message": "Cita asignada exitosamente"}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestConsultaCalendarioTaller() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'TAL', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "TAL","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N","COD_BODEGA": "72","fechasCalendario": [{"FECHA_PICKING": "2022-06-29","FECHA_CITA": "2022-06-30"}]}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      //JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioTaller() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'TAL', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28""fecha_cita": "2022-06-29","fecha_entrega": "2022-07-15""tipo_calendario": "N","tipo_sol": "TAL"}', 'POST', '25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": True, "message": "Cita asignada exitosamente"}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestConsultaCalendarioCodigo400() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'TAL', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock(400));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "TAL","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success":False,"message":"No se encuentra la bodega rda"}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(400, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioCodigo400() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'CAM', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(400));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success":False, "message": "Ocurrio un error al asignar su cita"}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(400, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }
    
  @istest 
  static void TestAsignaCalendarioCodigo500() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, testeo.company, testeo.agr, testeo.per, testeo.rem, 'CAM', testeo.no_caso);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(500));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking": "2022-06-28""fecha_cita": "2022-06-29","fecha_entrega": "2022-07-15""tipo_calendario": "N","tipo_sol": "TAL"}', 'POST', '25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success":False, "message": "Internal server error"}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(500, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }
}