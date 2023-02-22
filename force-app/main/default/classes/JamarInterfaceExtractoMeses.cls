public class JamarInterfaceExtractoMeses {
    public Integer id;
    public String month;
    
    Public static List<JamarInterfaceExtractoMeses> parse(String json){
        return(List<JamarInterfaceExtractoMeses>) System.JSON.deserialize(json, List<JamarInterfaceExtractoMeses>.class);
    }
}