@IsTest
public class JamarAsignacionEntregaCambioTest {
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
    @invocablevariable(Label='tipo_diagnostico' required=true) 
    public string tipo_diagnostico;
    @invocablevariable(Label='descripcion_caso' required=true) 
    public string descripcion_caso;
    @invocablevariable(Label='dano_producto' required=true) 
    public string dano_producto;
    @invocablevariable(Label='ubicacion_dano' required=true) 
    public string ubicacion_dano;
    @invocablevariable(Label='fecha_picking_e' required=true) 
    public Date fecha_picking_e;
    @invocablevariable(Label='fecha_entrega' required=true) 
    public Date fecha_entrega;
    @invocablevariable(Label='codigoBodega' required=true) 
    public string codigoBodega;
    @invocablevariable(Label='tipoCalendario' required=true) 
    public string tipoCalendario;
    
    public JamarAsignacionEntregaCambioTest() {
        this.cod_prod = '7023140';
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
        this.fecha_picking_e = date.newInstance(2023, 02, 22);
        this.fecha_entrega = date.newInstance(2023, 02, 23);
        this.codigoBodega = 'O';
        this.tipoCalendario = '72';
    }
    
    @istest 
    static void JamarAsignacionEntregaCambioTest() {
        JamarAsignacionEntregaCambioTest testeo = new JamarAsignacionEntregaCambioTest();
        JamarAsignacionEntregaCambio citaServicio = new JamarAsignacionEntregaCambio(testeo.cod_prod,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     testeo.tipo_sol, 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano,
                                                                                     testeo.fecha_picking_e,
                                                                                     testeo.fecha_entrega,
                                                                                     testeo.codigoBodega,
                                                                                     testeo.tipoCalendario);
        list<JamarAsignacionEntregaCambio> citaServ = new list<JamarAsignacionEntregaCambio> ();
        citaServ.add(citaServicio);
        String endPoint = Endpoint__mdt.getInstance('AsignacionCitaEntregaServicio').URL__c;
        System.debug(endPoint);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarAsignacionEntregaCambioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking_e": "2022-06-28","fecha_entrega": "2022-06-29","tipo_calendario": "N","tipo_sol": "CAM","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO", "dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;","ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '10000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": True, "message": "Cita asignada exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarAsignacionEntregaCambio.CitaEntregaCambio(citaServ);
        Test.stopTest();
  }
    
    @istest 
  	static void TestAsignaEntregaCamParcial() {
        JamarAsignacionEntregaCambioTest testeo = new JamarAsignacionEntregaCambioTest();
        JamarAsignacionEntregaCambio citaServicio = new JamarAsignacionEntregaCambio(testeo.cod_prod,
                                                                                     testeo.company, 
                                                                                     testeo.agr, 
                                                                                     testeo.per, 
                                                                                     testeo.rem, 
                                                                                     'CAMBIO_PARCIAL', 
                                                                                     testeo.no_caso,
                                                                                     testeo.tipo_diagnostico,
                                                                                     testeo.descripcion_caso,
                                                                                     testeo.dano_producto,
                                                                                     testeo.ubicacion_dano,
                                                                                     testeo.fecha_picking_e,
                                                                                     testeo.fecha_entrega,
                                                                                     testeo.codigoBodega,
                                                                                     testeo.tipoCalendario);
        list<JamarAsignacionEntregaCambio> citaServ = new list<JamarAsignacionEntregaCambio> ();
        citaServ.add(citaServicio);
        String endPoint = Endpoint__mdt.getInstance('AsignacionCitaEntregaServicio').URL__c;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JamarAsignacionEntregaCambioMock(200));
        HttpResponse response  = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, '{"company": "JA","agr": "C1","per": "2022","rem": "2929469","cod_prod": "7023661","cod_bod": "72","no_caso": "123456","fecha_picking_e": "2022-06-28","fecha_entrega": "2022-06-29","tipo_calendario": "N","tipo_sol": "CAM_PARCIAL","diagnostico": "Estructura: QUE TIENE EL PRODUCTO: SE SIENTE UN VACIO EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO EN QUE PARTE: EN LA ESQUINA PARTE IZQUIERDA DEL SOFA ESQUINERO DONDE SE ENCUENTRA: En una pieza del producto DIRECCION: CR  16B  45G  08 | BARRANQUILLA/ATLANTICO","dano_producto": "Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIOS EN MAL ESTADO; Proceso de Fabricacion-Platinas-Uniones-Accesorios-ACCESORIO MAL INSTALADO; Logistica y Transporte-Maltrato-MALTRATO DEBAJO DEL EMPAQUE;", "ubicacion_dano": "PUFF PARTE SUPERIOR; SOFA SOCALO;"}', 'POST', '25000');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"success": True, "message": "Cita asignada exitosamente"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        JamarAsignacionEntregaCambio.CitaEntregaCambio(citaServ);
        Test.stopTest();
    }
}