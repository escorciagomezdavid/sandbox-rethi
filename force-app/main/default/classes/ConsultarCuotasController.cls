public without sharing class ConsultarCuotasController {

    @AuraEnabled    
    public static String consultarCuotas(Id recordId){
        try {
            String endPoint = Endpoint__mdt.getInstance('CuotasPorCartera').URL__c;
            DatosDeEnvio requestClass = new DatosDeEnvio();

            if (String.valueOf(recordId.getsobjecttype()) == 'Factura__c') {
                endPoint = Endpoint__mdt.getInstance('CuotasPorFactura').URL__c;   

                Factura__c factura = [Select Name, IdAgencia__c, IdCartera__c, Idfactura__c, Numero_cliente__r.Empresa__c, 
                                    Numero_cliente__r.Identificacion__c, Numero_cliente__r.IdCliente__c
                                    From Factura__c Where Id =: recordId];
                
                String idCarteraCompleto = factura.IdCartera__c;
                String[] idCartera = idCarteraCompleto.split('_');
                String empresa = idCartera[0];
                String agenciaId = idCartera[1];
                String tipoCuenta = idCartera[2];
                String cuenta = idCartera[3];

                requestClass.agencia = agenciaId;
                requestClass.T_Cre = tipoCuenta;
                requestClass.numCuenta  = cuenta;
                requestClass.factura  = factura.Name;
               

            }else {
                Cartera__c cartera = [Select IdAgencia__c, IdCartera__c, AccountId__r.Identificacion__c, AccountId__r.IdCliente__c From Cartera__c Where Id =: recordId];

                String idCarteraCompleto = cartera.IdCartera__c;
                String[] idCartera = idCarteraCompleto.split('_');
                String empresa = idCartera[0];
                String agenciaId = idCartera[1];
                String tipoCuenta = idCartera[2];
                String cuenta = idCartera[3];

                requestClass.agencia = agenciaId;
                requestClass.T_Cre = tipoCuenta;
                requestClass.numCuenta  = cuenta;
                requestClass.identificacion = cartera.AccountId__r.Identificacion__c; 
            }

            HttpRequest request = new HttpRequest(); 
            request.setMethod('POST');
            request.setEndpoint(endPoint);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
            request.setTimeout(120000);
            
            System.debug('requestClass: ' + requestClass);
            request.setBody(JSON.serialize(requestClass)); 
            
            Http http = new Http();
            HttpResponse response = http.send(request);
            System.debug(response.getBody());
            
            return response.getBody();
        } catch (Exception e) {
            System.debug(e.getMessage());

            //registrar error en bitacora
			Log__c logError=new Log__c(
                type__c = 'Consumo en ws',
                date__c = Datetime.now(),
                JSON__c = '',
                Empresa__c = 'JA',
                success__c = false,
                message__c = e.getMessage(),
                ClassName__c='COMPONENTE CUOTAS');
			//insert logError;

            return null;
        }
    }
    
    public class DatosDeEnvio{

        public string agencia {get;set;}
        public string T_Cre {get;set;}
        public string numCuenta {get;set;}
        public string factura {get;set;}
        public string identificacion {get;set;}

    }
}