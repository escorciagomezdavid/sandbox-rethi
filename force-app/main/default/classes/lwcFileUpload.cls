/*************************************************************************
Nombre de la Clase:     lwcFildeUpload
Versión :               1.0
Fecha de Creación :     24/10/2022
Funcionalidad :         Enviar archivos al S3 y setear en el caso las urls devueltas por el servicio.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez         24/10/2022       Versión Original
* 

*************************************************************************/
public without sharing class lwcFileUpload {
    public class relatedFile {
        public String base64;
	    public String Title;
    }


    @AuraEnabled
    public static String saveFile(Id idrecord, List<Map<String, Object>> files){
        
        System.debug(files);
        List<String> op = new List<String>();
        List<Case> caso = new List<Case>();
        List<String> base64 = new List<String>();
        WorkOrder orden = new WorkOrder();
        String urls;
        id idOportunidad;
        id idCaso;

        /**
         * Manipulacion del arreglo que me trae las imagenes en base64
         */
        for (Map<String, Object> file : files) {
            String fileJson = JSON.serialize(file);
            relatedFile relatedDocument = (relatedFile) JSON.deserialize(fileJson, relatedFile.class);
            base64.add(relatedDocument.base64);
        }
        
        /**
         * 
         */
        caso = [SELECT ID,Images__c, Oportunidad__c FROM Case WHERE Id =:idrecord];

        if(caso.isEmpty()){
            orden = [SELECT id,CaseId FROM WorkOrder WHERE id=:idrecord];
            if(orden != null){
                List<Case> caso2 = [SELECT  ID,Images__c, Oportunidad__c FROM Case WHERE Id =:orden.CaseId];
                idCaso = caso2[0].ID;
                idOportunidad = caso2[0].Oportunidad__c;
            }else{
                return 'Sin caso Asociado';
            }
        }else{
           idCaso = caso[0].ID;
           idOportunidad = caso[0].Oportunidad__c;
        }

        op = queryOportunidades(idOportunidad);
        if(op[0]!='Empty'){
            String periodo = op[2];
            String ordenPedido = op[3];
            String codProducto = op[4];
            urls=callServiceforUploadS3(base64,ordenPedido,codProducto,periodo);
            if(urls != 'ERROR SISTEMA' || urls != null || urls!='' ){
                Case caso3 = new Case();
                caso3= [SELECT ID,Images__c FROM Case WHERE Id =:idCaso];
                caso3.Images__c = caso3.Images__c+';'+urls;
                update caso3;
                return 'Success';
            }else{
                return 'Error al montar fotos';
            }
        }else{
            return 'No tiene Orden ni productos asociados al caso';
        }
    }
    
    @AuraEnabled
    public static String callServiceforUploadS3(List<String> base64Data, String numeroOp, 
            String codProducto, String periodo){

        String endPoint = Endpoint__mdt.getInstance('Upload_Fotos_S3').URL__c;
        String body = '';
		list<String> Answerx = new list<String> ();
        try{
            Map<String, Object> objson = new Map<String, Object> ();
            objson.put('imagen_b64', base64Data);
			objson.put('pe_vcNumOrd', numeroOp);
			objson.put('pe_vcCodProd', codProducto);
			objson.put('pe_vcPerOrd', periodo);
            body = String.valueOf(JSON.Serialize(objson));
            String metodo = 'POST';
            HttpResponse response = JamarConsumoHTTP.callServiceExternalWithTimeOut(endPoint, body, metodo,'25000');
            Answerx.add(response.getBody());
			String data = Answerx[0];
			Map<String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
            Integer codigo = response.getStatusCode();
            if(codigo == 200 || codigo ==201){
                String urls = String.ValueOf(jsonParsed.get('urls'));
                return urls;
            }else{
                Log__c log = new Log__c();
                log.ClassName__c = 'Carga_Fotos';
                log.date__c = Datetime.now();
                log.message__c = 'Error en consumo AWS: ';
                log.success__c = false;
                log.type__c = 'Consumo en ws';
                log.JSON__c = body;
                log.Empresa__c = 'Colombia';
                insert log;
                return 'ERROR SISTEMA';
            }
        }catch(Exception e){
            Log__c log = new Log__c();
			log.ClassName__c = 'Carga_Fotos';
			log.date__c = Datetime.now();
			log.message__c = 'Error en consumo AWS: ' + e.getMessage();
			log.success__c = false;
			log.type__c = 'Consumo en ws';
			log.JSON__c = body;
            log.Empresa__c = 'Colombia';
			insert log;
            return 'ERROR SISTEMA';
        }
    }

    @AuraEnabled
    public static List<String> queryOportunidades(id recordId){
        List<String> datosOp = new List<String>();
        List<Opportunity> op = [SELECT IdOP__c FROM Opportunity WHERE id=:recordId];    
        if(!op.isEmpty()){
            String IdOp=op[0].IdOP__c;
            List<OpportunityLineItem> productoOp =[SELECT ProductCode FROM OpportunityLineItem WHERE IdOP__c = :op[0].IdOP__c];
            for(String st : IdOp.split('_')){         
                datosOp.add(st);
            }
            String codProducto=productoOp[0].ProductCode;
            datosOp.add(codProducto);
        }else{
            datosOp.add('Empty');
        }
        return datosOp;
    }
}