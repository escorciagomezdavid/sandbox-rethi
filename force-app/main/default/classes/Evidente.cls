/*************************************************************************
Nombre de la Clase: Evidente
Versión : 1.0
Fecha de Creación :  22 Noviembre 2022
Funcionalidad:  Busca identificadores para generar el link de evidente que contiene preguntas de data credito.
Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez       22/11/2022       Versión Original
*************************************************************************/
public with sharing class Evidente {
    @invocablevariable(Label = 'idEstudio' required = true)
	public string idEstudio;
    @invocablevariable(Label = 'agencia vendedor' required = true)
	public string agenciaVendedor;
	@invocablevariable(Label = 'Codigo vendedor' required = true)
	public string codigoVendedor;
    @invocablevariable(Label = 'Tipo identificacion' required = true)
	public string identTipo;
	@invocablevariable(Label = 'Identificacion' required = true)
	public string identNumero;
    @invocablevariable(Label = 'Primer Nombre' required = true)
	public string primerNombre;
    @invocablevariable(Label = 'Primer Apellido' required = true)
	public string primerApellido;
    @invocablevariable(Label = 'Segundo Apellido' required = false)
	public string segundoApellido;
    @invocablevariable(Label = 'Fecha expedicion de documento' required = true)
	public Date fechaExpDocumento;
    @invocablevariable(Label = 'Asesor' required = false)
	public string nombreAsesor;


    public Evidente() {}
    public Evidente(String idEstudio,String agenciaVendedor,String codigoVendedor,
                           String identTipo,String identNumero, String primerNombre,
                           String primerApellido, String segundoApellido,
                           Date fechaExpDocumento,String nombreAsesor){
        this.idEstudio = idEstudio; 
        this.agenciaVendedor=agenciaVendedor;
        this.codigoVendedor=codigoVendedor;
        this.identTipo=identTipo;   
        this.identNumero= identNumero;
        this.primerNombre=primerNombre;
        this.primerApellido=primerApellido;
        this.segundoApellido=segundoApellido;
        this.fechaExpDocumento=fechaExpDocumento;  
        this.nombreAsesor=nombreAsesor;       
    }

    @InvocableMethod (label='Generar Evidente')
    public static List<String> GenerarEvidente(list<Evidente> Evdt){
        String idEstudio = Evdt[0].idEstudio;
        String agenciaVendedor = Evdt[0].agenciaVendedor;
        String codigoVendedor = Evdt[0].codigoVendedor;
        String identTipo= processTypeIdentify(Evdt[0].identTipo);
        String identNumero=Evdt[0].identNumero;
        String primerNombre= Evdt[0].primerNombre;
        String primerApellido= Evdt[0].primerApellido;
        String segundoApellido= Evdt[0].segundoApellido;
        Date fechaExpDocumento= Evdt[0].fechaExpDocumento;
        String nombreAsesor = Evdt[0].nombreAsesor;

        List<String> datosEstudio = new List<String>();
        List <String> value = new List<String>();
        for (String st : idEstudio.split('_')) {
			datosEstudio.add(st);
		}
        String empresa= datosEstudio[0];
        String agenciaEstudio = datosEstudio[1];
        String estudio = datosEstudio[2];

        String fechaExpedicion = fechaExpDocumento.format();
        System.debug(fechaExpedicion);
        String url = Endpoint__mdt.getInstance('Evidente_Link').URL__c;
        String data = ValidacionIdentidad.Evidente(empresa,agenciaVendedor,nombreAsesor.toUpperCase(),identTipo, identNumero,primerNombre,
                                                   primerApellido,segundoApellido,fechaExpedicion);
        if(data != 'Error en el consumo'){
            InterfaceEvidente ResultEvidente = new InterfaceEvidente();	
            ResultEvidente = InterfaceEvidente.parse(data);
            System.debug(ResultEvidente);
            if(ResultEvidente.success == true){
                String link=url+'/'+empresa+'/'+identTipo+'/'+identNumero+'/'+ResultEvidente.data.reg_validacion+
                '/'+ResultEvidente.data.id_evidente+'/'+agenciaVendedor+'/'+codigoVendedor+'/'+agenciaEstudio+'/'+estudio;
                System.debug(link);
                value.add(link);
                return value;
            }else if(ResultEvidente.success == false){
                value.add(ResultEvidente.errors);
                return value;
            }
        }else{
            value.add('ERROR EN LA GENERACION DE EVIDENTE');
            return value;
        }
        return null;
    }

    public static String processTypeIdentify(String typeIdentify){

        switch on typeIdentify {
           when 'CEDULA DE CIUDADANIA' {
               return 'CC';
           }
           when 'PASAPORTE' {
               return '41';
           }
           when 'NIT' {
               return 'NT';
           }
           when 'CEDULA DE EXTRANJERIA' {
               return '22';
           }
           when 'TARJETA DE EXTRANJERIA' {
               return '21';
           }
           when 'REGISTRO CIVIL DE NACIMIENTO' {
               return '11';
           }
           when 'TARJETA DE IDENTIDAD' {
               return 'TI';
           }
           when 'TIPO DE DOCUMENTO EXTRANJERO' {
               return '42';
           }
           when 'SIN IDENTIFICACION DEL EXTERIOR O PARA USO DEFINIDO POR LA DIAN' {
               return '43';
           }
        }

        Return 'Error Calculate';

        }
}