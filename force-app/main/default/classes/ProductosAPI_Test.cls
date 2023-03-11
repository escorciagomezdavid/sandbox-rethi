@isTest
public class ProductosAPI_Test {
  
		@testSetup static void setup(){
        }  
    
    static testmethod void productosUpsertTest(){
            test.startTest();
			
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/productosapi/';
            req.httpMethod = 'POST';
            RestContext.response = res;
            RestContext.response.statusCode = Util.statusCode200;			
            req.addHeader('Content-Type', 'application/json');
			//test de la accion insert de registro nuevo
			String body = '{"productosList":[{"Nombreproducto":"Producto1","Codigoproducto": "P000","TipoPieza": "Monopieza", "Descripcion":"Descripcion producto","Active": true,"IdProducto": "JAP000","EstadoProducto": "ACTIVO","DiasGarantia": 1,"AplicaGarantia": "SI"}]}';			
            req.requestBody = blob.valueOF(body);
            RestContext.request = req;
            ProductosAPI.upsertProductos();

			//test de la accion insert con array vacio
			String body2 = '{"productosList":[]}';			
            req.requestBody = blob.valueOF(body2);
            RestContext.request = req;
            ProductosAPI.upsertProductos();				
			
			//test de la accion insert con datos requeridos faltantes
			String body3 = '{"productosList":[{"Nombreproducto":"","Codigoproducto": "P000", "TipoPieza": "Monopieza", "Descripcion":"Descripcion producto","Active": true,"IdProducto": "JAP000","EstadoProducto": "ACTIVO","DiasGarantia": 1,"AplicaGarantia": "SI", "Armable": true}]}';			
            req.requestBody = blob.valueOF(body3);
            RestContext.request = req;
            ProductosAPI.upsertProductos();

			//test de la accion insert con datos erroneos
			String body4 = '{"productosList":[{"Nombreproducto":"Producto1","Codigoproducto": "P000", "TipoPieza": "Monopieza", "Descripcion":"Descripcion producto","Active": true,"Armable": true, "IdProducto": "JAP000","EstadoProducto": "ACTIVOS","DiasGarantia": 1,"AplicaGarantia": "SI"}]}';			
            req.requestBody = blob.valueOF(body4);
            RestContext.request = req;
            ProductosAPI.upsertProductos();				
			/**
				{
				"productosList":[
					{
					"Nombreproducto":"Comedor 4 Puestos Kepler Lino Azul, Natural",
					"Codigoproducto": "P002",
					"Descripcion":"Comedor tipo base cubierta de madera, estructura elaborada 100% en madera de roble con acabado semimate color Natural-Blanco, tapizado en tela tipo Lino de alta durabilidad y suave al tacto color Azul. Incluye 4 sillas. *Requiere servicio de armado.",
					"Active": true,
					"Categoria": "Comedores",
					"Linea": "Comedores",
					"Sublinea": "Bife",
					"UnidadMedida": "Unidad",
					"UrlImagen": "https://cdn.shopify.com/s/files/1/0014/7531/3727/products/file_72aa5724-121d-4281-9fbd-0329e5df4ff2.progressive.jpg?v=1565934617",
					"IdProducto": "JAP002",
					"EstadoProducto": "ACTIVO",
					"DiasGarantia": 21900,				
					"AplicaGarantia": "SI"                
					}
				]
				}
		  **/	
    }

    
}