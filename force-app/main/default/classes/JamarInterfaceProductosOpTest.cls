@IsTest
public class JamarInterfaceProductosOpTest {
 public class Productos {
		public String idp;
		public String company;
        public String sku;
        public String assetid;
        public String public_url;
        public String typep;
        public String uploaded;
 }
    
    @istest static void testMetodo(){
    String prueba = '[{ "id": 10242703,"company": "JA","sku": "7021603","assetid": "789620","public_url": "https://app-vendedor-img-step-prd.s3.amazonaws.com/7021603/789620.jpeg","type":  '+ 
        '"PrimaryProductImage","uploaded": "2021-07-13 01:00:08"}]';
       JamarInterfaceProductosOp prueb = new JamarInterfaceProductosOp();
        JamarInterfaceProductosOp.parse(prueba);
        
    }
}