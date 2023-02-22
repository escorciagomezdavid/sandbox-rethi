/**
@AUTOR: Luis Espinoza(FCC)
@FECHA: 16ENE2020
@PROPOSITO: Manejador para TriggerCase.
*/
public class TriggerHandlerCase extends TriggerHandler {
    
    //Listas de casos
    private list<Case> newCasesList;    
    
    //Mapa de casos de tipo id, Case
    private Map<Id, Case> newCasesMap;
    private Map<Id, Case> oldCasesMap;    

    public TriggerHandlerCase(){
        
        //Cargamos la lista de casos con lo que viene en el contexto de trigger.new
        newCasesList		=	(list<Case>) Trigger.New;
        
        //Cargamos el mapa de casos con lo que viene en el contexto de trigger.newmap
        newCasesMap 		=	(Map<Id, Case>) Trigger.NewMap;        
        
        //Cargamos el mapa de casos con lo que viene en el contexto de trigger.oldmap
        oldCasesMap 		=	(Map<Id, Case>) Trigger.OldMap;  
        
        //Precargamos la lista de tipos de registro
        //Util.getRecordTypes();
        
    }
    
    //public override void beforeInsert(){}   
    
    public override void afterInsert(){
		//Lista de los registros de caso que se van a mandar a actualizar a SEUS
		Set<Id>CompromisosPagoIdSet=new Set<Id>();
		//list<Case>ListCasesToApiUpsert=new list<Case>();	
		set<Id>IdCases = new set<Id>();
		List<String>IdRecordTypes = new list<String>();
		Map<Id , RecordType>MapRegistros = new Map<Id ,RecordType>();
		
		for(Case c : newCasesList){
			if(c.RecordTypeId!=null){
				IdRecordTypes.add(c.RecordTypeId);
			}
		}
		
		//consultar los tipos de registros
		if(IdRecordTypes.size()>0){
			list<RecordType>registros=[Select Id , Name , DeveloperName from RecordType where id IN : IdRecordTypes];
			if(registros.size()>0){
				for(RecordType r : registros){
					MapRegistros.put(r.Id , r);
				}
			}
		}
		
		//para cada registro de caso que fué actualizado
		for(Case c : newCasesList){
			
			RecordType TipoRegistro = MapRegistros.get(c.RecordTypeId);
			system.debug('CASE: El tipo de registro es :'+TipoRegistro.DeveloperName);
			//si se marca la bandera para enviar los datos del caso a SEUS
			if(c.APIUpsert__c || TipoRegistro.DeveloperName==LABEL.CaseRecordTypeNegociacion){
				system.debug('CASE: se marca la bandera de integracion');							
				IdCases.add(c.Id);
				//si es un caso de negociacion...
				if(TipoRegistro.DeveloperName==LABEL.CaseRecordTypeNegociacion){
					CompromisosPagoIdSet.add(c.Id);
					system.debug('CASE: Es un caso de negociacion...');
				}
			}else{
				system.debug('CASE: No se marca la bandera de integracion');		
			}
		}
		//si hay casos que se les marcó la bandera de integracion...
		if(IdCases.size()>0){
			system.debug('CASE: Hay casos con Bandera marcada..');
			list<Case>CasesFromApiUpsert = [Select Id , APIUpsert__c from Case where ID IN : IdCases];
			for(Case a : CasesFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('CASE: caso '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerCase);
			//Que se actualicen
			update CasesFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerCase);			
		
			//si hay casos que se deben mandar a SEUS
			if(CompromisosPagoIdSet.size()>0){
				system.debug('CASE: Hay casos de negociacion que mandar a SEUS..');
				//Llamar a clase de Consumo de WS y mandarle los registros al metodo
				MJAsyncServicesCall.createSEUSCompromisoPago(CompromisosPagoIdSet);
			}
		
		}		
    }
	//public override void beforeUpdate(){}	
	
    //public override void afterUpdate(){}
            
}