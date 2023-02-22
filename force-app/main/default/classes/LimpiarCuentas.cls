global class LimpiarCuentas implements Database.Batchable<sObject>, Schedulable, Database.Stateful {

    //Variable Section
    global FINAL String query;
  	global Integer contador = 0;
    global List<String> errorMessages = new List<String>();
    
    global LimpiarCuentas(){
    }

    //Se consultan los Closing con fecha de proxima alerta el dia de hoy
    global Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator([SELECT ID , IDCliente__c , Actualizado__c FROM ACCOUNT WHERE Actualizado__c=:false]);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scopeList) {
    /* 
  //Programar esta tarea
  LimpiarLogBatch  m = new LimpiarLogBatch ();
  String sch = '0 0 00 * * ?';
  String jobID = system.schedule('Eliminacion de registros de Log', sch, m);
  */    
        List<Account> Records = (List<Account>) scopeList;
    
        for(Account a: Records){
            if(a.IdCliente__c!=null){
            if(!a.IdCliente__c.contains('_')){
                system.debug('Cuenta Necesita cambio '+a.IdCliente__c);
                if(a.IdCliente__c.length()>=2){
                    String Identificador = a.IdCliente__c.substring(2);	
                    a.IdCliente__c = 'JA_'+Identificador;		
            	}
                System.debug('Identificador :'+a.IdCliente__c);
            }else{
                system.debug('Cuenta No necesita cambio '+a.IdCliente__c);
            }
            //marco el flag para que no se vueva a evaluar
            a.Actualizado__c = true;
            }
        }
        triggerHandler.byPass('TriggerHandlerAccount');
        update Records;        
		triggerHandler.ClearbyPass('TriggerHandlerAccount');
    }

    global void finish(Database.BatchableContext BC) {
    }
    
    //Method which schedules the ProductDownloadBatch
    global void execute(SchedulableContext sc) {
        LimpiarCuentas snInstance = new LimpiarCuentas();
        ID batchprocessid = Database.executeBatch(snInstance);
    }
}