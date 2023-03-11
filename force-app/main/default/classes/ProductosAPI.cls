/*
    Creacion y actualizacion de Registros de productos
    Autor: Luis Espinoza
    07/oct/2019
*/
@RestResource(urlMapping='/productosapi/*')
global with sharing class ProductosAPI {
    
    //https://  /services/apexrest/productosAPI
    @HttpPost
    //global static void upsertproductos(){
    global static String upsertProductos(){

        String body = System.RestContext.request.requestBody.toString();
        system.debug(body);
        
        //Se deseariliza el JSON del BODY Resquest y se pasa como objeto de la clase personalizada
        productosUpsert productosResult = (productosUpsert) System.JSON.deserialize(body, productosUpsert.class);
        
        //se va inicializar la lista de logs para la transaccion o cada elemento que genere error
        List<Log__c>logsInsert=new List<Log__c>();
        Log__c logRequest=new Log__c(type__c=LABEL.LogTypeSolicitud);
        
        //Se crea una respuesta exitosa
        Response response = new Response();
        RestContext.response.statusCode = Util.statusCode200;
        RestContext.response.addHeader('Content-Type', 'application/json');
        //Validacion del Arreglo de registros
        if(productosResult.productosList==null || productosResult.productosList.size()==0){
              response.message = 'Array cannot be Null';
              response.success = false;
			  response.statusCode = Util.statusCode400;
			  RestContext.response.statusCode = Util.statusCode400; //Datos invalidos
              RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));              
        }
        If(RestContext.response.statusCode == Util.statusCode200){
                List<productos>productosArray=productosResult.productosList;
                List<Product2>productosPorInsertar=new List<Product2>();
                //Se define esta variable para saber cual es la llave del upsert
                Schema.SObjectField IdProductoField = Product2.Fields.IdProducto__c;
                //Este mapa es para identificar el registro de producto en los resultados
                Map<String , productos>mapproductos=new Map<String , productos>();
                //Este contador es para saber el indice del registro al momento de establecer un result a cada registro
                Integer contadorproductos=0;
                Integer contadorErrores=0;
            try{
                for(productos r: productosArray){
                    System.debug('producto ' + r);
					//validacion de valores requeridos
					If(r.NombreProducto!=null && r.NombreProducto!='' && r.IdProducto!=null && r.IdProducto!='' && r.CodigoProducto!=null 
						&& r.CodigoProducto!=''){
						Product2 p =  new Product2();
						p.Name                  =   r.NombreProducto;
						p.ProductCode   		=   r.CodigoProducto;
						p.IdProducto__c         =   r.IdProducto;
						p.Estado_de_producto__c =   r.EstadoProducto;
						p.Dias_de_garantia__c   =   r.DiasGarantia;
						p.Aplica_garantia__c    =   r.AplicaGarantia;
						p.Description			= 	r.Descripcion;
						p.Family				= 	r.Categoria;
						p.IsActive				=	r.Active;
                        p.Armable__c			=	r.Armable;
						p.QuantityUnitOfMeasure	=	r.UnidadMedida;
						p.DisplayUrl			=	r.UrlImagen;
                        p.Tipo_Pieza__c   		=   r.TipoPieza;
						productosPorInsertar.add(p);
						mapproductos.put('p('+contadorproductos+')' ,r);
						contadorproductos++;
					}else{
						//Si no viene algun valor requerido , se envia el resultado como error
						String msg='IdProducto : ('+r.IdProducto+'). ';
						If(r.NombreProducto==null || r.NombreProducto==''){msg+='NombreProducto, ';}
						If(r.IdProducto==null || r.IdProducto==''){msg+='IdProducto, ';}
						If(r.CodigoProducto==null || r.CodigoProducto==''){msg+='CodigoProducto, ';}
						msg+='Son valores requeridos.';
						Response res =  new Response();
						res.success=false;
						res.statusCode=Util.statusCode400;
						res.message=msg;                               
						r.result  =  res;
						contadorErrores++;
						Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=res.success, message__c=res.message, ClassName__c='ProductosAPI');
						logsInsert.add(logError);
					}
                }
                
                System.debug('productos a Insertar o Actualizar ' + productosPorInsertar);

                if(!productosPorInsertar.isEmpty()){
                    Database.UpsertResult[] productosPorInsertaResult = database.upsert(productosPorInsertar,IdProductoField ,false);
                    if(!productosPorInsertaResult.isEmpty()){
                        System.debug('registros upsert : ' + productosPorInsertaResult.size());
                        for(Integer i=0;i<productosPorInsertaResult.size();i++){
                            Database.UpsertResult sr = productosPorInsertaResult[i];
                            productos a=mapproductos.get('p('+i+')');
                            if (sr.isSuccess()){
                                // Operation Success
                                Response r =  new Response();
                                r.success=true;
                                r.statusCode=Util.statusCode200;
                                r.message='Success';
                                a.result = r;
                            }else{
                                // Operation failed, so get errors
                                String bError = 'IdProducto : '+a.IdProducto+'. The following error has occurred :' + sr.getErrors()[0].getStatusCode() + ': ' + sr.getErrors()[0].getMessage() +'';
                                Response r =  new Response();
                                r.success=false;
                                r.statusCode=Util.statusCode500;
                                r.message=bError;                               
                                a.result  =  r;
                                contadorErrores++;                          
                                //Aqui registrar error en el objeto Log
                                Log__c logError=new Log__c(type__c=LABEL.LogTypeRegistro ,success__c=r.success, message__c=r.message,ClassName__c='ProductosAPI');
                                logsInsert.add(logError);
                            }                   
                        }
                    }               
                }
                response.message = 'Request successfully processed';
                if(contadorErrores > 0){
                    response.success = false;
                    response.message = 'Request processed with '+contadorErrores+' errors';
                }
                system.debug(JSON.serialize(response));             
                response.statusCode = Util.statusCode200;                
                RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));                 
              
            }Catch(Exception ex){
                response.message = 'Error interno: ' + ex.getMessage() + ' linea: ' + ex.getLineNumber();
                response.success = false;
				response.statusCode = Util.statusCode500;
                RestContext.response.responseBody = Util.stringToBlob(JSON.serialize(response));
                RestContext.response.statusCode = Util.statusCode500;
                //Aqui registrar en el objeto Log
            }
        }
        productosResult.result=response;
		logRequest.ClassName__c='ProductosAPI';
        logRequest.success__c=response.success;           
        logRequest.message__c='Array with '+productosResult.productosList.size()+' elements. '+response.message;
        
        //agregar el log de la transaccion a la lista
        logsInsert.add(logRequest);
        Insert logsInsert;
        
        return JSON.serialize(productosResult);
    }
    
    global class productosUpsert{
        global list<productos>productosList{get;set;}     
        global Response result{get; set;}
    }
    
    global class Response{
        global boolean success {get; set;}
        global string message {get; set;}
        global integer statusCode {get; set;}
        
        global Response(){
            success=true;
            message=null;
        }
    }
    global class productos{
        global String NombreProducto {get;set;}
		global String CodigoProducto {get;set;}
        global string Descripcion{get;set;}
		global Boolean Active {get;set;}
        global Boolean Armable {get;set;}
		global string Categoria{get;set;}
		global string UnidadMedida{get;set;}
		global string UrlImagen{get;set;}
        global string IdProducto{get;set;}        
        global string EstadoProducto{get;set;}
		global Integer DiasGarantia{get;set;}
		global string AplicaGarantia{get;set;}
        global String TipoPieza {get;set;}
        global Response result{get;set;}
    }
        
    /**
        {
            "productosList":[
                {
                "Nombreproducto":"Comedor 4 Puestos Kepler Lino Azul, Natural",
				"Codigoproducto": "P002",
                "Descripcion":"Comedor tipo base cubierta de madera, estructura elaborada 100% en madera de roble con acabado semimate color Natural-Blanco, tapizado en tela tipo Lino de alta durabilidad y suave al tacto color Azul. Incluye 4 sillas. *Requiere servicio de armado.",
                "Active": true,
				"Categoria": "Comedores",
				"UnidadMedida": "Unidad",
				"UrlImagen": "https://cdn.shopify.com/s/files/1/0014/7531/3727/products/file_72aa5724-121d-4281-9fbd-0329e5df4ff2.progressive.jpg?v=1565934617",
				"IdProducto": "JAP002",
				"EstadoProducto": "ACTIVO",
				"DiasGarantia": 21900,				
                "AplicaGarantia": "SI"                
                },
                {
                "Nombreproducto":"Mecedora Tovic Lino Mostaza, Natural",
				"Codigoproducto": "P003",
                "Descripcion":"Mecedora elaborada en maderade roble y espuma certificada, tapizado en tela tipo Lino de alta durabilidad y suave al tacto, color Mostaza. Medidas: 70x95 cm",
                "Active": true,
				"Categoria": "Mecedoras",
				"UnidadMedida": "Unidad",
				"UrlImagen": "https://cdn.shopify.com/s/files/1/0014/7531/3727/products/file_df1ffaf4-0b1d-46b3-922a-a4da91eaf83f.progressive.jpg?v=1565288040",
				"IdProducto": "JAP003",
				"EstadoProducto": "ACTIVO",
				"DiasGarantia": 17520,				
                "AplicaGarantia": "SI"   
                },
                {
                "Nombreproducto":"Sala Modular Tanner Eurolino Gris Plomo, Natural",
				"Codigoproducto": "P004",
                "Descripcion":"Juego de Sala elaborado en madera y espumas certificadas, tela tipo Eurolino antipeladuras y antiliquidos de facil limpieza color Gris plomo, patas 100% madera de roble color Natural . Incluye: sofa, butaco y puff.",
                "Active": true,
				"Categoria": "Juegos de salas",
				"UnidadMedida": "Juego",
				"UrlImagen": "https://cdn.shopify.com/s/files/1/0014/7531/3727/products/file_adcee8cc-5e3f-41d2-b535-9656b2e83c01.progressive.jpg?v=1565288335",
				"IdProducto": "JAP004",
				"EstadoProducto": "ACTIVO",
				"DiasGarantia": 26280,				
                "AplicaGarantia": "SI"
                }
            ]
        }   
    **/     
    
}