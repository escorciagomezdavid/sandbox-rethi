public class ResponseGetClienteWithEstudio {
    
    public String C_EMP;
	public String IDE;
	public String N_IDE;
	public String DEP;
	public String CIU;
	public String BAR;
	public String DIR_ELECT;
	public String FECHA;
	public String USUARIO;
	public String PRI_NOM;
	public String SEG_NOM;
	public String PRI_APE;
	public String SEG_APE;
	public String SENAS;
	public String C_CAB;
	public String C_PAI_NAC;
	public String C_PAI;
	public String NICKNAME;
	public String SEXO;
	public String EST_CIVIL;
	public String DIR;
	public Integer NRO_HIJOS;
	public String ILOC_TEL;
	public String ILOC_COR;
	public String FECHA_DOCEXPIRA;
	public String FECHA_DOCEXPEDICION;
	public String PAIS_DOCEXPEDICION;
	public String DPTO_DOCEXPEDICION;
	public String CIUDAD_DOCEXPEDICION;
	public String FECHA_NAC;
	public String FECHA_CAS;
	public String ENVIA_EMAIL;
	public String SECTOR_TRABAJO;
	public String NIVEL_RIESGO;
	public String CANAL_VINCULACION;
	public String PROPOSITO_CR;
	public String ORIGEN_FONDO;
	public String PAIS_FONDO;
	public String POLITICA_EXPUESTA;
	public String FAM_POLITICA_EXPUESTA;
	public String NOM_FAM_POLITCA_EXPUESTA;
	public String EXTRECHO_COLABORADOR_PEP;
	public String ESTADO_SALUD;
	public String DEPTO_NAC;
	public String CIUDAD_NAC;
	public String C_AGR;
	public String C_EST;
	public String TIPO;
	public String EMPRESA;
	public String CARGO;
	public Integer SUMIN;
	public String OBS;
	public String FIADOR_T;
	public String LUGAR_TRABAJO;
	public String BARRIO_TRABAJO;
	public String CIU_TRABAJO;
	public String DPTO_TRABAJO;
	public String TEL_TRABAJO;
	public String PROG;
	public Integer CODIGO_EPS;
	public String SENAS_TRABAJO;
	public String FIADORPRESENTE;
	public String EPS_COTIZA;
	public String CAB_TRABAJO;
	public String PARENTESCO;
	public String PAIS_TRABAJO;
	public String JORNADA_TRABAJO;
	public String TIPO_VIVIENDA;
	public String TIPO_CONTRATO;
	public String FECHA_TIEMPO_VIVIENDA;
	public String FECHA_TIEMPO_SERVICIO;
	public String OCUPACION;
	public String MODULO;
	public String MAQUINA;
	public Integer INGRESOS_PRINCIPALES;
	public String ACTIVIDAD_NEGOCIO;

	
	public static List<ResponseGetClienteWithEstudio> parse(String json) {
		return (List<ResponseGetClienteWithEstudio>) System.JSON.deserialize(json, List<ResponseGetClienteWithEstudio>.class);
	}
    

}