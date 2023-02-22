@isTest
public class JamarDocCertAlDiaTest {
    
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
        
        public JamarDocCertAlDiaTest(){
            this.empresa = 'JA';
            this.identificacion = '123456';
            this.cuenta = '111111111111';
            this.agencia = '01';
            this.tipoCredito = 'TJ';
        }
    
       @isTest static void TestCertAlDia(){
        JamarDocCertAlDiaTest test = new JamarDocCertAlDiaTest();
        JamarDocCertAlDia testAlDia = new JamarDocCertAlDia(test.empresa,test.identificacion, 
                                                            test.cuenta, test.agencia, test.tipoCredito);
        list<JamarDocCertAlDia> lista = new list<JamarDocCertAlDia>();
        lista.add(testAlDia);
       	JamarDocCertAlDia.GeneracionCertAlDia(lista);
       }
       
     
     
    

}