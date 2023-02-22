@IsTest
public class JamarAsignarArmadoTest {
    
        	@invocablevariable(Label='Empresa' required=true)
                public string empresa;
   		    @invocablevariable(Label='CodigoPais' required=true)
                public string codigoPais;	
     		@invocablevariable(Label='fechaCita' required=true)
                public string citaArmado;
    		@invocablevariable(Label='numOp' required=true)
                public string numeroOp;
    		@invocablevariable(Label='agencia' required=true)
                public string agencia;
            @invocablevariable(Label='tecnico' required=true)
                public string tecnico;                        
    		@invocablevariable(Label='codigo Recurso' required=true)
                public string codRecurso;
           @invocablevariable(Label='Jornada' required=true)
                public string jornada;

    public class responseTest{
                @invocableVariable(Label='Confirmacion Cita' required=true)
                public String confirmacion; 
                @invocableVariable(Label='cita Armado' required=true)
                public Date citaArmado;  
        }
        
        public JamarAsignarArmadoTest(){
            this.empresa = 'JA';
            this.codigoPais = '01';
            this.citaArmado='Lunes,04-Noviembre-2021';
            this.numeroOp = '2561402';            
            this.agencia = '95';
            this.tecnico = '007711';
            this.codRecurso = '03';
            this.Jornada = 'J1';
        }
    @IsTest static void TestCitaArmado(){
        JamarAsignarArmadoTest test = new JamarAsignarArmadoTest();  
        String fechaCita = '2021-03-16';
        String fecha_format_SV ='20210316';
        String fecha_format_SF = '2021-03-16';
        Date   asignacionArmado = date.valueOf(fecha_format_SF);
        JamarCitaArmado requestTest = new JamarCitaArmado(test.empresa,test.codigoPais,test.citaArmado, test.numeroOp,test.agencia,
                                                          test.tecnico,test.codRecurso,test.jornada);        
        List<JamarCitaArmado> listRequest = new List<JamarCitaArmado>();
        listRequest.add(requestTest);
        JamarCitaArmado.CitaArmado(listRequest);
        

    }
}