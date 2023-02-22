/**
@AUTOR: Luis Espinoza(FCC)
@FECHA: 13ENE2020
@PROPOSITO: Manejador para TriggerContact.
*/
public class TriggerHandlerContact extends TriggerHandler {
    
    //Listas de contactos
    private list<Contact> newContactsList;    
    
    //Mapa de contactos de tipo id, Contact
    private Map<Id, Contact> newContactsMap;
    private Map<Id, Contact> oldContactsMap;    

    public TriggerHandlerContact(){
        
        //Cargamos la lista de contactos con lo que viene en el contexto de trigger.new
        newContactsList		=	(list<Contact>) Trigger.New;
        
        //Cargamos el mapa de contactos con lo que viene en el contexto de trigger.newmap
        newContactsMap 		=	(Map<Id, Contact>) Trigger.NewMap;        
        
        //Cargamos el mapa de contactos con lo que viene en el contexto de trigger.oldmap
        oldContactsMap 		=	(Map<Id, Contact>) Trigger.OldMap;  
        
        //Precargamos la lista de tipos de registro
        //Util.getRecordTypes();
        
    }
    
    //public override void beforeInsert(){}
    
    public override void afterInsert(){
		//Lista de los registros de contacto que se van a mandar a actualizar a SEUS
		Set<Id>ContactsToApiUpsert=new Set<Id>();
		//Lista de los registros de contacto que se estan actualizando desde SEUS
		list<Contact>ContactsFromApiUpsert=new list<Contact>();	
		set<Id>IdContacts = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Contact.fields.getMap();
		
		//para cada registro de contacto que fué creado
		for(Contact c : newContactsList){
			system.debug('Contact: Contacto creado');
			//Creado , pero no desde SEUS 
			if(!c.APIUpsert__c){
				system.debug('Contact: Contacto creado desde Services');
				ContactsToApiUpsert.add(c.Id);
			}
			
			//Creado desde SEUS
			if(c.APIUpsert__c){
				system.debug('Contact: Contacto creado desde SEUS');
				IdContacts.add(c.Id);
			}
		}
		//si hay contactos que cambiaron desde SEUS
		if(IdContacts.size()>0){
			system.debug('Contact: Hay contactos que cambiaron desde SEUS..');
			ContactsFromApiUpsert = [Select Id , APIUpsert__c from Contact where ID IN : IdContacts];
			for(Contact c : ContactsFromApiUpsert){
				c.APIUpsert__c=false;
				system.debug('Contact: contacto '+c.Id+' ApiUpsert = '+c.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerContact);
			//Que se actualicen
			update ContactsFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerContact);			
		}
		
		//si hay contactos que tuvieron cambio y se deben mandar a SEUS
		if(ContactsToApiUpsert.size()>0){
			system.debug('Contact: Hay contactos que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			//ContactsToApiUpsert
		}		
	}
    
    //public override void beforeUpdate(){}
    
    public override void afterUpdate(){
		//Lista de los registros de contacto que se van a mandar a actualizar a SEUS
		Set<Id>ContactsToApiUpsert=new Set<ID>();
		//Lista de los registros de contacto que se estan actualizando desde SEUS
		list<Contact>ContactsFromApiUpsert=new list<Contact>();	
		set<Id>IdContacts = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Contact.fields.getMap();
		
		//para cada registro de contacto que fué actualizado
		for(Contact c : newContactsList){
			//validar si ha habido un cambio en los campos...
			boolean cambiocontacto = false;
            for (String str : mapFields.keyset()){
				if(str!='SEUSWSUpdateErrorMessage__c' && str!='SEUSWSSuccess__c' && str!='APIUpsert__c' && str!='lastmodifieddate' && str!='systemmodstamp' && c.get(str) != oldContactsMap.get(c.Id).get(str)){
					cambiocontacto=true;
					System.Debug('Contact: Hubo un cambio en el campo: ' + str + '. El valor cambió desde : ' + oldContactsMap.get(c.Id).get(str) + ' a: ' + c.get(str)); 
				}
            }
			//si hubo algún cambio en los campos 
			if(cambiocontacto){
				system.debug('Contact: Hubo cambio');
				//Hubo un cambio , pero no desde SEUS 
				if(!c.APIUpsert__c){
					system.debug('Contact: hubo cambio interno');
					ContactsToApiUpsert.add(c.Id);
				}
				
				//si la contacto se actualizó desde SEUS
				if(c.APIUpsert__c){
					system.debug('Contact: hubo cambio desde SEUS');
					IdContacts.add(c.Id);
				}				
			}else{
				system.debug('Contact: No hubo cambios');		
			}
		}
		//si hay contactos que cambiaron desde SEUS
		if(IdContacts.size()>0){
			system.debug('Contact: Hay contactos que cambiaron desde SEUS..');
			ContactsFromApiUpsert = [Select Id , APIUpsert__c from Contact where ID IN : IdContacts];
			for(Contact c : ContactsFromApiUpsert){
				c.APIUpsert__c=false;
				system.debug('Contact: contacto '+c.Id+' ApiUpsert = '+c.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerContact);
			//Que se actualicen
			update ContactsFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerContact);			
		}
		
		//si hay contactos que tuvieron cambio y se deben mandar a SEUS
		if(ContactsToApiUpsert.size()>0){
			system.debug('Contact: Hay contactos que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			MJAsyncServicesCall.updateSEUSContact(ContactsToApiUpsert);
		}
    }
    
}