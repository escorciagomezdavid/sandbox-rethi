@IsTest
public class JamarInterfaceFechasEntregasTest {
    
	public class Response {
		public Boolean success;
		public String message;
		public List<Data> data;
	}

	public String erroCode;
	public String errorMessage;
	public Response response;

	public class Fechas {
		public String Fecha;
		public String Estado;
	}

	public class Data {
		public List<Fechas> Fechas;
	}

    
    @istest static void testMetodo(){
        String prueba = '{'+
		'    \"erroCode\": null,'+
		'    \"errorMessage\": null,'+
		'    \"response\": {'+
		'        \"success\": true,'+
		'        \"message\": \"Ok\",'+
		'        \"data\": ['+
		'            {'+
		'                \"Fechas\": ['+
		'                    {'+
		'                        \"Fecha\": \"2023-02-11\",'+
		'                        \"Estado\": \"S\"'+
		'                    },'+
		'                    {'+
		'                        \"Fecha\": \"2023-02-13\",'+
		'                        \"Estado\": \"S\"'+
		'                    },'+
		'                    {'+
		'                        \"Fecha\": \"2023-02-14\",'+
		'                        \"Estado\": \"S\"'+
		'                    },'+
		'                    {'+
		'                        \"Fecha\": \"2023-02-15\",'+
		'                        \"Estado\": \"S\"'+
		'                    },'+
		'                    {'+
		'                        \"Fecha\": \"2023-02-16\",'+
		'                        \"Estado\": \"S\"'+
		'                    },'+
		'                    {'+
		'                        \"Fecha\": \"2023-02-17\",'+
		'                        \"Estado\": \"S\"'+
		'                    }'+
		'                ]'+
		'            }'+
		'        ]'+
		'    }'+
		'}';
        JamarInterfaceFechasEntregas prueb = new JamarInterfaceFechasEntregas();
        JamarInterfaceFechasEntregas.parse(prueba);
        
    }

}