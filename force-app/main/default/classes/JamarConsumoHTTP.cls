/*
  Name: JamarConsumoHTTP
  Proposito: Manejar las llamadas HTTP.
  Autor: Daniela Sanchez
  Fecha: 12/10/2021
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------
  BSILVERA - 03/11/2021 -  Se añade parametros de entrada al metodo. Url,Body,Method.
  DSANCHEZ - 14/03/2022 -  Se añade parametro de tiempo de espera para aquellos servicios que lo requieran.
  DSANCHEZ - 31/05/2022 -  Se añada si aplica o no al token.
 
*/
public class JamarConsumoHTTP {
    
	public static HttpResponse callServiceExternal(String url, String body, String method, String Num) {
		if (method != 'GET') {
			if (num == '' || num == null) {
				Http http = new Http();
				HttpRequest request = new HttpRequest();
				request.setEndpoint(url);
				request.setMethod(method);
				request.setHeader('Content-Type', 'application/json');
				request.setBody(body);
				HttpResponse response = http.send(request);
				return response;
			} else {
				Integer tiempo = Integer.valueOf(num);
				Http http = new Http();
				HttpRequest request = new HttpRequest();
				request.setEndpoint(url);
				request.setMethod(method);
				request.setHeader('Content-Type', 'application/json');
				request.setBody(body);
				request.setTimeout(tiempo);
				HttpResponse response = http.send(request);
				return response;
			}
		} else {
			if (num == '' || num == null) {
				Http http = new Http();
				HttpRequest request = new HttpRequest();
				request.setEndpoint(url);
				request.setMethod(method);
				request.setHeader('Content-Type', 'application/json');
				HttpResponse response = http.send(request);
				return response;
			} else {
				Integer tiempo = Integer.valueOf(num);
				Http http = new Http();
				HttpRequest request = new HttpRequest();
				request.setEndpoint(url);
				request.setMethod(method);
				request.setHeader('Content-Type', 'application/json');
				request.setTimeout(tiempo);
				HttpResponse response = http.send(request);
				return response;
			}
		}

	}
	public static HttpResponse callServiceExternalWithToken(String url, String body, String method, String aplicaToken) {
		if (method == 'GET') {
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Authorization', 'Bearer ' + aplicaToken);
			request.setHeader('Content-Type', 'application/json');
			HttpResponse response = http.send(request);
			return response;
		} else {
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Authorization', 'Bearer ' + aplicaToken);
			request.setHeader('Content-Type', 'application/json');
			request.setBody(body);
			HttpResponse response = http.send(request);
			return response;
		}

	}
	public static HttpResponse callServiceExternalWithTokenAndTimeOut(String url, String body, String method, String Num, String aplicaToken) {
		if (method == 'GET') {
			Integer tiempo = Integer.valueOf(num);
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Authorization', 'Bearer ' + aplicaToken);
			request.setHeader('Content-Type', 'application/json');
			request.setTimeout(tiempo);
			HttpResponse response = http.send(request);
			return response;
		} else {
			Integer tiempo = Integer.valueOf(num);
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Authorization', 'Bearer ' + aplicaToken);
			request.setHeader('Content-Type', 'application/json');
			request.setBody(body);
			request.setTimeout(tiempo);
			HttpResponse response = http.send(request);
			return response;
		}
	}
	public static HttpResponse callServiceExternalWithTimeOut(String url, String body, String method, String Num) {
		if (method == 'GET') {
			Integer tiempo = Integer.valueOf(num);
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Content-Type', 'application/json');
			request.setTimeout(tiempo);
			HttpResponse response = http.send(request);
			return response;
		} else {
			Integer tiempo = Integer.valueOf(num);
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Content-Type', 'application/json');
			request.setBody(body);
			request.setTimeout(tiempo);
			HttpResponse response = http.send(request);
			return response;
		}
	}
	public static HttpResponse callServiceExternalBasic(String url, String body, String method) {
		if (method == 'GET') {
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Content-Type', 'application/json');
			HttpResponse response = http.send(request);
			return response;
		} else {
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(url);
			request.setMethod(method);
			request.setHeader('Content-Type', 'application/json');
			request.setBody(body);
			HttpResponse response = http.send(request);
			return response;
		}
	}

	
}