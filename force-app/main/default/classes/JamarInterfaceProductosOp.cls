public class JamarInterfaceProductosOp {
    
     public class Producto {
		public Integer id;
		public String company;
		public String sku;
		public String assetid;
		public String public_url;
		public String type;
		public String uploaded;
	}
    
    public static List<Producto> parse (String json) {
		return (List<Producto>) System.JSON.deserialize(json, List<Producto>.class);
	}
}