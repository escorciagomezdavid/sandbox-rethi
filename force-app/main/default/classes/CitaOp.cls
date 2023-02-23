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

    public List<Data> data;
    public class Data {
        public String CITA_ENTREGA;
    }
    public String tecnico;
    public String recurso;
    public List<String> fechas;
    public String mensaje;
    
    public CitaOp() { }

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

    public static void asignacionCitaOp(String idOp, String citaEntrega,String userOperacion){

        List<String> fechaList = new List<String>();
        List<String> datosOp = new List<String>();
        List <String> Answerx = new list<String>();
        Map<String, Object> objson = new Map<String, Object>();

        for(String st : citaEntrega.split('-')){         
            fechaList.add(st);
        }
        String ano = fechaList[0];
        String mes = fechaList[1];
        String dia = fechaList[2];
        String format_citaEntrega = dia+'/'+mes+'/'+ano;
         /* Asignacion de datos de la Op a las variables**/ 
         for(String st : idOp.split('_')){         
             datosOp.add(st);
         }
         String empresa = datosOp[0];
         String agencia = datosOp[1];
         String periodo = datosOp[2];
         String Op = datosOp[3];

         String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
         String url = endPoint + empresa + '/asignarCitaEntrega';

         try{            
            objson.put('agencia',agencia);
            objson.put('periodo',periodo);
            objson.put('numOp',Op);
            objson.put('tipoDoc','OP');
            objson.put('citaEntrega',format_citaEntrega);
            objson.put('comprMcia', 'S');
            objson.put('origenOper','SALESFORCE');
            objson.put('userOper', userOperacion);
            String body = String.valueOf(JSON.Serialize(objson));        
            HttpResponse response2 =JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
            Answerx.add(response2.getBody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        }catch(Exception e){
            System.debug(e);
        }

    }

    public static String validacionCitaEntrega(String idOp, String citaEntrega, String usuario){

        List<Opportunity> identificacion= [Select Id,Identificaci_n_del_cliente__c from Opportunity where IdOP__c = :idOp];
        String n_ide = identificacion[0].Identificaci_n_del_cliente__c;
        List<TaskResponse> updateTask = new List<TaskResponse>();
        list <String> Answerx = new list<String>();
        List<String> fechaList = new List<String>();

        for(String st : citaEntrega.split('-')){         
            fechaList.add(st);
        }
        String ano = fechaList[0];
        String mes = fechaList[1];
        String dia = fechaList[2];

        /* Asignacion de datos de la Op a las variables**/
        List<String> datosOp = new List<String>();
        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String empresa = datosOp[0];
        String agencia = datosOp[1];
        String periodo = datosOp[2];
        String Op = datosOp[3]; 

        try{
            String endPoint = Endpoint__mdt.getInstance('ValidacionCitaEntrega').URL__c;
            String url = endPoint + empresa + '/validacionCitaEntrega?n_ide=' + n_ide + '&rem=' + Op + '&c_agr=' + agencia + '&per=' + periodo;
            HttpResponse response2 = JamarConsumoHTTP.callServiceExternal(url, null, 'GET',null);
            Answerx.add(response2.getBody());
            String data = Answerx[0];
            CitaOp jsonParseds = (CitaOp) System.JSON.deserialize(data, CitaOp.class);
            if(jsonParseds.data[0].CITA_ENTREGA !='' && jsonParseds.data[0].CITA_ENTREGA != null){
                updateTask = ActivityClass.ActualizarTarea(Op, 'Completed', usuario);
                Case casosAbiertos = [SELECT Id,Status FROM Case WHERE Oportunidad__c =:identificacion[0].Id];
                System.debug(casosAbiertos);
                casosAbiertos.Status='Cerrado';
                update casosAbiertos;
                return 'CITA ASIGNADA EXITOSAMENTE';
            }else{
                Log__c log = new Log__c();
                log.ClassName__c = 'Validacion_Cita_Entrega';
                log.date__c = Datetime.now();
                log.message__c = 'Error en validacion de entrega: ' + data;
                log.success__c = false;
                log.type__c = 'Consumo en ws';
                log.JSON__c = '';
                insert log;  
                return 'CITA NO FUE ASIGNADA';
            }

        }catch(Exception e){
            Log__c log = new Log__c();
            log.ClassName__c = 'Validacion_Cita_Entrega';
            log.date__c = Datetime.now();
            log.message__c = 'Error en validacion de entrega: ' + e.getMessage();
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = '';
            insert log;               
            System.debug(e.getMessage());
            return 'CITA NO FUE ASIGNADA';
        }
    }

    public static List<CitaOp> calendarioCitaArmado(String idOp, String fechaEntrega, String pais){
        
        String body;
        List<CitaOp> respArmado = new List<CitaOp>();
        CitaOp armado = new CitaOp();
        List <String> Answerx = new list<String>();
        List<String> value = new list<String>();
        List<String> fechaList = new List<String>();
        for(String st : fechaEntrega.split('-')){         
            fechaList.add(st);
        }
        String ano = fechaList[0];
        String mes = fechaList[1];
        String dia = fechaList[2];

        String mydate = ano + '' + mes + ''+dia;
        String periodoFecha = ano+''+mes;

        /* Asignacion de datos de la Op a las variables**/
        List<String> datosOp = new List<String>();
        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String empresa = datosOp[0];
        String agencia = datosOp[1];
        String periodoOp = datosOp[2];
        String Op = datosOp[3];

        String endPoint = Endpoint__mdt.getInstance('Cita_Armado').URL__c;
        String url= endPoint+ '/'+empresa+'/assembly-express';

        try{
            Map<String, Object> objson = new Map<String, Object>();
                        objson.put('country',pais);
                        objson.put('codeModel','02');
                        objson.put('codeResource','');
                        objson.put('period',periodoFecha);
                        objson.put('rem',Op);
                        objson.put('perRem', periodoOp);
                        objson.put('agency', agencia);
                        objson.put('service','');
                        objson.put('date', mydate);
            body = String.valueOf(JSON.Serialize(objson));
            System.debug(body);
            System.debug(url);
            HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
            Answerx.add(response.getbody());
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            String calendario = String.ValueOf(jsonParseds.get('calendar'));
            String tecnic = String.ValueOf(jsonParseds.get('tecnico'));
            String recurso = String.ValueOf(jsonParseds.get('recurso'));
            Set<String> sString = new Set<String>();    
            System.debug(data);             
            for(String c : calendario.split(';')){
                        String subfecha = c.substring(0, 10);
                        sString.add(subfecha);
            }
            List<String> contenedor = new list<String>(sString);
            System.debug(contenedor);
            for(Integer i=0;i<contenedor.size();i++){
                String valor =  String.valueOf(contenedor[i]);
                System.debug(valor);
                value.add(valor);
            }
            System.debug(jsonParseds);
            armado.fechas=value;
            System.debug(armado.fechas);
            armado.recurso=recurso;
            armado.tecnico=tecnic;
            respArmado.add(armado);
            System.debug(respArmado);
            return respArmado;
        }catch(Exception e){
            Log__c log = new Log__c();
            log.ClassName__c = 'Consulta_Cita_Armado';
            log.date__c = Datetime.now();
            log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
            log.success__c = false;
            log.type__c = 'Consumo en ws';
            log.JSON__c = body;
            //log.Empresa__c = empresa;
            insert log;
            armado.mensaje='ERROR DEL CONSUMO';
            respArmado.add(armado);
            return respArmado;
        }


    }

    public static String asignacionCitaArmado(String idOp, String codigoPais, String citaArmado, String tecnico,
                                            String codRecurso){

                                            String body;
                                            List <String> Answerx = new list<String>();

                                            /* Asignacion de datos de la Op a las variables**/
                                            List<String> datosOp = new List<String>();
                                            for(String st : idOp.split('_')){         
                                                datosOp.add(st);
                                            }
                                            String empresa = datosOp[0];
                                            String agencia = datosOp[1];
                                            String periodoOp = datosOp[2];
                                            String Op = datosOp[3];
                                            String endPoint = Endpoint__mdt.getInstance('Asignacion_Cita_Armado').URL__c;
                                            String url= endPoint+ '/'+empresa+'/assembly-express';

                                            try{
                                                Map<String, Object> objson = new Map<String, Object>();
                                                objson.put('country',codigoPais);
                                                objson.put('codeModel','02');
                                                objson.put('date', citaArmado);
                                                objson.put('rem',Op);
                                                objson.put('agency', agencia);
                                                objson.put('tecnico',tecnico);
                                                objson.put('codRecurso',codRecurso);
                                                objson.put('unitType', 'J1');
                                                body = String.valueOf(JSON.Serialize(objson));
                                                System.debug(body);
                                                HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
                                                Answerx.add(response.getbody());
                                                String data = Answerx[0];
                                                Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
                                                String calendario = String.ValueOf(jsonParseds.get('calendar'));
                                                if(calendario == 'OK'){
                                                    return 'CITA ASIGNADA CON EXITO';
                                                }else{
                                                    Log__c log = new Log__c();
                                                    log.ClassName__c = 'Asignar_Cita_Armado';
                                                    log.date__c = Datetime.now();
                                                    log.message__c = 'Error en Asignar_Cita_Armado: ' + data;
                                                    log.success__c = false;
                                                    log.type__c = 'Consumo en ws';
                                                    log.JSON__c = '';
                                                    insert log;  
                                                    return 'CITA NO FUE ASIGNADA';
                                                }

                                            }catch(Exception e){
                                                Log__c log = new Log__c();
                                                log.ClassName__c = 'Asignar_Cita_Armado';
                                                log.date__c = Datetime.now();
                                                log.message__c = 'Error en Envio de body: ' + e.getMessage() + body;
                                                log.success__c = false;
                                                log.type__c = 'Consumo en ws';
                                                log.JSON__c = body;
                                                //log.Empresa__c = empresa;
                                                insert log;
                                                return 'CITA NO FUE ASIGNADA';

                                            }
                                            }

}