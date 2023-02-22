/**
@AUTOR: Luis Espinoza(FCC)
@FECHA: 15ENE2020
@PROPOSITO: Manejador para TriggerCobrosDomicilio.
*/
public class TriggerHandlerCobrosDomicilio extends TriggerHandler {
    
    //Listas de CobrosDomicilios
    private list<Cobro_a_domicilio__c> newCobrosDomicilioList;    
    
    //Mapa de CobrosDomicilio de tipo id, CobrosDomicilio
    private Map<Id, Cobro_a_domicilio__c> newCobrosDomicilioMap;
    private Map<Id, Cobro_a_domicilio__c> oldCobrosDomicilioMap;    

    public TriggerHandlerCobrosDomicilio(){
        
        //Cargamos la lista de CobrosDomicilio con lo que viene en el contexto de trigger.new
        newCobrosDomicilioList		=	(list<Cobro_a_domicilio__c>) Trigger.New;
        
        //Cargamos el mapa de CobrosDomicilio con lo que viene en el contexto de trigger.newmap
        newCobrosDomicilioMap 		=	(Map<Id, Cobro_a_domicilio__c>) Trigger.NewMap;        
        
        //Cargamos el mapa de CobrosDomicilio con lo que viene en el contexto de trigger.oldmap
        oldCobrosDomicilioMap 		=	(Map<Id, Cobro_a_domicilio__c>) Trigger.OldMap;  
        
        //Precargamos la lista de tipos de registro
        //Util.getRecordTypes();
        
    }
    
    public override void beforeInsert(){
		Map<Id , Cartera__c>MapCarteras = new Map<Id , Cartera__c>();
		List<Id>IdCarteras = new List<Id>();
		//capturar los Id de Cartera para el query
		for(Cobro_a_domicilio__c a : newCobrosDomicilioList){
			if(a.Numero_cartera__c!=null){
				IdCarteras.add(a.Numero_cartera__c);
			}
		}
		
		//consultar las carteras
		if(IdCarteras.size()>0){
			list<Cartera__c>Carteras=[Select AccountId__r.Empresa__c, Agencia__r.Codigo_de_agencia__c, Tipo_de_cuenta__c , Name , AccountId__r.Identificacion__c  from Cartera__c where Id IN : IdCarteras];
			if(Carteras.size()>0){
				for(Cartera__c c:Carteras){
					MapCarteras.put(c.Id , c);
				}
			}
		}
		//establecer el IdVisitaCobro
		for(Cobro_a_domicilio__c a : newCobrosDomicilioList){
			if(a.Numero_cartera__c!=null){
				if(MapCarteras.containsKey(a.Numero_cartera__c)){
					Cartera__c c = MapCarteras.get(a.Numero_cartera__c);
					a.IdVisitaCobro__c = c.AccountId__r.Empresa__c+'_'+c.Agencia__r.Codigo_de_agencia__c+'_'+c.Tipo_de_cuenta__c+'_'+c.Name+'_'+c.AccountId__r.Identificacion__c+'_'+String.valueof(a.Dia__c);
				}				
			}
		}
	}
    
    public override void afterInsert(){
		//Lista de los registros de CobrosDomicilio que se van a mandar a actualizar a SEUS
		Set<Id>CobrosDomicilioToApiUpsert=new Set<Id>();
		//Lista de los registros de CobrosDomicilio que se estan actualizando desde SEUS
		list<Cobro_a_domicilio__c>CobrosDomicilioFromApiUpsert=new list<Cobro_a_domicilio__c>();	
		set<Id>IdCobrosDomicilio = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Cobro_a_domicilio__c.fields.getMap();
		
		//para cada registro de CobrosDomicilio que fué creado
		for(Cobro_a_domicilio__c a : newCobrosDomicilioList){
			system.debug('CobrosDomicilio: CobrosDomicilio creado');
			//Creado , pero no desde SEUS 
			if(!a.APIUpsert__c){
				system.debug('CobrosDomicilio: CobrosDomicilio creado desde Services');
				CobrosDomicilioToApiUpsert.add(a.Id);
			}
			
			//Creado desde SEUS
			if(a.APIUpsert__c){
				system.debug('CobrosDomicilio: CobrosDomicilio creado desde SEUS');
				IdCobrosDomicilio.add(a.Id);
			}
		}
		//si hay CobrosDomicilio que cambiaron desde SEUS
		if(IdCobrosDomicilio.size()>0){
			system.debug('CobrosDomicilio: Hay CobrosDomicilio que cambiaron desde SEUS..');
			CobrosDomicilioFromApiUpsert = [Select Id , APIUpsert__c from Cobro_a_domicilio__c where ID IN : IdCobrosDomicilio];
			for(Cobro_a_domicilio__c a : CobrosDomicilioFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('CobrosDomicilio: CobrosDomicilio '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerCobrosDomicilio);
			//Que se actualicen
			update CobrosDomicilioFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerCobrosDomicilio);			
		}
		/**
		//si hay  CobrosDomicilio que tuvieron cambio y se deben mandar a SEUS
		if(CobrosDomicilioToApiUpsert.size()>0){
			system.debug('CobrosDomicilio: Hay CobrosDomicilio que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			MJAsyncServicesCall.createSEUSCobroDomicilio(CobrosDomicilioToApiUpsert);
		}
		**/
	}
    
    //public override void beforeUpdate(){}
    
    public override void afterUpdate(){
		//Lista de los registros de CobrosDomicilio que se van a mandar a actualizar a SEUS
		Set<Id>CobrosDomicilioToApiUpsert=new Set<Id>();
		//Lista de los registros de CobrosDomicilio que se estan actualizando desde SEUS
		list<Cobro_a_domicilio__c>CobrosDomicilioFromApiUpsert=new list<Cobro_a_domicilio__c>();	
		set<Id>IdCobrosDomicilio = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Cobro_a_domicilio__c.fields.getMap();
		
		//para cada registro de CobrosDomicilio que fué actualizado
		for(Cobro_a_domicilio__c a : newCobrosDomicilioList){
			//validar si ha habido un cambio en los campos...
			boolean cambioCobrosDomicilio = false;
            for (String str : mapFields.keyset()){
				if(str!='lastmodifieddate' && str!='systemmodstamp' && a.get(str) != oldCobrosDomicilioMap.get(a.Id).get(str)){
					cambioCobrosDomicilio=true;
					System.Debug('CobrosDomicilio: Hubo un cambio en el campo: ' + str + '. El valor cambió desde : ' + oldCobrosDomicilioMap.get(a.Id).get(str) + ' a: ' + a.get(str)); 
				}
            }
			//si hubo algún cambio en los campos 
			if(cambioCobrosDomicilio){
				system.debug('CobrosDomicilio: Hubo cambio');
				//Hubo un cambio , pero no desde SEUS 
				if(!a.APIUpsert__c && a.Status__c!=LABEL.EstatusCerrado){
					system.debug('CobrosDomicilio: hubo cambio interno');
					CobrosDomicilioToApiUpsert.add(a.Id);
				}
				
				//si la CobrosDomicilio se actualizó desde SEUS
				if(a.APIUpsert__c){
					system.debug('CobrosDomicilio: hubo cambio desde SEUS');
					IdCobrosDomicilio.add(a.Id);
				}				
			}else{
				system.debug('CobrosDomicilio: No hubo cambios');		
			}
		}
		//si hay CobrosDomicilio que cambiaron desde SEUS
		if(IdCobrosDomicilio.size()>0){
			system.debug('CobrosDomicilio: Hay CobrosDomicilio que cambiaron desde SEUS..');
			CobrosDomicilioFromApiUpsert = [Select Id , APIUpsert__c from Cobro_a_domicilio__c where ID IN : IdCobrosDomicilio];
			for(Cobro_a_domicilio__c a : CobrosDomicilioFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('CobrosDomicilio: CobrosDomicilio '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerCobrosDomicilio);
			//Que se actualicen
			update CobrosDomicilioFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerCobrosDomicilio);			
		}
	
  /**	
		//si hay CobrosDomicilio que tuvieron cambio y se deben mandar a SEUS
		if(CobrosDomicilioToApiUpsert.size()>0){
			system.debug('CobrosDomicilio: Hay CobrosDomicilio que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			MJAsyncServicesCall.createSEUSCobroDomicilio(CobrosDomicilioToApiUpsert);
		}
    }
	**/
    }
    
}