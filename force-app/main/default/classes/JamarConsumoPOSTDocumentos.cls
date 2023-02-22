public class JamarConsumoPOSTDocumentos {
	 public class VTvariable {
         @invocablevariable(Label='Empresa' required=true)
        public string empresas;
        @invocablevariable(Label='api_key' required=true)
        public string apiKey;
        @invocablevariable(Label='usuario' required=true)
        public string usuario;
        @invocablevariable(Label='usuarioEjec' required=true)
        public string usuarioEjec;
        @invocablevariable(Label='Identificacion' required=true)
        public string identificacion;
        @invocablevariable(Label='fecha_emi' required=true)
        public string fechaEmi;
        @invocablevariable(Label='tipoIdentificacion' required=true)
        public string tipoIdentificacion;
        @invocablevariable(Label='tipoMiembro' required=true)
        public string tipoMiembro;
        @invocablevariable(Label='nombre' required=true)
        public string nombre;
        @invocablevariable(Label='cuenta' required=true)
        public string cuenta;  
        @invocablevariable(Label='agencia' required=true)
        public string agencia;
        @invocablevariable(Label='tipoCertificado' required=true)
        public string tipoCertificado;
        /**
         * saldo Variable solo aplica para Cuenta al Dia Y Declaracion de Renta.
         **/ 
        @invocablevariable(Label='Saldo' required=true)
        public string Saldo;
        @invocablevariable(Label='tipoCredito' required=true)
        public string tipoCredito;  
        @invocablevariable(Label='jsonData' required=true)
        public string jsonData;
         @invocablevariable(Label='ano' required=true)
        public string ano;
        @invocablevariable(Label='period')
        public string period;
        @invocablevariable(Label='factura')
        public string factura;
      
    }
	@InvocableMethod (label='Consumir POST Generacion Documentos')
    public static list<String> EnvioPostDocumentos (list<VTvariable> variables){
        String endPoint = 'https://appsprd.mueblesjamar.com.co/GeneralesService/api/cartera/crearhistorico';
        
        list <String> Answerx = new list<String>();
        list <String> IdValue = new list<String>();
        
      
    
        String empresa = variables[0].empresas;
       	String period = variables[0].period;
        String apikey = variables[0].apiKey;
        String usuario = variables[0].usuario;
        String identificacion = variables[0].identificacion;
        String fechaEmi = variables[0].fechaEmi;
        String tipoIdentificacion = variables[0].tipoIdentificacion;
        String tipoMiembro = variables[0].tipoMiembro;
        String nombre = variables[0].nombre;
        String cuenta = variables[0].cuenta;
        String factura = variables[0].factura;
        String agencia = variables[0].agencia;
        String tipoCertificado = variables[0].tipoCertificado;
        String tipoCredito = variables[0].tipoCredito;
        String jsonData = variables[0].jsonData;
        String usuarioEjec = variables[0].usuarioEjec;
        String saldo = variables[0].saldo;
        String ano = variables[0].ano;



   		if(tipoIdentificacion=='CEDULA DE CIUDADANIA'){
            tipoIdentificacion='CC';
        }
        if(tipoMiembro=='T'){
            tipoMiembro = 'Titular';
        }else{
            tipoMiembro = 'Fiador';
        }
        
          /**
           * Certificado Cuenta al Dia
           * 
           * */
        if(tipoCertificado=='A'){
             try{
            
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
        String body = 'c_emp='+empresa+'&api_key='+apikey+'&usuario='+usuario+'&num_doc='+identificacion+'&fecha_emi='+fechaEmi+'&tipodoc='+tipoIdentificacion+'&tipo_miembro='+tipoMiembro+'&nombre='+ nombre+'&cuenta='+cuenta+'&agencia='+agencia+'&tipo_cer='+tipoCertificado+'&saldo='+saldo+'&t_cre='+tipoCredito+'&jsondata='+jsonData;        
        request.setBody(body);
        HttpResponse response = http.send(request);
        Answerx.add(response.getBody());
     	System.debug(Answerx);
        String data = Answerx[0];
        System.debug(data);
      	Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
                 
        IdValue.add(String.valueOf(jsonParsed.get('id')));
		System.debug(IdValue);
        return IdValue;  
           /** 
		  String payload = 'client_id =' + EncodingUtil.urlEncode (clientId, 'UTF-8') + '& client_secret =' + EncodingUtil.urlEncode (clientSecret, 'UTF-8') + '& refresh_token =' + EncodingUtil.urlEncode (refreshToken, 'UTF-8') + '& grant_type = refresh_token';
    	  System.debug (payload);
			**/
        
        }catch(Exception e){
             
            /**
             * Con Esta instancia se crea un caso si el WS Falla
             * 
             * */
        System.debug('The status code returned was not expected: ' + e.getMessage());  
        Case cs = new Case();
        cs.RecordTypeId = '0124O000000arzD';
        cs.Envio_Documento__c = 'Envio por Correo';
        cs.Status = 'Generacion';
        cs.Description = 'Fallo WS Generar y Enviar por Correo';
        cs.AccountId = usuarioEjec;
        cs.Origin = 'Email';
        cs.Tipo_Solicitud__c = 'PETICION';
        cs.SubTipodeGestion__c = 'Cuenta al Dia';
		insert(cs);
        System.debug('.....' + cs.Id);
            
        }
            
            /**
             * Condicional para Generar Paz y Salvo
             * Bsilvera 
             * */
        }if(tipoCertificado=='P'){
              try{
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
        String body = 'c_emp='+empresa+'&api_key='+apikey+'&usuario='+usuario+'&num_doc='+identificacion+'&fecha_emi='+fechaEmi+'&tipodoc='+tipoIdentificacion+'&tipo_miembro='+tipoMiembro+'&nombre='+ nombre+'&cuenta='+cuenta+'&agencia='+agencia+'&tipo_cer='+tipoCertificado+'&t_cre='+tipoCredito+'&jsondata='+jsonData;        
        request.setBody(body);
        HttpResponse response = http.send(request);
        Answerx.add(response.getBody());
     	System.debug(Answerx);
        String data = Answerx[0];
        System.debug(data);
      	Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(data);
        IdValue.add(String.valueOf(jsonParsed.get('id')));
		System.debug(IdValue); 
        return IdValue;  
           /** 
		  String payload = 'client_id =' + EncodingUtil.urlEncode (clientId, 'UTF-8') + '& client_secret =' + EncodingUtil.urlEncode (clientSecret, 'UTF-8') + '& refresh_token =' + EncodingUtil.urlEncode (refreshToken, 'UTF-8') + '& grant_type = refresh_token';
    	  System.debug (payload);
			**/
        
        }catch(Exception e){
            
            /**
             * Con Esta instancia se crea un caso si el WS Falla
             * 
             * */
        System.debug('The status code returned was not expected: ' + e.getMessage());  
        Case cs = new Case();
        cs.RecordTypeId = '0124O000000arzD';
        cs.Envio_Documento__c = 'Envio por Correo';
        cs.Status = 'Generacion';
        cs.Description = 'Fallo WS Generar y Enviar por Correo';
        cs.AccountId = usuarioEjec;
        cs.Origin = 'Email';
        cs.Tipo_Solicitud__c = 'PETICION';
        cs.SubTipodeGestion__c = 'Paz y Salvo';
		insert(cs);
        System.debug('.....' + cs.Id);
            
        }
        }
        if (tipoCertificado=='D'){
            try{
                String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/' + empresa +'/DeclaracionRenta/';
                Map<String, Object> obj = new Map<String, Object>();
                    obj.put('ano', ano);
                    obj.put('n_ide', identificacion);
              	String body = String.valueOf(JSON.Serialize(obj));
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(url);
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json');
                request.setBody(body);
                HttpResponse response = http.send(request);
                String data = response.getBody();
                
                System.debug(url);
                System.debug(body);

                
      			String  urls = CreateHistoryDerenta(data, nombre, ano);
                IdValue.add(urls);
	                return IdValue;
                
            }catch(Exception e){
                System.debug('Error' + e.getMessage());
                  	Case cs = new Case();
                    cs.RecordTypeId = '0124O000000arzD';
                    cs.Envio_Documento__c = 'Envio por Correo';
                    cs.Status = 'Generacion';
                    cs.Description = 'Fallo WS Generar y Enviar por Correo';
                    cs.AccountId = usuarioEjec;
                    cs.Origin = 'Email';
                    cs.Tipo_Solicitud__c = 'PETICION';
                    cs.SubTipodeGestion__c = 'Certificado tributario';
                    insert(cs);
                    System.debug('.....' + cs.Id);
            }
        } if (tipoCertificado == 'H'){
          List<String> Invoices =  GetInvoices('CERT_HISTPAGOV1_ENC_FACTURAS',agencia,tipoCredito,cuenta,empresa);
          
        }if (tipoCertificado == 'E'){
			String  urls = extractUrls(identificacion, empresa, period);
            String urlright = urls.remove('(');
            String urlleft = urlright.remove(')');
            IdValue.add(urlleft);
	        return IdValue;
        } 
        if (tipoCertificado == 'L'){	
			String  urls = extractUrlsCollectDebt(empresa, identificacion, agencia, tipoCredito, cuenta, factura);
            System.debug(urls);
            IdValue.add(urls);
            return IdValue;

        } 
        return null;  
    }        

    public static List<String> GetInvoices(String property, String Agency, String TypeCredit, String Bill, String Company){
        list <String> Answerx = new list<String>();
		Map<String, Object> objson = new Map<String, Object>();
		objson.put('propertie', property);
       	objson.put('agencia', Agency);
       	objson.put('t_cre', TypeCredit);
       	objson.put('cuenta', Bill);
        String body = String.valueOf(JSON.Serialize(objson));
		String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/' + Company + '/findByWithProperty/' ;
		 Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(body);
        HttpResponse response = http.send(request);
        System.debug(url);
        System.debug(body);
        System.debug(response.getBody());

        JSONParser parser = JSON.createParser(response.getBody());
        System.debug(parser);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'fac')) {
                // Get the value.
              	 parser.nextToken();
                String cartera  = String.valueOf(parser.getText());
                System.debug(cartera);
                Answerx.add(cartera);
                
                // Compute the grand total price for all invoices.
            }
        }
        
        
        return Answerx;
    }
    	
   
    public static String CreateHistoryDerenta(String obj, String name, String ano){
        Map <String, Object> jsonParsed = (Map<String, Object>) JSON.deserializeUntyped(obj);
        Map<String, Object> objson = new Map<String, Object>();
      	list <String> Answerx = new list<String>();
        list <String> IdValue = new list<String>();
        
        String tipo_miembro = '';
        if(String.valueOf(jsonParsed.get('tipo'))=='T'){
            tipo_miembro = 'Titular';
          }else if(String.valueOf(jsonParsed.get('tipo'))=='T'){
                    tipo_miembro = 'Fiador';
        }
        
		objson.put('usuario', 'salessforces');
        objson.put('num_doc', String.valueOf(jsonParsed.get('num_ide')));
        objson.put('fecha_emi', String.valueOf(jsonParsed.get('emi')));
        objson.put('tipodoc', String.valueOf(jsonParsed.get('ide')));
        objson.put('tipo_miembro', tipo_miembro);
       	objson.put('nombre', name);
        objson.put('cuenta', String.valueOf(jsonParsed.get('cue')));
        objson.put('agencia', String.valueOf(jsonParsed.get('c_agr')));
        objson.put('tipo_cer', 'D');
        objson.put('jsondata', '[{}]');
        objson.put('ano', ano);
        objson.put('t_cre',  String.valueOf(jsonParsed.get('t_cre')));
        objson.put('pagado',  String.valueOf(jsonParsed.get('pagado')));
        objson.put('saldo',  String.valueOf(jsonParsed.get('saldo')));
        
      	String body = String.valueOf(JSON.Serialize(objson));
		String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/' + String.valueOf(jsonParsed.get('c_emp')) + '/CreateHistory/';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(body);
        HttpResponse response = http.send(request);
        Answerx.add(response.getBody());
     	System.debug(Answerx);
        String data = Answerx[0];
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        String Id = String.valueOf(jsonParseds.get('id'));
        String urls = sendUrl(Id);
        System.debug(urls);
        return  urls;
    }
    public static String sendUrl(String Id){
       	list <String> Answerx = new list<String>();
       	String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/PrintFileDeclaracion/'+Id;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        Answerx.add(response.getBody());
        String data = Answerx[0];
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
		String urls = String.valueOf(jsonParseds.get('url'));
        System.debug(urls);
        return urls;

       }
    /*
     * Mejora  -> Cuando los servicios fallan se deben crear casos
     * 
    */
    public static String extractUrls(String identify, String company, String period){
        
        String currentYear = String.valueOf(System.Today().year());
       	String periodo = currentYear + '-' + period;
        System.debug(periodo);
        String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+company+'/extracto/' + identify +'/'+periodo;
       	list <String> Answerx = new list<String>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        Answerx.add(response.getBody());
		String data = Answerx[0];
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        String urls = String.valueOf(jsonParseds.get('url'));
        System.debug(urls);
        return urls;        
    }
    
    public static String extractUrlsCollectDebt(String Company, String Identify, String Agency, String TypeCredit, String Account, String Bill){
         String url = 'https://696e3lr892.execute-api.us-east-1.amazonaws.com/api/v1/'+Company+'/CollectDebt/';
      	Map<String, Object> objson = new Map<String, Object>();
		list <String> Answerx = new list<String>();
        list <String> IdValue = new list<String>();
		objson.put('n_ide', Identify);
        objson.put('agency', Agency);
        objson.put('t_cre', TypeCredit);
        objson.put('account', Account);
        objson.put('bill', Bill);
        String body = String.valueOf(JSON.Serialize(objson));
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(body);
        HttpResponse response = http.send(request);
        Answerx.add(response.getBody());
        String data = Answerx[0];
        Map <String, Object> jsonParseds = (Map<String, Object>) JSON.deserializeUntyped(data);
        String urls = String.valueOf(jsonParseds.get('url'));
     	System.debug(urls);
        return urls;
    }
}