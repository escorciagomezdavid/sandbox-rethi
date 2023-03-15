/*************************************************************************
Nombre de la Clase:     CitaOp
Versión :               1.0
Fecha de Creación :     13/02/2023
Funcionalidad :         Consulta de informacion de las diferentes fases del proceso de cita.
Clase de Prueba:        CitaOpTest

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez        13/02/2023       Versión Original
* Daniela Sanchez        8/03/2023        Se añade proceso de entregas parciales
* 

*************************************************************************/
public with sharing class CitaOp {

    public List<Data> data;
    public class Data {
        public String CITA_ENTREGA;
    }
    public class Info_rem {
		public String tienda;
		public String per;
		public String numop;
	}
    @AuraEnabled public String tecnico;
    @AuraEnabled public String recurso;
    @AuraEnabled public List<String> fechas;
    @AuraEnabled public String mensaje;
    @AuraEnabled public List<List<JamarInterfaceEntregasParciales>> entregaParcial;

    
    public CitaOp() { }

    public static string aplicaArmadoOp(String idOp){
        try{
            List<OpportunityLineItem> op= [SELECT id FROM OpportunityLineItem WHERE Product2.Armable__c = true and IdOP__c =: idOp];
            if(!op.isEmpty()){
                return 'ARMABLE';
            }else{
                return 'NO ARMABLE';
            }
        }catch(Exception e){
            return e.getMessage();
        }
    }
    public static list<String> calendarioCitaEntrega(String idOp, String tipo){
        Map<String, Object> objson = new Map<String, Object>();
        list<String> dataFinalForComponent = new list<String>();
        list <String> Answerx = new list<String>();
        List<String> datosOp = new List<String>();

        for(String st : idOp.split('_')){         
            datosOp.add(st);
        }
        String empresa = datosOp[0];
        String Op = datosOp[3];

        String endPoint = Endpoint__mdt.getInstance('CitaEntrega').URL__c;
        String url= endPoint + empresa +'/delivery-date'; 
        String method = 'POST';
       
        String body = '';

        
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
                            List<Opportunity> identificacion= [Select Id,Identificaci_n_del_cliente__c from 
                                                                Opportunity where IdOP__c = :idOp];
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
                                url = endPoint + empresa + '/validacionCitaEntrega?n_ide=' + n_ide + '&rem=' + Op + 
                                                '&c_agr=' + agencia + '&per=' + periodo;
                                HttpResponse response = JamarConsumoHTTP.callServiceExternal(url, null, 'GET',null);
                                Integer codigo = response.getStatusCode();
                                Answerx.add(response.getBody());
                                String data = Answerx[0];
                                CitaOp jsonParseds = (CitaOp) System.JSON.deserialize(data, CitaOp.class);
                                if(codigo ==200){
                                    if(jsonParseds.data[0].CITA_ENTREGA !='' || jsonParseds.data[0].CITA_ENTREGA != null){
                                        String aplicaArmado = aplicaArmadoOp(idOp);
                                        list<Case> casosAbiertos = [SELECT Id,Status FROM Case 
                                                    WHERE Oportunidad__c =:identificacion[0].Id];
                                        if(aplicaArmado == 'NO ARMABLE'){
                                            updateTask = ActivityClass.ActualizarTarea(Op, 'Completed', usuario,
                                                                'Asignacion de Cita de Entrega y Armado de OP');
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

    public static CitaOp calendarioEntregasParciales(String idOp){

        List<String> datosOp = new List<String>();
        List <String> Answerx = new list<String>();
        CitaOp entregasParciales = new CitaOp();
        List<String> fechas = new list<String>();
        List<String> codigosVendedor = new list<String>();
        String data;
        String codigos =  System.label.Codigos_vendedor;
        System.debug('Codigos 401: ' + codigos);
        String stage = System.label.STAGE;
        System.debug('Codigos 403: ' + stage);
        for(String cod : codigos.split(';')){
            codigosVendedor.add(cod);
        }
        System.debug('Codigos 406: ' + idOp);
        Opportunity op = [SELECT CodigoVendedor__c FROM Opportunity WHERE IdOP__c =: idOp];
        System.debug('Codigos 408: ' + op);
        if(op != null){
            if(codigosVendedor.contains(op.CodigoVendedor__c)){
                for(String st : idOp.split('_')){         
                    datosOp.add(st);
                }
                String empresa = datosOp[0];
                String numOp = datosOp[3];
                
                Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                            and Stage__c =:stage];
                String url = endpoint.URL__c + empresa + '/entregas/' + numOp;
                System.debug('Codigos 421: ' + url);
                try{
                    HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(url, null, 'GET');
                    Answerx.add(response.getBody());
                    data = Answerx[0];
                    Integer codigo = response.getStatusCode();
                    if(codigo == 200){
                        List<List<JamarInterfaceEntregasParciales>> calendarioEntregaParcial = new List<List<JamarInterfaceEntregasParciales>>();
                        calendarioEntregaParcial = JamarInterfaceEntregasParciales.parse(data);
                        System.debug('Codigos 430: ' + calendarioEntregaParcial.size());
                        if(calendarioEntregaParcial.size()> 1){             
                                entregasParciales.entregaParcial = calendarioEntregaParcial;
                                entregasParciales.mensaje ='APLICA';                          
                                return entregasParciales;
                        }else if(calendarioEntregaParcial.size() == 1){
                                fechas = calendarioCitaEntrega(idOp, 'OP');
                                entregasParciales.mensaje ='NO APLICA'; 
                                entregasParciales.fechas = fechas;
                                return entregasParciales;
                        }else{
                                UtilitiesClass.crearLog('Consumo en ws', empresa, 'Calendario_entregas_parciales',data, url);
                                entregasParciales.mensaje ='FALLO ENTREGAS PARCIALES';                          
                                return entregasParciales;
                        }
                    }else{
                            UtilitiesClass.crearLog('Consumo en ws', empresa, 'Calendario_entregas_parciales',data, url);
                            entregasParciales.mensaje ='FALLO ENTREGAS PARCIALES';                          
                            return entregasParciales;
                    }
                }catch(Exception e){
                    UtilitiesClass.crearLog('Consumo en ws', empresa, 'Calendario_entregas_parciales',e.getMessage() , data);
                    entregasParciales.mensaje='FALLO ENTREGAS PARCIALES';
                    return entregasParciales;
                }
            }else{
                fechas = calendarioCitaEntrega(idOp, 'OP');
                entregasParciales.mensaje ='NO APLICA';
                entregasParciales.fechas = fechas;
                return entregasParciales;
            }
        }else{
                entregasParciales.mensaje='NO SE PUDO ENCONTRAR CODIGO DEL VENDEDOR';
                fechas = calendarioCitaEntrega(idOp, 'OP');
                entregasParciales.fechas = fechas;
                return entregasParciales;
        }
    }
       
    public static String asignacionCitaEntregaParcial(String idOp, List<String> grupos){
                                    String body;
                                    String data;
                                    String url;
                                    List<String> datosOp = new List<String>();
                                    List <String> Answerx = new list<String>();
                                    Map<String, Object> objson = new Map<String, Object>();
                                    Info_rem inforem = new Info_rem();
                                    String stage= System.label.STAGE;
                                    

                                    for(String st : idOp.split('_')){         
                                        datosOp.add(st);
                                    }
                                    String empresa = datosOp[0];
                                    String agencia = datosOp[1];
                                    String periodo = datosOp[2];
                                    String Op = datosOp[3];

                                    inforem.numop= Op;
                                    inforem.tienda=agencia;
                                    inforem.per=periodo;

                                    objson.put('info_rem',inforem);
                                    objson.put('grupos',grupos);

                                    body = String.valueOf(JSON.Serialize(objson));
                                    System.debug(body);
                                    
                                    try{
                                        Endpoint__mdt endpoint = [SELECT URL__c  FROM Endpoint__mdt WHERE DeveloperName like '%Entregas_Parciales%' 
                                        and Stage__c =:stage];
                                        url = endpoint.URL__c + empresa + '/guardarreparto';
                                        HttpResponse response = JamarConsumoHTTP.callServiceExternalBasic(url, body, 'POST');
                                        Answerx.add(response.getBody());
                                        data = Answerx[0];
                                        Integer codigo = response.getStatusCode();
                                        if(codigo==200){
                                            Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
                                            Boolean success = Boolean.valueOf(jsonParsed.get('status'));
                                            String mensaje= String.valueOf(jsonParsed.get('message'));
                                            if(success == true){
                                                return mensaje;
                                            }else{
                                                return data;
                                            }
                                            
                                        }else{
                                            UtilitiesClass.crearLog('Consumo en ws', empresa, 'Asignacion_entregas_parciales',data, url);
                                            return 'ERROR EN EL CONSUMO DEL SERVICIO';
                                        }
                                    }catch(Exception e){
                                        UtilitiesClass.crearLog('Consumo en ws', empresa, 'Asignacion_entregas_parciales',e.getMessage() , data);
                                        return e.getMessage();
                                    }
    }
    
}