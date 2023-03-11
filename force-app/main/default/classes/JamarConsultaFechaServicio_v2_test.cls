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
    @invocablevariable(Label='nom_proveedor' required=true)
    public string nom_proveedor;
    @invocablevariable(Label='nit_proveedor' required=true)
    public string nit_proveedor;
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
    @invocablevariable(Label='tipo_diagnostico' required=true)
    public string tipo_diagnostico;
    @invocablevariable(Label='descripcion_caso' required=true)
    public string descripcion_caso;
    @invocablevariable(Label='dano_producto' required=true)
    public string dano_producto;
    @invocablevariable(Label='ubicacion_dano' required=true)
    public string ubicacion_dano;
    
    public JamarConsultaFechaServicio_v2_test() {
      this.cod_prod = '7023140';
      this.nom_proveedor = 'MUEBLES Y DECORACIONES EDINSA SAS';
      this.nit_proveedor = '900944052';
      this.company = 'JA';
      this.agr = '95';
      this.per = '2022';
      this.rem = '3098985';
      this.tipo_sol = 'CAMBIO'; 
      this.no_caso = '481101';
      this.tipo_diagnostico = 'Estructura';
      this.descripcion_caso = 'QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO';
      this.dano_producto = 'Proceso de Fabricacion-Tendido-TENDIDO TRAQUEA;';
      this.ubicacion_dano = 'ESTRUCTURA;';
    }

    @istest 
    static void TestConsultaCalendario() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, 
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor, 
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     testeo.tipo_sol, 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      Test.startTest();
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      System.debug(endPoint);
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N", "COD_BOD_ENTRADA": "14", "COD_BOD_SALIDA": "72","fechasCalendario": [{"FECHA_PICKING_E": "2022-06-29","FECHA_ENTREGA": "2022-06-30"}]}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

    @istest 
    static void TestAsignaCalendario() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     testeo.tipo_sol, 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      System.debug(endPoint);
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod_ent": "14","cod_bod_sal": "72","no_caso": "123456","fecha_picking_r": "2022-06-28","fecha_recogida": "2022-06-29","fecha_picking_e": "2022-06-28","fecha_entrega": "2022-06-29","tipo_calendario": "N","tipo_sol": "CAM","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO","proveedor": "MUEBLES THAMARA SAS - 900991767","dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;","ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '10000');
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
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod, 
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor, 
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'CAMBIO_PARCIAL', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "CAM","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N", "COD_BOD_ENTRADA": "14", "COD_BOD_SALIDA": "72","fechasCalendario": [{"FECHA_PICKING_E": "2022-06-29","FECHA_ENTREGA": "2022-06-30"}]}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioCamParcial() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'CAMBIO_PARCIAL', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod_ent": "14","cod_bod_sal": "72","no_caso": "123456","fecha_picking_r": "2022-06-28","fecha_recogida": "2022-06-29","fecha_picking_e": "2022-06-28","fecha_entrega": "2022-06-29","tipo_calendario": "N","tipo_sol": "CAM_PARCIAL","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO","proveedor": "MUEBLES THAMARA SAS - 900991767","dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;", "ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true, "message": "Cita asignada exitosamente"}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestConsultaCalendarioTaller() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'TALLER', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "TAL","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true,"TIPO_CALENDARIO": "N", "COD_BOD_ENTRADA": "56", "COD_BOD_SALIDA": "56","fechasCalendario": [{"FECHA_PICKING_R": "2022-06-29","FECHA_RECOGIDA": "2022-06-30", "FECHA_PICKING_E": "2022-07-06", "FECHA_ENTREGA": "2022-07-07"}]}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      //JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioTaller() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'TALLER', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock_v2(200));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod_ent": "56","cod_bod_sal": "56","no_caso": "123456","fecha_picking_r": "2022-06-28","fecha_recogida": "2022-06-29","fecha_picking_e": "2022-07-14","fecha_entrega": "2022-07-15","tipo_calendario": "N","tipo_sol": "TAL","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO","proveedor": "MUEBLES THAMARA SAS - 900991767","dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;","ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '10000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": true, "message": "Cita asignada exitosamente"}';
      //System.assertEquals(actualValue, expectedValue);
      System.assertEquals(200, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestConsultaCalendarioCodigo400() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'TALLER', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('CalendarioCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaServicioMock_v2(400));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "TAL","cod_prod": "7009962"}','POST','25000');
      String contentType = response.getHeader('Content-Type');
      System.assert(contentType == 'application/json');
      String actualValue = response.getBody();
      System.debug(response.getBody());
      String expectedValue = '{"success": False, "message": "No se encuentra la bodega rda"}';
      System.assertEquals(actualValue, expectedValue);
      System.assertEquals(400, response.getStatusCode());
      JamarConsultaFechaServicio_v2.ConsultaServicio(citaServ);
      Test.stopTest();
  }

  @istest 
  static void TestAsignaCalendarioCodigo400() {
      JamarConsultaFechaServicio_v2_test testeo = new JamarConsultaFechaServicio_v2_test();
	  JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'CAMBIO', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock_v2(400));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA", "agr": "C1","per": "2021","rem": "2776746","tipo_sol": "TAL","cod_prod": "7009962"}','POST','25000');
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
      JamarConsultaFechaServicio_v2 citaServicio = new JamarConsultaFechaServicio_v2(testeo.cod_prod,
                                                                                     testeo.nom_proveedor, 
                                                                                     testeo.nit_proveedor,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'CAMBIO', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano);
      list<JamarConsultaFechaServicio_v2> citaServ = new list<JamarConsultaFechaServicio_v2> ();
      citaServ.add(citaServicio);
      String endPoint = Endpoint__mdt.getInstance('AsignacionCitaServicio').URL__c;
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new JamarAsignacionCitaServicioMock_v2(500));
      HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod_ent": "56","cod_bod_sal": "56","no_caso": "123456","fecha_picking_r": "2022-06-28","fecha_recogida": "2022-06-29","fecha_picking_e": "2022-06-28","fecha_entrega": "2022-06-29","tipo_calendario": "N","tipo_sol": "TAL","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO","proveedor": "MUEBLES THAMARA SAS - 900991767","dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;","ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '10000');
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