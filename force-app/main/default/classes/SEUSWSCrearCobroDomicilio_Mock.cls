//is used to help test MJCrearCobroDomicilioAPI with MJCrearCobroDomicilioAPI_Test class
@isTest
global class SEUSWSCrearCobroDomicilio_Mock implements HttpCalloutMock{
  global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        //response.setBody('{"Empresa__c":"JA","IdVisitaCobro__c":"JA_XX_TJ_51224_55312722_21/01/2020","Direccion_visita__c":"CL  23  35  50  BL  G  AP  403","DIa__c":"01-25-2020","Monto_a_pagar__c":"50000","Jornada__c":"MAÑANA","Comentarios_cliente__c":"Realizar una buena inspeccion","depto":"AT","ciudad":"BQ","barrio":"03","c_cab":"BQ","m_pago":"EF" , }');
		response.setBody('{"success":true,"message":"Exito","messageLog":"Oli"}');
        response.setStatusCode(200);
        return response; 
    }
}