/*
Name: CaseClase
Proposito: Guarda toda la logica de los metodos que se necesitan de acuerdo a la necesidad del negocio.
Author: Daniela Sanchez
Fecha: 2/04/2022

28/04/2022: Se añade metodo de validacion de Op.

22/08/2022: Se añade dirección que se guarda en el caso y en el cliente.
*/
public class CaseClass {
    public string identificacion;
    public String numeroOp;
    public String codigoProducto;
    public String proceso;
    public String causalPrincipal;
    public String subTipoGestion;
    public String descripcion;
    public String urlImagen;
    public String origenCaso;
    public String tipoSolicitud;
    public String email;
    public String telefono;
    public String usuarioExterno;
    public String RazonCaso;
    public Date fechaEntrega;
    public String direccion;
    public String ciudad;
    public String departamento;
    public String pais;
    
    public caseClass() { }
    /* Metodo: Valida si existe un cliente en SF.
*/
    public static Boolean ValidacionCliente(String identificacion) {
        Boolean existeCuenta;
        List<Account> cliente = [Select Name from Account where Identificacion__c = :identificacion];
        if (cliente.isEmpty()) {
            existeCuenta = false;
        } else {
            existeCuenta = true;
        }
        return existeCuenta;
    }
    /* Metodo: Valida si existe op en SF.
*/
    public static Boolean ValidacionOp(String numeroOp) {
        List<Opportunity> op = new List<Opportunity> ();
        Boolean existeOp;
        op = [Select ID from Opportunity where Numero_OP__c = :numeroOp];
        if (op == null || op.isEmpty()) {
            existeOp = false;
        } else {
            existeOp = true;
        }
        return existeOp;
    }
    /* Metodo: Valida si hay un reservicio y el Status de la garantia.
*/
    public static List<GarantiaResponse> validacionGarantia(String codigoProducto, String numeroOp, String identificacion) {
        List<Case> cases = new List<Case> ();
        List<Opportunity> op = new List<Opportunity> ();
        List<OpportunityLineItem> producto = new List<OpportunityLineItem> ();
        List<GarantiaResponse> value = new List<GarantiaResponse> ();
        GarantiaResponse rp = new GarantiaResponse();
        Integer contador = 0;
        Boolean opExistente = ValidacionOp(numeroOp);
        if (opExistente == false) {
            rp.mensaje = 'No existe Op en Salesforce';
            value.add(rp);
        } else {
            cases = [Select caseNumber, status, Opportunity_Product__c, Oportunidad__c from Case where Account.Identificacion__c = :identificacion and Causal_Principal__c = 'SERVICIO DE GARANTIA'];
            if (cases == null || cases.isEmpty()) {
                rp.mensaje = 'No tiene asociado ningun de servicio de garantia del producto ' + codigoProducto +
                    'de la orden de pedido ' + numeroOp;
                value.add(rp);
            }
            else {
                if (cases.size() < 2)
                {
                    op = [Select Numero_OP__c from Opportunity where ID = :cases[0].Oportunidad__c];
                    if (op.isEmpty() || op == null) {
                        rp.mensaje = 'No tiene asociado ningun de servicio de garantia del producto ' + codigoProducto +
                            'de la orden de pedido ' + numeroOp;
                        value.add(rp);
                    } else {
                        producto = [Select ProductCode from OpportunityLineItem where ID = :cases[0].Opportunity_Product__c];
                        if (cases[0].status == 'Cerrado' && op[0].Numero_OP__c == numeroOp && producto[0].ProductCode == codigoProducto) {
                            rp.status = cases[0].status;
                            rp.numeroCaso = cases[0].caseNumber;
                            rp.mensaje = 'OK';
                            rp.estadoGarantia = 'RESERVICIO';
                            value.add(rp);
                        } else {
                            if (cases[0].status != 'Cerrado' && op[0].Numero_OP__c == numeroOp && producto[0].ProductCode == codigoProducto) {
                                rp.status = cases[0].status;
                                rp.numeroCaso = cases[0].caseNumber;
                                rp.estadoGarantia = 'NO TIENE RESERVICIO';
                                rp.mensaje = 'OK';
                                value.add(rp);
                            } else {
                                rp.mensaje = 'No tiene asociado ningun de servicio de garantia del producto ' + codigoProducto +
                                    'de la orden de pedido ' + numeroOp;
                                value.add(rp);
                            }
                        }
                    }
                    
                }
                else {
                    if (cases.size() > 1) {
                        for (Integer i = 0; i<cases.size(); i++) {
                            op = [Select Numero_OP__c from Opportunity where ID = :cases[i].Oportunidad__c];
                            if (!op.isEmpty()) {
                                producto = [Select ProductCode from OpportunityLineItem where OpportunityId = :cases[i].Oportunidad__c];
                                if (producto.size()> 1) {
                                    for (Integer j = 0; j<producto.size(); j++) {
                                        if (producto[j].ProductCode == codigoProducto && op[0].Numero_OP__c == numeroOp) {
                                            if (cases[i].status == 'Cerrado') {
                                                rp.estadoGarantia = 'RESERVICIO';
                                            } else {
                                                rp.numeroCaso = cases[i].caseNumber;
                                                rp.status = cases[i].status;
                                                rp.mensaje = 'OK';
                                                rp.estadoGarantia = 'NO TIENE RESERVICIO';
                                            }
                                        }
                                    }
                                } else {
                                    if (op[0].Numero_OP__c == numeroOp && producto[0].ProductCode == codigoProducto) {
                                        if (cases[i].status == 'Cerrado') {
                                            rp.estadoGarantia = 'RESERVICIO';
                                        } else {
                                            rp.numeroCaso = cases[i].caseNumber;
                                            rp.status = cases[i].status;
                                            rp.mensaje = 'OK';
                                            rp.estadoGarantia = 'NO TIENE RESERVICIO';
                                        }
                                    }
                                }
                            } 
                        }
                        if (rp.mensaje == null) {
                            rp.mensaje = 'No tiene asociado ningun de servicio de garantia del producto ' + codigoProducto +
                                'de la orden de pedido ' + numeroOp;
                        }
                        value.add(rp);
                    }
                    
                }
            }
            
        }
        
        return value;
    }
    
    /*Metodo: Crear caso.
*/
    public static List<GarantiaResponse> CrearCaso(middlwareCase createCase) {
        List<Opportunity> op = new List<Opportunity> ();
        List<OpportunityLineItem> producto = new List<OpportunityLineItem> ();
        List<GarantiaResponse> value = new List<GarantiaResponse> ();
        List<Case> numeroCaso = new List<Case> ();
        GarantiaResponse rp = new GarantiaResponse();
        MiddlewareClass datos = new MiddlewareClass();
        Account cliente = new Account();
        Case caso = new Case();
        String dir = (createCase.Caso.direccion != '' || createCase.Caso.direccion != null) ? createCase.Caso.direccion : '';
        String mun = (createCase.Caso.ciudad != '' || createCase.Caso.ciudad != null) ? createCase.Caso.ciudad : '';
        String dep = (createCase.Caso.departamento != '' || createCase.Caso.departamento != null) ? createCase.Caso.departamento : '';
        cliente = [Select ID, PersonContactId from Account where Identificacion__c = :createCase.Caso.identificacion];
        if (createCase.Caso.causalPrincipal != null || createCase.Caso.causalPrincipal != '') {
            if ((createCase.Caso.numeroOp != null || createCase.Caso.numeroOp != '') && (createCase.Caso.codigoProducto != null || createCase.Caso.codigoProducto != '')) {
                op = [Select ID from Opportunity where Numero_OP__c = :createCase.Caso.numeroOp];
                if (op == null || op.isEmpty()) {
                    rp.mensaje = 'No se encuentra op en Salesforce';
                    value.add(rp);
                } else {
                    producto = [Select ID from OpportunityLineItem where ProductCode = :createCase.Caso.codigoProducto AND OpportunityId = :op[0].ID];
                    if (producto == null || producto.isEmpty()) {
                        rp.mensaje = 'No se encuentra producto asociado a la op';
                        value.add(rp);
                    } else {
                        if (createCase.Caso.origenCaso != '') {
                            if (createCase.Caso.causalPrincipal == 'SERVICIO DE GARANTIA') {
                                caso.RecordTypeId = '0124O000000EMTD';
                                caso.AccountId = cliente.ID;
                                caso.ContactId = cliente.PersonContactId;
                                caso.Oportunidad__c = op[0].ID;
                                caso.Opportunity_Product__c = producto[0].ID;
                                caso.Causal_Principal__c = 'SERVICIO DE GARANTIA';
                                caso.SubTipodeGestion__c = createCase.Caso.subTipoGestion;
                                caso.Origin = createCase.Caso.origenCaso;
                                caso.Description = createCase.Caso.descripcion;
                                caso.Images__c = createCase.Caso.urlImagen;
                                caso.Correo_electronico__c = createCase.Caso.email;
                                caso.Telefono_Contacto__c = createCase.Caso.telefono;
                                caso.Direccion__c = dir + ', ' + mun + ' - ' + dep;
                                caso.Tipo_Solicitud__c = createCase.Caso.tipoSolicitud;
                                caso.SLA_Dias_de_Vida__c = 30;
                                insert caso;
                                if ((createCase.Caso.telefono != '' || createCase.Caso.telefono != null) && (createCase.Caso.email != '' || createCase.Caso.email != null)) {
                                    cliente.PersonMobilePhone = createCase.Caso.telefono;
                                    cliente.PersonEmail = createCase.Caso.email;
                                    update cliente;
                                } else {
                                    if (createCase.Caso.telefono != '' || createCase.Caso.telefono != null) {
                                        cliente.PersonMobilePhone = createCase.Caso.telefono;
                                        update cliente;
                                    } else if (createCase.Caso.email != '' || createCase.Caso.email != null) {
                                        cliente.PersonEmail = createCase.Caso.email;
                                        update cliente;
                                    } 
                                }
                                
                                if ((createCase.Caso.direccion != '' || createCase.Caso.direccion != null) && (createCase.Caso.ciudad != '' || createCase.Caso.ciudad != null) &&
                                   	(createCase.Caso.departamento != '' || createCase.Caso.departamento != null) && (createCase.Caso.pais != '' || createCase.Caso.pais != null)) {
                                    cliente.BillingStreet = dir;
                                    cliente.BillingCity = mun;
                                    cliente.BillingState = dep;
                                    cliente.BillingCountry = createCase.Caso.pais;
                                    cliente.BillingGeocodeAccuracy = 'Street';
                                    update cliente;
                                }
                                numeroCaso = [Select CaseNumber from Case where(Status = 'Abierto' or Status = 'En Proceso') and Oportunidad__c = :op[0].ID and Opportunity_Product__c = :producto[0].ID ORDER BY CaseNumber DESC];
                                rp.numeroCaso = numeroCaso[0].CaseNumber;
                                rp.mensaje = 'Caso creado con exito';
                                value.add(rp);
                            } else {
                                if (createCase.Caso.causalPrincipal == 'ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP') {
                                    caso.RecordTypeId = '0124O000000EMRf';
                                    caso.AccountId = cliente.ID;
                                    caso.Oportunidad__c = op[0].ID;
                                    caso.Opportunity_Product__c = producto[0].ID;
                                    caso.Causal_Principal__c = 'ASIGNACION O AJUSTE DE CITAS DE ENTREGA Y ARMADO DE OP';
                                    caso.SubTipodeGestion__c = createCase.Caso.subTipoGestion;
                                    caso.Origin = createCase.Caso.origenCaso;
                                    caso.Description = createCase.Caso.descripcion;
                                    caso.Tipo_Solicitud__c = 'PETICION';
                                    caso.Usuario_Externo__c = createCase.Caso.usuarioExterno;
                                    caso.Reason = createCase.Caso.RazonCaso;
                                    caso.SLA_Dias_de_Vida__c = 2;
                                    caso.Fecha_Entrega__c = createCase.Caso.fechaEntrega;
                                    insert caso;
                                    numeroCaso = [Select CaseNumber from Case where(Status = 'Abierto' or Status = 'En Proceso') and Oportunidad__c = :op[0].ID and Opportunity_Product__c = :producto[0].ID ORDER BY CaseNumber DESC];
									rp.numeroCaso = numeroCaso[0].CaseNumber;
                                    rp.mensaje = 'Caso creado con exito';
                                    value.add(rp);
                                }
                            }
                        } else {
                            rp.mensaje = 'Origen del caso es obligatorio';
                            value.add(rp);
                        }
                    }
                }
            } else {
                rp.mensaje = 'No tiene los datos de numero de op y codigo de producto completos';
                value.add(rp);
            }
        } else {
            rp.mensaje = 'No tiene causal principal asociado al caso. Es obligatorio';
            value.add(rp);
        }
        
        return value;
    }
    /*Metodo: Envio de informacion de casos de garantia.
*/
    public static List<TrackingCase> DatosTrackingCaso(String identificacion) {
        Boolean clienteExiste = ValidacionCliente(identificacion);
        TrackingCase rp;
        List<TrackingCase> value = new List<TrackingCase> ();
        if (clienteExiste == true) {
            List<Case> casosCliente = [Select Id, caseNumber, status, CreatedDate, Tipo_de_diagnostico__c, Estado_del_Producto__c, SubTipodeGestion__c, Opportunity_Product__c, Oportunidad__c from Case where Account.Identificacion__c = :identificacion and Causal_Principal__c = 'SERVICIO DE GARANTIA'];
            for (Integer i = 0; i<casosCliente.size(); i++) {
                rp = new TrackingCase();
                Date fechaformateada;
                Map<String, Date> fechas = new Map<String, Date> ();
                List<CaseHistory> fechaetapa = [SELECT NewValue, CreatedDate FROM CaseHistory WHERE CaseId = :casosCliente[i].Id and Field = 'Status' ORDER BY CreatedDate DESC];
                List<Opportunity> op = [Select Numero_OP__c from Opportunity where ID = :casosCliente[i].Oportunidad__c];
                List<OpportunityLineItem> Productos = [Select ProductCode from OpportunityLineItem where ID = :casosCliente[i].Opportunity_Product__c];
                if(!op.isEmpty()){
                    rp.status = casosCliente[i].status;
                    rp.numeroCaso = casosCliente[i].caseNumber;
                    rp.tipoDiagnostico = casosCliente[i].Tipo_de_diagnostico__c;
                    rp.tipoGarantia = casosCliente[i].SubTipodeGestion__c;
                    rp.tipoSolucion = casosCliente[i].Estado_del_Producto__c;
                    rp.numeroOp = op[0].Numero_OP__c;
                    rp.codigoProducto = Productos[0].ProductCode;
                    if (fechaetapa.isEmpty() || fechaetapa == null) {
                        fechaformateada = casosCliente[i].CreatedDate.date();
                        fechas.put('Abierto', fechaformateada);
                        rp.fechaEtapaCaso = fechas;
                    } else {
                        fechas.put('Abierto', casosCliente[i].CreatedDate.date());
                        for (Integer j = 0; j<fechaetapa.size(); j++) {
                            fechaformateada = fechaetapa[j].CreatedDate.date();
                            fechas.put(String.valueOf(fechaetapa[j].NewValue), fechaformateada);
                        }
                        rp.fechaEtapaCaso = fechas;
                    }
                    value.add(rp);
                }else{
                    rp.mensaje = 'No aplica';
                    value.add(rp);
                }
                
            }
        } else {
            rp.mensaje = 'No existe cliente en salesforce';
            value.add(rp);
            
        }
        return value;
        
    }
    
    // Cambios creados no subidos a prd (se usa en otros archivos de sandbox, descomentar despues de hacer deploy en prd)
    // public static List<caseWeb> obtenerOrigenes(){
    //     caseWeb rp = new caseWeb();
    //     List<caseWeb> value = new List<caseWeb> ();
    //     List<String> origenCARTERA = new List<String>();
    //     List<String> origenSAC = new List<String>();

    //     Schema.DescribeFieldResult fieldDescription = Objeto_Asistente__c.PickOrigen__c.getDescribe();  
    //     Schema.DescribeFieldResult fieldDescription2 = Objeto_Asistente__c.Origen_Caso_SAC__c.getDescribe();      
    //     List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();
    //     List<Schema.PicklistEntry> entries2 = fieldDescription2.getPicklistValues();

    //     for (Schema.PicklistEntry entry : entries) {
    //         if (entry.isActive()) {
    //             origenCARTERA.add(entry.getLabel());
    //         }
    //     } 
        
    //     for (Schema.PicklistEntry entry : entries2) {
    //         if (entry.isActive()) {
    //             origenSAC.add(entry.getLabel());
    //         }
    //     } 

    //     rp.SAC = origenSAC;
    //     rp.CARTERA = origenCARTERA;
    //     value.add(rp);
    //     System.debug(value);
    //     return value;
    // }
    
    // Metodos creados pero no subidos a prd (tampoco se usa en sandbox)
    // public static List<caseWeb> obtenerCausales(){
    //     caseWeb rp = new caseWeb();
    //     List<caseWeb> value = new List<caseWeb> ();
    //     List<String> causalCARTERA = new List<String>();
    //     List<String> causalSAC = new List<String>();
        
    //     Schema.DescribeFieldResult fieldDescription = Case.TipodeGestion__c.getDescribe();  
    //     Schema.DescribeFieldResult fieldDescription2 = Objeto_Asistente__c.Tipo_de_Gestion__c.getDescribe(); 
    //     List<Schema.PicklistEntry> entries = fieldDescription.getPicklistValues();
    //     List<Schema.PicklistEntry> entries2 = fieldDescription2.getPicklistValues();
        
    //     for (Schema.PicklistEntry entry : entries) {
    //         if (entry.isActive()) {
    //             causalCARTERA.add(entry.getLabel());
    //         }
    //     } 
        
    //     for (Schema.PicklistEntry entry : entries2) {
    //         if (entry.isActive()) {
    //             causalSAC.add(entry.getLabel());
    //         }
    //     }
        
    //     return value;
    // }
    
}