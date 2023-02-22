@isTest
public class JamarDocCertTributarioTest {
         @invocablevariable(Label='Identificacion' required=true)
        public string identificacion;
        @invocablevariable(Label='ano' required=true)
        public string ano;
        @invocablevariable(Label='Empresa' required=true)
        public string empresas;
        @invocablevariable(Label='agencia' required=true)
        public string agencia;
        @invocablevariable(Label='Cuenta' required=true)
        public string cuenta;
        @invocablevariable(Label='TipoCredito' required=true)
        public string TipoCredito;
    
        public JamarDocCertTributarioTest(){
            this.identificacion = '1129567580';
            this.ano = '2020';
            this.empresas = 'JA';
            this.agencia='A3';
            this.cuenta='13928';
            this.TipoCredito='TJ';
        }
    
        @isTest static void TestCertTributario(){
            JamarDocCertTributarioTest test = new JamarDocCertTributarioTest();
            JamarDocCertTributario testTributario = new JamarDocCertTributario(test.identificacion, test.ano,test.empresas, test.agencia,test.cuenta,test.TipoCredito);
            list<JamarDocCertTributario> certTributario = new list<JamarDocCertTributario>();
            certTributario.add(testTributario);
            JamarDocCertTributario.GeneracionCertificadoTributario(certTributario);
         }

}