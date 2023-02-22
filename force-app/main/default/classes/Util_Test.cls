@isTest
public class Util_Test {
	
	static testMethod void testMJDireccionesController(){
		TestDataFactory.createGeneralData();
				
		MJDireccionesController c = new MJDireccionesController();
		
		Test.startTest();
		system.debug(c.Paises);
		system.debug(c.CuentaPersona);
		system.debug(c.IdPais);	
		
		RecordType tipoRegistro = CaseReloaded.getRecordTypeId('Seguros');
		
		Test.stopTest();
	}
	
	static testMethod void testLimpiarCuentas(){
		TestDataFactory.createGeneralData();
		TestDataFactory.createAccountIndividual(1);				
		
		Test.startTest();
		
		LimpiarCuentas  m = new LimpiarCuentas ();
		String sch = '0 0 17 * * ?';
		String jobID = system.schedule('test', sch, m);
		
		Id batchInstanceId = Database.executeBatch(new LimpiarCuentas(),1);		
		
		Test.stopTest();
	}	
	static testMethod void testUtils() {

		Test.startTest();
		system.debug('RT '+Util.getRecordTypes());
		system.debug('RT by Object '+Util.getRecordTypesByObject());
		system.debug('Substring de jamar '+Util.getSubstring('jamar' , 0 , 2));
		Blob archivo = Util.stringToBlob('jamar');
		system.debug('Cadena '+Util.concatenateString('jamar' , 2));
		
		string year = '2008';
		string month = '10';
		string day = '5';
		string hour = '12';
		string minute = '20';
		string second = '20';
		string stringDate = year + '-' + month + '-' + day + ' ' + hour + ':' 
			+ minute +  ':' + second;		
		Datetime Fecha = Util.convertStringToDateTime(stringDate);
		system.debug('LeadSource '+Util.getPicklistValues('LEAD' , 'LeadSource'));
		system.debug('ListView '+Util.getListViewsByObject('LEAD'));
		
		system.debug('Dia laboral '+Util.isWorkingDay(fecha));				
		system.debug('Fecha a cadena '+Util.convertDatetoString(system.today()));
		Util.wait(10);		
		Test.stopTest();
	}
	
}