@IsTest
public class ProductosOpTest {
            @invocablevariable(Label='ID_OP' required=true)
                            public string idOp;

            public ProductosOpTest(){
                        this.idOp = 'JA_95_2021_2561402';             
                    }
    
            @istest static void TestProductoOp(){ 
                ProductosOpTest testeo = new ProductosOpTest();
                ProductosOp p= new ProductosOp(testeo.idOp);
                list<ProductosOp> citaEnt = new list<ProductosOp>();
                    citaEnt.add(p);
                 
                 TestDataFactory.crearOportunityAndProducts('JA', testeo.idOp,'SinUrl');
                 Test.startTest();
                 Test.setMock(HttpCalloutMock.class, new ProductosOpMock());
                 HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/JA/products/7021603/images',null,'GET',null);
                String actualValue = response.getBody();
                System.debug(response.getBody());
                 String expectedValue = '[{"id": 10242703,"company": "JA","sku": "7021603","assetid": "789620","public_url": "https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789620.jpeg","type":  '+ 
               '"PrimaryProductImage","uploaded": "2021-07-13 01:00:08"}]';
                System.assertEquals(actualValue, expectedValue);
                System.assertEquals(200, response.getStatusCode());
                  ProductosOp.Quantity(citaEnt);
                 Test.stopTest();
                
            }
    
            @istest static void TestProductosOp(){ 
                            ProductosOpTest testeo = new ProductosOpTest();
                            ProductosOp p= new ProductosOp(testeo.idOp);
                            list<ProductosOp> citaEnt = new list<ProductosOp>();
                                citaEnt.add(p);
                           TestDataFactory.crearOportunityAndProducts('JA', testeo.idOp,null);
                 Test.startTest();
                 Test.setMock(HttpCalloutMock.class, new ProductosOpMock());
                 HttpResponse response  = JamarConsumoHTTP.callServiceExternal('https://gm36tm91y3.execute-api.us-east-1.amazonaws.com/api/v1/JA/products/7021603/images',null,'GET',null);
                String actualValue = response.getBody();
                System.debug(response.getBody());
                 String expectedValue = '[{"id": 10242703,"company": "JA","sku": "7021603","assetid": "789620","public_url": "https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789620.jpeg","type":  '+ 
               '"PrimaryProductImage","uploaded": "2021-07-13 01:00:08"}]';
                System.assertEquals(actualValue, expectedValue);
                System.assertEquals(200, response.getStatusCode());
                  ProductosOp.Quantity(citaEnt);
                 Test.stopTest();
                }  
            @istest static void TestProductosSinarmadoOp(){ 
                            ProductosOpTest testeo = new ProductosOpTest();
                            ProductosOp p= new ProductosOp(testeo.idOp);
                            list<ProductosOp> citaEnt = new list<ProductosOp>();
                                citaEnt.add(p);
                           TestDataFactory.crearOportunityAndProducts('JA', testeo.idOp,'SinArmado');
                 Test.startTest();
                  ProductosOp.Quantity(citaEnt);
                 Test.stopTest();
                }
           @istest static void TestProductosSinGarantiaOp(){ 
                            ProductosOpTest testeo = new ProductosOpTest();
                            ProductosOp p= new ProductosOp(testeo.idOp);
                            list<ProductosOp> citaEnt = new list<ProductosOp>();
                                citaEnt.add(p);
                           TestDataFactory.crearOportunityAndProducts('JA', testeo.idOp,'SinGarantia');
                 Test.startTest();
                  ProductosOp.Quantity(citaEnt);
                 Test.stopTest();
                }
            }