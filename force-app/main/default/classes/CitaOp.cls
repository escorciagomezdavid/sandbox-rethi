/*************************************************************************
Nombre de la Clase:     CitaOp
Versión :               1.0
Fecha de Creación :     13/02/2023
Funcionalidad :          Consulta de informacion de las diferentes fases del proceso de cita.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez        13/02/2023       Versión Original
* 

*************************************************************************/
public with sharing class CitaOp {

    public List<Data> data;
    public class Data {
        public String CITA_ENTREGA;
    }
    @AuraEnabled public String tecnico;
    @AuraEnabled public String recurso;
    @AuraEnabled public List<String> fechas;
    @AuraEnabled public String mensaje;
    
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
                }else{
                    dataFinalForComponent.add('ERROR EN EL CONSUMO');
                    return dataFinalForComponent;
                }
            }else{
                UtilitiesClass.crearLog('Consumo en ws', empresa, 'Consulta_Cita_Entrega', data, body);
                dataFinalForComponent.add('ERROR EN EL CONSUMO');
                return dataFinalForComponent;
            }

        }catch(Exception e){
            System.debug(e);
            UtilitiesClass.crearLog('Consumo en ws', empresa, 'Consulta_Cita_Entrega', e.getMessage(), body);
            dataFinalForComponent.add('ERROR EN EL CONSUMO');
            return dataFinalForComponent;
        }
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
            HttpResponse response2 =JamarConsumoHTTP.callServiceExternalWithTimeOut(url, body, 'POST','2500');
            Answerx.add(response2.getBody());
            String data = Answerx[0];
            System.debug(data);
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        }catch(Exception e){
            System.debug(e);
        }
    }

    public static String validacionCitaEntrega(String idOp, String citaEntrega, String usuario, Boolean reasignacion){

        String url;
        List<Opportunity> identificacion= [Select Id,Identificaci_n_del_cliente__c from Opportunity where IdOP__c = :idOp];
        String n_ide = identificacion[0].Identificaci_n_del_cliente__c;
        List<TaskResponse> updateTask = new List<TaskResponse>();
        list <String> Answerx = new list<String>();
        List<String> fechaList = new List<String>();
        MiddlewareActivity datos = new MiddlewareActivity();

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
            url = endPoint + empresa + '/validacionCitaEntrega?n_ide=' + n_ide + '&rem=' + Op + '&c_agr=' + agencia + '&per=' + periodo;
            HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, null, 'GET',null);
            Integer codigo = response.getStatusCode();
            Answerx.add(response.getBody());
            String data = Answerx[0];
            CitaOp jsonParseds = (CitaOp) System.JSON.deserialize(data, CitaOp.class);
            if(codigo ==200){
                if(jsonParseds.data[0].CITA_ENTREGA !='' || jsonParseds.data[0].CITA_ENTREGA != null){
                    String aplicaArmado = lwcCitaOp.aplicaArmado(idOp);
                    list<Case> casosAbiertos = [SELECT Id,Status FROM Case WHERE Oportunidad__c =:identificacion[0].Id];
                    if(aplicaArmado == 'NO ARMABLE'){
                        updateTask = ActivityClass.ActualizarTarea(Op, 'Completed', usuario,'Asignacion de Cita de Entrega y Armado de OP');
                        if(reasignacion == true){
                            datos.Actividad.asunto='Reasignacion de Cita de Entrega y Armado de OP';
                            datos.Actividad.estado='Completed';
                            datos.Actividad.fechaVencimiento= date.today();
                            datos.Actividad.numeroOp=Op;
                            datos.Actividad.identificacion=n_ide;
                            datos.Actividad.usuario=usuario;
                            ActivityClass.CrearTarea(datos);
                        }
                    }else if(!casosAbiertos.isEmpty()){
                        System.debug(casosAbiertos);
                        casosAbiertos[0].Status='Cerrado';
                        update casosAbiertos[0];
                    }                               
                    return 'CITA ASIGNADA EXITOSAMENTE';
                }else{
                    UtilitiesClass.crearLog('Consumo en ws', empresa, 'Validacion_Cita_Entrega', data, url); 
                    return 'CITA NO FUE ASIGNADA';
                }
            }else{
                UtilitiesClass.crearLog('Consumo en ws', empresa, 'Validacion_Cita_Entrega', data, url);
                return 'CITA NO FUE ASIGNADA';
            }


        }catch(Exception e){
            UtilitiesClass.crearLog('Consumo en ws', empresa, 'Validacion_Cita_Entrega', e.getMessage(), url);    
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
            HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, body, 'POST',null);
            Answerx.add(response.getbody());
            Integer codigo = response.getStatusCode();
            String data = Answerx[0];
            Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
            if(codigo == 200){
                String calendario = String.ValueOf(jsonParseds.get('calendar'));
                String tecnic = String.ValueOf(jsonParseds.get('tecnico'));
                String recurso = String.ValueOf(jsonParseds.get('recurso'));
                Set<String> sString = new Set<String>();    
                if(calendario != null || calendario != ''){
                    for(String c : calendario.split(';')){
                        String subfecha = c.substring(0, 10);
                        sString.add(subfecha);
                    }
                    List<String> contenedor = new list<String>(sString);
                    for(Integer i=0;i<contenedor.size();i++){
                        String valor =  String.valueOf(contenedor[i]);
                        Date x = Date.valueOf(valor);
                        String valor2= valor.substringBefore(':');
                        DateTime dt = DateTime.newInstance(x.year(), x.month(),x.day());
                        String format = 'YYYY-MM-dd';
                        String fechas = dt.format(format);
                        value.add(fechas);
                                                    
                    }
                    armado.fechas=value;
                    armado.recurso=recurso;
                    armado.tecnico=tecnic;
                    armado.mensaje= 'CALENDARIO EXITOSO';
                }else{
                    armado.mensaje= 'CALENDARIO NO EXITOSO';
                }
                respArmado.add(armado);
                return respArmado;
            }else{
                armado.mensaje=data;
                respArmado.add(armado);
                return respArmado;
            }
        }catch(Exception e){
            UtilitiesClass.crearLog('Consumo en ws', empresa, 'Consulta_Cita_Armado', e.getMessage(), body);
            armado.mensaje='ERROR DEL CONSUMO';
            respArmado.add(armado);
            return respArmado;
        }
    }

    public static String asignacionCitaArmado(String idOp, String codigoPais, String citaArmado, String tecnico,
                                            String codRecurso, Boolean reasignacion,String usuario){

                                            String body;
                                            MiddlewareActivity datos = new MiddlewareActivity();
                                            List <String> Answerx = new list<String>();
                                            List<String> fechaList = new List<String>();
                                            List<TaskResponse> updateTask = new List<TaskResponse>();
                                            List<Opportunity> identificacion= [Select Id,Identificaci_n_del_cliente__c from Opportunity where IdOP__c = :idOp];
                                            for(String st : citaArmado.split('-')){         
                                                fechaList.add(st);
                                            }
                                            String ano = fechaList[0];
                                            String mes = fechaList[1];
                                            String dia = fechaList[2];
                                    
                                            String mydate = ano + '' + mes + ''+dia;

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
                                            String url= endPoint+empresa+'/assembly-express';

                                            try{
                                                Map<String, Object> objson = new Map<String, Object>();
                                                objson.put('country',codigoPais);
                                                objson.put('codeModel','02');
                                                objson.put('date', mydate);
                                                objson.put('rem',Op);
                                                objson.put('agency', agencia);
                                                objson.put('tecnico',tecnico);
                                                objson.put('codRecurso',codRecurso);
                                                objson.put('unitType', 'J1');
                                                body = String.valueOf(JSON.Serialize(objson));
                                                System.debug(body);
                                                HttpResponse response =JamarConsumoHTTP.callServiceExternal(url, body, 'PUT',null);
                                                Answerx.add(response.getbody());
                                                String data = Answerx[0];
                                                Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
                                                String calendario = String.ValueOf(jsonParseds.get('calendar'));
                                                if(calendario == 'OK'){
                                                    updateTask = ActivityClass.ActualizarTarea(Op, 'Completed', usuario,'Asignacion de Cita de Entrega y Armado de OP');
                                                    if(reasignacion == true){
                                                        datos.Actividad.asunto='Reasignacion de Cita de Entrega y Armado de OP';
                                                        datos.Actividad.estado='Completed';
                                                        datos.Actividad.fechaVencimiento= date.today();
                                                        datos.Actividad.numeroOp=Op;
                                                        datos.Actividad.identificacion=identificacion[0].Identificaci_n_del_cliente__c;
                                                        datos.Actividad.usuario=usuario;
                                                        ActivityClass.CrearTarea(datos);
                                                    }
                                                    return 'CITA ASIGNADA EXITOSAMENTE';
                                                }else{
                                                    UtilitiesClass.crearLog('Consumo en ws', empresa, 'Asignar_Cita_Armado', data, body);
                                                    return 'CITA NO FUE ASIGNADA';
                                                }

                                            }catch(Exception e){
                                                UtilitiesClass.crearLog('Consumo en ws', empresa, 'Asignar_Cita_Armado',e.getMessage() , body);
                                                return 'CITA NO FUE ASIGNADA';

                                            }
                                            }


}