/**
@AUTOR: Luis Espinoza(FCC)
@FECHA: 09ENE2020
@PROPOSITO: Manejador para TriggerAccount.
*/
public class TriggerHandlerAccount extends TriggerHandler {
    
    //Listas de cuentas
    private list<Account> newAccountsList;    
    
    //Mapa de cuentas de tipo id, account
    private Map<Id, Account> newAccountsMap;
    private Map<Id, Account> oldAccountsMap;    

    public TriggerHandlerAccount(){
        
        //Cargamos la lista de cuentas con lo que viene en el contexto de trigger.new
        newAccountsList		=	(list<Account>) Trigger.New;
        
        //Cargamos el mapa de cuentas con lo que viene en el contexto de trigger.newmap
        newAccountsMap 		=	(Map<Id, Account>) Trigger.NewMap;        
        
        //Cargamos el mapa de cuentas con lo que viene en el contexto de trigger.oldmap
        oldAccountsMap 		=	(Map<Id, Account>) Trigger.OldMap;  
        
        //Precargamos la lista de tipos de registro
        //Util.getRecordTypes();
        
    }
    
    //public override void beforeInsert(){}
    
    public override void afterInsert(){
		//Lista de los registros de cuenta que se van a mandar a actualizar a SEUS
		Set<Id>AccountsToApiUpsert=new Set<Id>();
		//Lista de los registros de cuenta que se estan actualizando desde SEUS
		list<Account>AccountsFromApiUpsert=new list<Account>();	
		set<Id>IdAccounts = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Account.fields.getMap();
		
		//para cada registro de cuenta que fué creado
		for(Account a : newAccountsList){
			system.debug('ACCOUNT: Cliente creado');
			//Creado , pero no desde SEUS 
			if(!a.APIUpsert__c){
				system.debug('ACCOUNT: Cliente creado desde Services');
				//Por el momento no aplica a creacion de Clientes desde SERVICES a SEUS
				//AccountsToApiUpsert.add(a.Id);
			}
			
			//Creado desde SEUS
			if(a.APIUpsert__c){
				system.debug('ACCOUNT: Cliente creado desde SEUS');
				IdAccounts.add(a.Id);
			}
		}
		//si hay cuentas que cambiaron desde SEUS
		if(IdAccounts.size()>0){
			system.debug('ACCOUNT: Hay cuentas que cambiaron desde SEUS..');
			AccountsFromApiUpsert = [Select Id , APIUpsert__c from Account where ID IN : IdAccounts];
			for(Account a : AccountsFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('ACCOUNT: Cuenta '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
			//Que se actualicen
			update AccountsFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerAccount);			
		}
		
		//si hay cuentas que tuvieron cambio y se deben mandar a SEUS
		if(AccountsToApiUpsert.size()>0){
			system.debug('ACCOUNT: Hay cuentas que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			//AccountsToApiUpsert
		}		
	}
    
    //public override void beforeUpdate(){}
    
    public override void afterUpdate(){
		//Lista de los registros de cuenta que se van a mandar a actualizar a SEUS
		Set<Id>AccountsToApiUpsert=new Set<Id>();
		//Lista de los registros de cuenta que se estan actualizando desde SEUS
		list<Account>AccountsFromApiUpsert=new list<Account>();	
		set<Id>IdAccounts = new set<Id>();
		//mapa de campos del objeto
		Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Account.fields.getMap();
		
		//para cada registro de cuenta que fué actualizado
		for(Account a : newAccountsList){
			//validar si ha habido un cambio en los campos...
			boolean cambioCuenta = false;
            for (String str : mapFields.keyset()){
				if(str!='SEUSWSUpdateErrorMessage__c' && str!='SEUSWSSuccess__c' && str!='APIUpsert__c' && str!='lastmodifieddate' && str!='systemmodstamp' && a.get(str) != oldAccountsMap.get(a.Id).get(str)){
					cambioCuenta=true;
					System.Debug('ACCOUNT: Hubo un cambio en el campo: ' + str + '. El valor cambió desde : ' + oldAccountsMap.get(a.Id).get(str) + ' a: ' + a.get(str)); 
				}
            }
			//si hubo algún cambio en los campos 
			if(cambioCuenta){
				system.debug('ACCOUNT: Hubo cambio');
				//Hubo un cambio , pero no desde SEUS 
				if(!a.APIUpsert__c){
					system.debug('ACCOUNT: hubo cambio interno');
					AccountsToApiUpsert.add(a.Id);
				}
				
				//si la cuenta se actualizó desde SEUS
				if(a.APIUpsert__c){
					system.debug('ACCOUNT: hubo cambio desde SEUS');
					IdAccounts.add(a.Id);
				}				
			}else{
				system.debug('ACCOUNT: No hubo cambios');		
			}
		}
		//si hay cuentas que cambiaron desde SEUS
		if(IdAccounts.size()>0){
			system.debug('ACCOUNT: Hay cuentas que cambiaron desde SEUS..');
			AccountsFromApiUpsert = [Select Id , APIUpsert__c from Account where ID IN : IdAccounts];
			for(Account a : AccountsFromApiUpsert){
				a.APIUpsert__c=false;
				system.debug('ACCOUNT: Cuenta '+a.Id+' ApiUpsert = '+a.ApiUpsert__c );
			}
			TriggerHandler.ByPass(LABEL.TriggerHandlerAccount);
			//Que se actualicen
			update AccountsFromApiUpsert;
			TriggerHandler.clearByPass(LABEL.TriggerHandlerAccount);			
		}
		
        /**
		//si hay cuentas que tuvieron cambio y se deben mandar a SEUS
		if(AccountsToApiUpsert.size()>0){
			system.debug('ACCOUNT: Hay cuentas que cambiaron a lo interno , mandar a SEUS..');
			//Llamar a clase de Consumo de WS y mandarle los registros al metodo
			MJAsyncServicesCall.updateSEUSAccount(AccountsToApiUpsert);
		}
		**/
    }
    
}