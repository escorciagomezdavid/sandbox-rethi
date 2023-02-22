@isTest
public class JamarDocPazySalvoTest {   
    
        @invocablevariable(Label='Empresa' required=true)
        public string empresa;
        @invocablevariable(Label='Identificacion' required=true)
        public string identificacion;
        @invocablevariable(Label='cuenta' required=true)
        public string cuenta;  
        @invocablevariable(Label='agencia' required=true)
        public string agencia;
        @invocablevariable(Label='tipo_credito' required=true)
        public string tipoCredito;
 
    
    public JamarDocPazySalvoTest(){
        this.empresa = 'JA';
        this.identificacion = '123456';
        this.cuenta = '345678';
        this.agencia = '01';
        this.tipoCredito = 'TJ';        
    }
    
    @isTest static void TestPazySalvo(){
        JamarDocPazySalvoTest test = new JamarDocPazySalvoTest();
        JamarDocPazySalvo testPaz = new JamarDocPazySalvo(test.empresa,test.identificacion, test.cuenta, test.agencia, test.tipoCredito);
        list<JamarDocPazySalvo> lista = new list<JamarDocPazySalvo>();
        lista.add(testPaz);
       	JamarDocPazySalvo.GeneracionPazySalvo(lista);
    }
    
   

}