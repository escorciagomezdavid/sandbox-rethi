public class MJDireccionesController{
    
    public String IdPais{get;set;}
    public list<SelectOption>Paises{
    get{
        list<SelectOption>Opciones=new list<SelectOption>();
        list<Pais__c>listPaises = [Select id, Name  from Pais__c Where Name!=Null Limit 9999];
        Opciones.add(new SelectOption('' , '--Ninguno--'));
        if(listPaises.size()>0){
            for(Pais__c p:listPaises){
                Opciones.add(new SelectOption(p.Id , p.Name));
            }
        }
        return Opciones;
    }set;}
    

    //variable de cuenta para tomar los filtros en los campos
    Public Account CuentaPersona {get{if(CuentaPersona==null){CuentaPersona=new Account();}return CuentaPersona;}set;}    
}