@isTest
public class JamarDocParaRecogerDeudaTest {
            @invocablevariable(Label='Empresa' required=true)
                public string empresas;
            @invocablevariable(Label='Identificacion' required=true)
                public string identificacion;
            @invocablevariable(Label='agencia' required=true)
                public string agencia;
            @invocablevariable(Label='tipoCredito' required=true)
                public string tipoCredito;
            @invocablevariable(Label='cuenta' required=true)
                public string cuenta;  
            @invocablevariable(Label='factura')
                public string factura;
       
        public JamarDocParaRecogerDeudaTest(){
                this.identificacion = '1129567580';
                this.agencia = '01';
                this.tipoCredito = 'TJ';
                this.empresas = 'JA';
                this.cuenta = '53467';
               this.factura = '53467';
            }
      @isTest static void TestCertParaRecogerDeuda(){
                JamarDocParaRecogerDeudaTest test = new JamarDocParaRecogerDeudaTest();
                JamarDocParaRecogerDeuda testParaRecogerDeuda = new JamarDocParaRecogerDeuda();
                JamarDocParaRecogerDeuda testRecogerDeuda = new JamarDocParaRecogerDeuda(test.identificacion, test.agencia, test.tipoCredito, test.empresas, test.cuenta, test.factura);
                list<JamarDocParaRecogerDeuda> certParaRecogerDeuda = new list<JamarDocParaRecogerDeuda>();
                certParaRecogerDeuda.add(testRecogerDeuda);
                JamarDocParaRecogerDeuda.GeneracionCertificadoParaRecogerDeuda(certParaRecogerDeuda);
                //JamarDocParaRecogerDeuda.extraerUrl('JA', '1043434561', '01', 'TJ', '54678','123456');
             }   
}