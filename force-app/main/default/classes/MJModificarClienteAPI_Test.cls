/**
    TEST para clase MJModificarClienteAPI
    Autor: Jonathan Parrales
    18/FEB/2020
  Helped by TestDataFactory & SEUSWSActualizarCliente_Mock
**/
@isTest
public class MJModificarClienteAPI_Test {
  @testSetup static void setup(){
        //Crear Datos de prueba
        TestDataFactory.createAccountIndividual(10);
    }
    
    //Testea el metodo updateSEUSAccount, en este caso no se llama el Mock del WS para generar un error y entrar al catch del error
    static testMethod void test_updateSEUSAccountNoMock(){
        //TestDataFactory.createAccountIndividual(10);
        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }
        MJModificarClienteAPI.updateSEUSAccount(accountIdSet);
    }
    
    //Testea el metodo updateSEUSAccount, en este caso se llama el Mock del WS
    static testMethod void test_updateSEUSAccountConMock(){
        //TestDataFactory.createAccountIndividual(10);
        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }
        // Se setea el mock y se llama al método nuevamente para tener exito en la operación
        //Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarCliente_Mock());
        Test.setMock(HttpCalloutMock.class, new SEUSWSToken_Mock()); 
        TestDataFactory.createToken(); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SEUSWSActualizarCliente_Mock());
        MJModificarClienteAPI.updateSEUSAccount(accountIdSet);
        TEst.stopTest();
        
    }
	
    //Prueba el metodo validateAmount de Validaciones de Direccion de Colombia
    static testMethod void test_validateAmountColombia(){
        //TestDataFactory.createAccountIndividual(10);
        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }

        Test.startTest();
		
		//List<String>Direcciones = new list<String>();
		List<ValidacionesDeDireccion.VTvariable> direcciones = new List<ValidacionesDeDireccion.VTvariable>();
		ValidacionesDeDireccion.VTvariable VT = new ValidacionesDeDireccion.VTvariable();
		VT.Monto = 10;
		VT.Empresas=LABEL.EmpresaColombia;
		direcciones.add(VT);
		ValidacionesDeDireccion.validateAmount(direcciones);
		
		//validacion de monto minimo
		direcciones = new List<ValidacionesDeDireccion.VTvariable>();
		ValidacionesDeDireccion.VTvariable VT2 = new ValidacionesDeDireccion.VTvariable();
		VT2.Monto = 200000;
		VT2.Empresas=LABEL.EmpresaColombia;
		direcciones.add(VT2);
		ValidacionesDeDireccion.validateAmount(direcciones);
		
        TEst.stopTest();
        
    }	
	
    //Prueba el metodo validateAmount de Validaciones de Direccion de Panama
    static testMethod void test_validateAmountPanama(){
        //TestDataFactory.createAccountIndividual(10);
        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }

        Test.startTest();
		
		//List<String>Direcciones = new list<String>();
		List<ValidacionesDeDireccion.VTvariable> direcciones = new List<ValidacionesDeDireccion.VTvariable>();
		
		//con valor monto vacio
		ValidacionesDeDireccion.VTvariable VT1 = new ValidacionesDeDireccion.VTvariable();
		VT1.Empresas=LABEL.EmpresaPanama;
		direcciones.add(VT1);		
		ValidacionesDeDireccion.validateAmount(direcciones);
		//con valor empresa vacio
		direcciones = new List<ValidacionesDeDireccion.VTvariable>();
		ValidacionesDeDireccion.VTvariable VT2 = new ValidacionesDeDireccion.VTvariable();
		VT2.Monto = 1000000;
		direcciones.add(VT2);		
		ValidacionesDeDireccion.validateAmount(direcciones);		
		//con valores en monto y empresa
		direcciones = new List<ValidacionesDeDireccion.VTvariable>();
		ValidacionesDeDireccion.VTvariable VT = new ValidacionesDeDireccion.VTvariable();
		VT.Monto = 1000000;
		VT.Empresas=LABEL.EmpresaPanama;
		direcciones.add(VT);
		ValidacionesDeDireccion.validateAmount(direcciones);
        TEst.stopTest();
        
    }	

    //Prueba el metodo validatePhone de Validaciones de Telefono de Colombia
    static testMethod void test_validatePhoneColombia(){

        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }

        Test.startTest();
		
		List<ValidacionesdeTelefono.VTvariable> telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT = new ValidacionesdeTelefono.VTvariable();
		VT.Telefonos = '22332850';
		VT.Empresas=LABEL.EmpresaColombia;
		VT.TipoTelefono='Móvil';
		telefonos.add(VT);
		ValidacionesdeTelefono.validatePhone(telefonos);
		
		//validacion con Telefono vacio
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT2 = new ValidacionesdeTelefono.VTvariable();
		//VT.Telefonos = 10;
		VT2.Empresas=LABEL.EmpresaColombia;
		VT2.TipoTelefono='Móvil';
		telefonos.add(VT2);
		ValidacionesdeTelefono.validatePhone(telefonos);
		
		//validacion con Telefono caracteres especiales
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT3 = new ValidacionesdeTelefono.VTvariable();
		VT3.Telefonos = '31800patito';
		VT3.Empresas=LABEL.EmpresaColombia;
		VT3.TipoTelefono='Móvil';
		telefonos.add(VT3);
		ValidacionesdeTelefono.validatePhone(telefonos);		
		
		//validacion con Telefono correcto
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT4 = new ValidacionesdeTelefono.VTvariable();
		VT4.Telefonos = '3124567895';
		VT4.Empresas=LABEL.EmpresaColombia;
		VT4.TipoTelefono='Móvil';
		telefonos.add(VT4);
		ValidacionesdeTelefono.validatePhone(telefonos);	
		
		//validacion con Telefono correcto FIJO
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT5 = new ValidacionesdeTelefono.VTvariable();
		VT5.Telefonos = '3124567895';
		VT5.Empresas=LABEL.EmpresaColombia;
		VT5.TipoTelefono='Fijo';
		telefonos.add(VT5);
		ValidacionesdeTelefono.validatePhone(telefonos);			

		
        TEst.stopTest();		
        
    }	
	
    //Prueba el metodo validatePhone de Validaciones de Telefono de Panama
    static testMethod void test_validatePhonePanama(){

        set<Id> accountIdSet = new set<Id>();
        for (Account a: [Select Id from Account limit 10]){
            accountIdSet.add(a.Id);
        }

        Test.startTest();
		
		List<ValidacionesdeTelefono.VTvariable> telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT = new ValidacionesdeTelefono.VTvariable();
		VT.Telefonos = '22332850';
		VT.Empresas=LABEL.EmpresaPanama;
		VT.TipoTelefono='Móvil';
		telefonos.add(VT);
		ValidacionesdeTelefono.validatePhone(telefonos);
		
		//validacion con Telefono vacio
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT2 = new ValidacionesdeTelefono.VTvariable();
		//VT.Telefonos = 10;
		VT2.Empresas=LABEL.EmpresaPanama;
		VT2.TipoTelefono='Móvil';
		telefonos.add(VT2);
		ValidacionesdeTelefono.validatePhone(telefonos);
		
		//validacion con Telefono caracteres especiales
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT3 = new ValidacionesdeTelefono.VTvariable();
		VT3.Telefonos = '31800patito';
		VT3.Empresas=LABEL.EmpresaPanama;
		VT3.TipoTelefono='Móvil';
		telefonos.add(VT3);
		ValidacionesdeTelefono.validatePhone(telefonos);		
		
		//validacion con Telefono correcto
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT4 = new ValidacionesdeTelefono.VTvariable();
		VT4.Telefonos = '3124567895';
		VT4.Empresas=LABEL.EmpresaPanama;
		VT4.TipoTelefono='Móvil';
		telefonos.add(VT4);
		ValidacionesdeTelefono.validatePhone(telefonos);	
		
		//validacion con Telefono correcto FIJO
		telefonos = new List<ValidacionesdeTelefono.VTvariable>();
		ValidacionesdeTelefono.VTvariable VT5 = new ValidacionesdeTelefono.VTvariable();
		VT5.Telefonos = '3124567895';
		VT5.Empresas=LABEL.EmpresaPanama;
		VT5.TipoTelefono='Fijo';
		telefonos.add(VT5);
		ValidacionesdeTelefono.validatePhone(telefonos);			

		
        TEst.stopTest();		
        
    }		
		
}