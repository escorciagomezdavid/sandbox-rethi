/**
@AUTOR: Luis Espinoza(FCC)
@FECHA: 13ENE2020
@PROPOSITO: Manejador para TriggerCartera.
*/
public class TriggerHandlerCartera extends TriggerHandler {
    
    //Listas de carteras
    private list<Cartera__c> newCarterasList;    
    
    //Mapa de carteras de tipo id, Cartera
    private Map<Id, Cartera__c> newCarterasMap;
    private Map<Id, Cartera__c> oldCarterasMap;    

    public TriggerHandlerCartera(){
        
        //Cargamos la lista de carteras con lo que viene en el contexto de trigger.new
        newCarterasList		=	(list<Cartera__c>) Trigger.New;
        
        //Cargamos el mapa de carteras con lo que viene en el contexto de trigger.newmap
        newCarterasMap 		=	(Map<Id, Cartera__c>) Trigger.NewMap;        
        
        //Cargamos el mapa de carteras con lo que viene en el contexto de trigger.oldmap
        oldCarterasMap 		=	(Map<Id, Cartera__c>) Trigger.OldMap;  
        
        //Precargamos la lista de tipos de registro
        //Util.getRecordTypes();
        
    }
    
    //public override void beforeInsert(){}
    
    public override void afterInsert(){
		//Lista de los registros de Carteras que se van a mandar a actualizar a SEUS
		Set<Id>CarterasToApiUpsert=new Set<Id>();
		//Lista de los registros de Carteras que se estan actualizando desde SEUS
		list<Cartera__c>CarterasFromApiUpsert=new list<Cartera__c>();	
		set<Id>IdCarteras = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Cartera__c.fields.getMap();
		
		//para cada registro de Carteras que fué creado
		for(Cartera__c a : newCarterasList){
			system.debug('Cartera: Carteras creado');
			//Creado , pero no desde SEUS 
			if(!a.APIUpsert__c){
				system.debug('Cartera: Carteras creado desde Services');
				CarterasToApiUpsert.add(a.Id);
			}
			
			//Creado desde SEUS
			if(a.APIUpsert__c){
				system.debug('Cartera: Carteras creado desde SEUS');
				IdCarteras.add(a.Id);
			}
		}
		//si hay carteras que cambiaron desde SEUS
		if(IdCarteras.size()>0){
			system.debug('Cartera: Hay carteras que cambiaron desde SEUS..');
			CarterasFromApiUpsert = [Select Id , APIUpsert__c from Cartera__c where ID IN : IdCarteras];
			for(Cartera__c a : CarterasFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('Cartera: Carteras '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerCartera);
			//Que se actualicen
			update CarterasFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerCartera);			
		}
		
		//si hay carteras que tuvieron cambio y se deben mandar a SEUS
		if(CarterasToApiUpsert.size()>0){
			system.debug('Cartera: Hay carteras que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			//CarterasToApiUpsert
		}		
	}
    
    //public override void beforeUpdate(){}
    
    public override void afterUpdate(){
		//Lista de los registros de Carteras que se van a mandar a actualizar a SEUS
		Set<Id>CarterasToApiUpsert=new Set<Id>();
		//Lista de los registros de Carteras que se estan actualizando desde SEUS
		list<Cartera__c>CarterasFromApiUpsert=new list<Cartera__c>();	
		set<Id>IdCarteras = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Cartera__c.fields.getMap();
		
		//para cada registro de Carteras que fué actualizado
		for(Cartera__c a : newCarterasList){
			//validar si ha habido un cambio en los campos...
			boolean cambioCarteras = false;
            for (String str : mapFields.keyset()){
				if(str!='lastmodifieddate' && str!='systemmodstamp' && a.get(str) != oldCarterasMap.get(a.Id).get(str)){
					cambioCarteras=true;
					System.Debug('Cartera: Hubo un cambio en el campo: ' + str + '. El valor cambió desde : ' + oldCarterasMap.get(a.Id).get(str) + ' a: ' + a.get(str)); 
				}
            }
			//si hubo algún cambio en los campos 
			if(cambioCarteras){
				system.debug('Cartera: Hubo cambio');
				//Hubo un cambio , pero no desde SEUS 
				if(!a.APIUpsert__c){
					system.debug('Cartera: hubo cambio interno');
					CarterasToApiUpsert.add(a.Id);
				}
				
				//si la Carteras se actualizó desde SEUS
				if(a.APIUpsert__c){
					system.debug('Cartera: hubo cambio desde SEUS');
					IdCarteras.add(a.Id);
				}				
			}else{
				system.debug('Cartera: No hubo cambios');		
			}
		}
		//si hay carteras que cambiaron desde SEUS
		if(IdCarteras.size()>0){
			system.debug('Cartera: Hay carteras que cambiaron desde SEUS..');
			CarterasFromApiUpsert = [Select Id , APIUpsert__c from Cartera__c where ID IN : IdCarteras];
			for(Cartera__c a : CarterasFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('Cartera: Carteras '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerCartera);
			//Que se actualicen
			update CarterasFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerCartera);			
		}
		
		//si hay carteras que tuvieron cambio y se deben mandar a SEUS
		if(CarterasToApiUpsert.size()>0){
			system.debug('Cartera: Hay carteras que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			MJAsyncServicesCall.updateSEUSCartera(CarterasToApiUpsert);
		}
    }
    
}