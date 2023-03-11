/*************************************************************************
Nombre de la Clase:     JamarInterfaceEntregasParciales
Versión :               1.0
Fecha de Creación :     08/03/2023
Funcionalidad :         Mapeo del JSON de la consulta de calendarios de
                        entregas parciales.
Clase de Prueba:        JamarInterfaceEntregasParcialesTest

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Daniela Sanchez        8/03/2023      Version Original
* 

*************************************************************************/

public with sharing class JamarInterfaceEntregasParciales {
    public class Productos {
        @AuraEnabled public String sku;
        @AuraEnabled public String fecha_entrega;
        @AuraEnabled public Integer cantidad;
        @AuraEnabled public Boolean es_obsequio;
        @AuraEnabled public String padre;
        @AuraEnabled public String descripcion;
	}

    @AuraEnabled public List<Calendario> calendario;
    @AuraEnabled public String fecha_entrega;
    @AuraEnabled public List<Productos> productos;

	public class Fechas {
        @AuraEnabled public String Fecha;
        @AuraEnabled public String Estado;
	}

	public class Calendario {
        @AuraEnabled public List<Fechas> Fechas;
	}

    public static List<List<JamarInterfaceEntregasParciales>> parse(String json) {
		return (List<List<JamarInterfaceEntregasParciales>>) System.JSON.deserialize(json, List<List<JamarInterfaceEntregasParciales>>.class);
	}
}