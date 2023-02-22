public class InterfaceAutorizador {
	public Boolean success;
	public List<Message> messageList;

	public class Message {
		public String Nocumplidos;
	}
	
	public static InterfaceAutorizador parse(String json) {
		return (InterfaceAutorizador) System.JSON.deserialize(json, InterfaceAutorizador.class);
	}
}