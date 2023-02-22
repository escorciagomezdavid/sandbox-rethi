/*
    Funciones y variables genericas
    Autor: Luis Espinoza
    02/oct/2019
*/
 
public with sharing class Util {       
    
    public static Map<string, RecordType> mapRecordType = new Map<string, RecordType>();
    
    public static Map<ID, RecordType> mapaRecords = new Map<ID, RecordType>
        ([select id,DeveloperName,Name,SObjectType from RecordType where isActive = true]);
    public static Map<ID, ListView> mapaListViews = new Map<ID, ListView>([select id,DeveloperName,Name,SobjectType from ListView]);
    
    public static Map<string, RecordType> getRecordTypes(){
        //Seleccionar tipos de registros.
        for (RecordType r: mapaRecords.values()) {
            if (!mapRecordType.containsKey(r.SObjectType+'-'+r.DeveloperName)) 
            {mapRecordType.put(r.SObjectType+'-'+r.DeveloperName,r);}           
        }
        
        return mapRecordType;
    }
    
    //Creamos mapa de listas de recordtypes por objeto
    public static map<string, map<id,RecordType>> getRecordTypesByObject(){
        
       map<string,map<id,RecordType>> mapaRecordTypesByObject = new map<string,map<id,RecordType>>();

       for (RecordType r: mapaRecords.values()) {
           if(!mapaRecordTypesByObject.containsKey(r.SObjectType))
                mapaRecordTypesByObject.put(r.SObjectType, new map<id,RecordType>());
           mapaRecordTypesByObject.get(r.SobjectType).put(r.id,r);
       }
        
       return mapaRecordTypesByObject;
        
    }
    
    //Limita el nombre completo de algunos objetos para que alcance en el campo standard Name
    public static string getSubstring(string text, integer startIndex, integer endIndex){
        if(text.length()>endIndex)
            text = text.substring(startIndex, endIndex);
        return text;
    }
    
    
    /*Convertir String a blob*/
    public static blob stringToBlob(string input){
        return Blob.valueOf(input);
    }
    
    public static string concatenateString(string text, integer len) {
        if (text!=null && text.length()>len) {
            text = text.substring(0,len);
        }
        return text;
    }
    public static datetime convertStringToDateTime(string input){
        Datetime dt;
        if(input!=null)
            dt = DateTime.Valueof(input.replace('T', ' ')); 
        return dt;
    }
	
	public static string convertDatetoString(Date input){
		String fecha='';
		if(input!=null){
			String dia = String.valueOf(input.day());
			String mes = String.valueOf(input.month());
			String anio = String.valueOf(input.year());
			fecha = mes+'-'+dia+'-'+anio;
		}
		return fecha;
	}
	
	public static void wait(Integer millisec) {

		if(millisec == null || millisec < 0) {
			millisec = 0;
		}

		Long startTime = DateTime.now().getTime();
		Long finishTime = DateTime.now().getTime();
		while ((finishTime - startTime) < millisec) {
		//sleep for parameter x millisecs
			finishTime = DateTime.now().getTime();
		}
		// System.debug('>>> Done from ' + startTime + ' to ' + finishTime);
	}	
	
    /*Obtener valores  de picklist*/
    public static list<String> getPicklistValues(String ObjectApi_name,String Field_name){
        system.debug('ObjectApi_name: ' +ObjectApi_name+' Field_name: ' + Field_name);
        list<String> lstPickvals=new list<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        list<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
          lstPickvals.add(a.getValue());//add the value  to our final list
          system.debug('***item: ' +a.getValue());
        }
        return lstPickvals;
    }
    public static map<id,ListView> getListViewsByObject(string objectName){
        map<id,ListView> mapListViews = new map<id,ListView>();
        for(ListView view :mapaListViews.Values()){
            //system.debug('**: ' + view.SobjectType);
            if(view.SobjectType!=null&&view.SobjectType.equalsIgnoreCase(objectName)){
                mapListViews.put(view.id, view);
            }            
        }
        return mapListViews;
    }
    
    public static boolean isWorkingDay(Datetime fecha) {
        String diaSemana = fecha.format('E').toLowerCase();
        return ('sat'.equals(diaSemana) || 'sun'.equals(diaSemana)) ? false:true;
    }
    
    //Codigos de Error para RESTful WS
    public final static integer statusCode200 = 200; //OK
    public final static integer statusCode400 = 400; //Error Bad Request
    public final static integer statusCode404 = 404; //Not Found
    public final static integer statusCode500 = 500; // Internal Error    
    public final static string instanceSFURL = URL.getSalesforceBaseUrl().toExternalForm(); 
       
}