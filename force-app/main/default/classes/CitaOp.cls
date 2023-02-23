/*************************************************************************
Nombre de la Clase:     CitaOp
Versión :               1.0
Fecha de Creación :     13/02/2022
Funcionalidad :          Consulta de informacion de las diferentes fases del proceso de cita.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez        13/02/2022       Versión Original
* 

*************************************************************************/
public with sharing class CitaOp {
    public CitaOp() {

    }

    public static list<String> calendarioCitaEntrega(String empresa, String idOp, String tipo){
        String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
        String url= endPoint + empresa +'/delivery-date'; 
        String method = 'POST';
        Map<String, Object> objson = new Map<String, Object>();
        list<String> dataFinalForComponent = new list<String>();
        list <String> Answerx = new list<String>();
        List<String> datosOp = new List<String>();
        String body = '';

        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String Op = datosOp[3];
        objson.put('numOrden',Op);
        objson.put('numCantCitas','6');
        objson.put('tipoDoc',tipo);
            
        body = String.valueOf(JSON.Serialize(objson));
           
        try{
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, body, method,null);
            Answerx.add(response.getBody());
            String data = Answerx[0];
            Integer codigo = response.getStatusCode();
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            if(codigo == 200){
                JamarInterfaceFechasEntregas IFechasList = new JamarInterfaceFechasEntregas();	
                IFechasList = JamarInterfaceFechasEntregas.parse(data);
                if(IFechasList.Response.success == true){
                    for(Integer i=0; i <IFechasList.response.data[0].Fechas.size(); i++ ){
                        if(IFechasList.Response.data[0].Fechas[i].Estado == 'S'){
                            dataFinalForComponent.add(IFechasList.response.data[0].Fechas[i].Fecha);
                        }
                    }
                 return dataFinalForComponent;
                }
            }else{
                Log__c log = new Log__c();
                log.ClassName__c = 'Consulta_Cita_Entrega';
                log.date__c = Datetime.now();
                log.message__c = 'Error en Envio de body: ' +data;
                log.success__c = false;
                log.type__c = 'Consumo en ws';
                log.JSON__c = body;
                if(empresa =='JA'){
                    log.Empresa__c = 'Colombia';
                }else if(empresa =='JP'){
                    log.Empresa__c = 'Panama';
                }            
                insert log;
                dataFinalForComponent.add('ERROR EN EL CONSUMO');
                return dataFinalForComponent;
            }

        }catch(Exception e){
            System.debug(e);
            Log__c log = new Log__c();
            log.ClassName__c = 'Consulta_Cita_Entrega';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = body;
            if(empresa =='JA'){
                log.Empresa__c = 'Colombia';
            }else if(empresa =='JP'){
                log.Empresa__c = 'Panama';
            }            
            insert log; 
            dataFinalForComponent.add('ERROR EN EL CONSUMO');
            return dataFinalForComponent;
        }
        return null;
    }
}