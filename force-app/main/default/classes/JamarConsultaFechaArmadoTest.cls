@IsTest
public class JamarConsultaFechaArmadoTest {
                @invocablevariable(Label='Empresa' required=true)
                        public string empresa;
                @invocablevariable(Label='country' required=true)
                            public string country;
                @invocablevariable(Label='Op' required=true)
                            public string numeroOp;
                @invocablevariable(Label='periodoOp' required=true)
                            public string periodoOp;
                @invocablevariable(Label='agencia' required=true)
                            public string agencia;
                @invocablevariable(Label='fecha' required=true)
                            public Date fecha;
    
              date myDate = date.newInstance(2021, 10, 15);
              public JamarConsultaFechaArmadoTest(){
                                      this.empresa='JA';
                                      this.country='01';
                                      this.numeroOp = '2561402';
                                      this.periodoOp = '2021';
                                      this.agencia = '95';
                                      this.fecha = myDate;
                    }
            @istest static void TestConsultaCitaArmado(){
                JamarConsultaFechaArmadoTest testeo = new JamarConsultaFechaArmadoTest();
                JamarConsultaFechaArmado citaArmado = new JamarConsultaFechaArmado(testeo.empresa, testeo.country,testeo.numeroOp,testeo.periodoOp,testeo.agencia, testeo.fecha);
                list<JamarConsultaFechaArmado> citaEnt = new list<JamarConsultaFechaArmado>();
                    citaEnt.add(citaArmado);
                Test.startTest();
                 Test.setMock(HttpCalloutMock.class, new JamarConsultaFechaArmadoaMock());
                 HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/JA/assembly-express', '{"country": "01","codeModel": "02","codeResource": "","period": "202103","rem": "2561402","perRem": "2021","agency": "95","service": "","date": "20210315"}', 'POST');
                 String contentType = response.getHeader('Content-Type');
                System.assert(contentType == 'application/json');
                String actualValue = response.getBody();
                System.debug(response.getBody());
                 String expectedValue = '{'+
                    '    \"calendar\": \"2021-03-17:J1;2021-03-17:J2;2021-03-18:J1;2021-03-18:J2;2021-03-19:J1;2021-03-19:J2;2021-03-20:J1;2021-03-20:J2;2021-03-23:J1;2021-03-23:J2;2021-03-24:J1;2021-03-24:J2;2021-03-25:J1;2021-03-25:J2;2021-03-26:J1;2021-03-26:J2;2021-03-27:J1;2021-03-27:J2;2021-03-29:J1;2021-03-29:J2;2021-03-30:J1;2021-03-30:J2;2021-03-31:J1;2021-03-31:J2;2021-04-5:J1;2021-04-5:J2;2021-04-6:J1;2021-04-6:J2;2021-04-7:J1;2021-04-7:J2;2021-04-8:J1;2021-04-8:J2;2021-04-9:J1;2021-04-9:J2;2021-04-12:J1;2021-04-12:J2;2021-04-13:J1;2021-04-13:J2;2021-04-14:J1;2021-04-14:J2;2021-04-15:J1;2021-04-15:J2;2021-04-16:J1;2021-04-16:J2;2021-04-17:J1;2021-04-17:J2;2021-04-19:J1;2021-04-19:J2;2021-04-20:J1;2021-04-20:J2\",'+
                    '    \"tecnico\": \"007711\",'+
                    '    \"recurso\": \"03\",'+
                    '    \"error\": null,'+
                    '    \"ds\": \"{\\\"ps_vctecnico\\\":\\\"007711\\\",\\\"ps_vccodrecurso\\\":\\\"03\\\",\\\"ps_vccalendario\\\":\\\"2021-03-17:J1;2021-03-17:J2;2021-03-18:J1;2021-03-18:J2;2021-03-19:J1;2021-03-19:J2;2021-03-20:J1;2021-03-20:J2;2021-03-23:J1;2021-03-23:J2;2021-03-24:J1;2021-03-24:J2;2021-03-25:J1;2021-03-25:J2;2021-03-26:J1;2021-03-26:J2;2021-03-27:J1;2021-03-27:J2;2021-03-29:J1;2021-03-29:J2;2021-03-30:J1;2021-03-30:J2;2021-03-31:J1;2021-03-31:J2;2021-04-5:J1;2021-04-5:J2;2021-04-6:J1;2021-04-6:J2;2021-04-7:J1;2021-04-7:J2;2021-04-8:J1;2021-04-8:J2;2021-04-9:J1;2021-04-9:J2;2021-04-12:J1;2021-04-12:J2;2021-04-13:J1;2021-04-13:J2;2021-04-14:J1;2021-04-14:J2;2021-04-15:J1;2021-04-15:J2;2021-04-16:J1;2021-04-16:J2;2021-04-17:J1;2021-04-17:J2;2021-04-19:J1;2021-04-19:J2;2021-04-20:J1;2021-04-20:J2\\\",\\\"ps_vcmsgerror\\\":null}\"'+
                    '}';
                System.assertEquals(actualValue, expectedValue);
                System.assertEquals(200, response.getStatusCode());
                 JamarConsultaFechaArmado.ConsultaArmado(citaEnt);
                 Test.stopTest();
                JamarConsultaFechaArmado.dias('Sunday');
                JamarConsultaFechaArmado.meses('November');
     }
    
}