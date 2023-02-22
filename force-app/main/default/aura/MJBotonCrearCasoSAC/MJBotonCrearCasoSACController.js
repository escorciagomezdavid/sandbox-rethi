({

    openModel: function (component, event, helper) {
      component.set("v.isOpen", true);
    },
  
    closeModel: function (component, event, helper) {
      component.set("v.isOpen", false);
    },
  
    closeFlowModel: function (component, event, helper) {
      component.set("v.FlowCanvan", false);
    },
  
    onDependentFieldChange: function (component, event, helper) {
  
      var tipovalue = event.getSource().get("v.value");
      component.set("v.Testing", tipovalue);
  
  
      if (tipovalue == "Información Entrega y Armado de OP") {
        component.set("v.Execute", "flow_sac_IEAP");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Asignación o Ajuste de Citas de entrega y Armado de OP") {
        component.set("v.Execute", "flow_sac_AACEA");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Informacion PostVenta") {
        component.set("v.Execute", "flow_sac_IP");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Cancelacion Comunicaciones Mercadeo") {
        component.set("v.Execute", "flow_sac_CCM");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Solicitud Documentos") {
        component.set("v.Execute", "flow_sac_SD");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Asignacion o Ajuste de Citas de Servicio") {
        component.set("v.Execute", "flow_sac_AACS");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Escalonamiento") {
        component.set("v.Execute", "flow_sac_ESC");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Derecho de Petición") {
        component.set("v.Execute", "flow_sac_DP");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Servicios Pagos") {
        component.set("v.Execute", "flow_sac_SP");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Cambio de Referencia") {
        component.set("v.Execute", "flow_sac_CF");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Servicio de Garantía") {
        component.set("v.Execute", "flow_sac_SG");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Solicitud Devolución de Dinero") {
        component.set("v.Execute", "flow_sac_SDD");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Atención Inadecuada") {
        component.set("v.Execute", "flow_sac_ATI");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Insatisfacción Campañas y Eventos") {
        component.set("v.Execute", "flow_sac_ICE");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Incumplimiento Cita Entrega y Armado de la OP") {
        component.set("v.Execute", "flow_sac_ICEA");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Entrega con Novedad OP") {
        component.set("v.Execute", "flow_sac_ENOP");
        component.set("v.CaseName", tipovalue);
      }
      if (tipovalue == "Incumplimiento de Citas Postventa") {
        component.set("v.Execute", "flow_sac_ICPOST");
        component.set("v.CaseName", tipovalue);
      }
	  if (tipovalue == "Entrega con Novedad Postventa") {
        component.set("v.Execute", "flow_sac_ENOPOST");
        component.set("v.CaseName", tipovalue);
      }
	  if (tipovalue == "Inconsistencia en Facturación de OP") {
        component.set("v.Execute", "flow_sac_IFOP");
        component.set("v.CaseName", tipovalue);
      }
	  if (tipovalue == "Comunicación Errada") {
        component.set("v.Execute", "flow_sac_CE");
        component.set("v.CaseName", tipovalue);
      }
	  if (tipovalue == "Cliente no recibe documentos") {
        component.set("v.Execute", "flow_sac_CNRD");
        component.set("v.CaseName", tipovalue);
      }
    },
  
  
    handleStatusChange: function (component, event) {
  
      if (event.getParam("status") === "FINISHED") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", false);
      }
  
    },
  
  
    createRecord: function (component, event, helper) {
  
      var finishExecute = component.get("v.Execute");
  
      if (finishExecute == "standard") {
  
        helper.getRecordType(component);
        component.set("v.isOpen", false);
      }

      if (finishExecute == "flow_sac_IEAP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("IEAP_PADRE", inputVariables);
      }
      if (finishExecute == "flow_sac_AACEA") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables2 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("AEOP_PADRE", inputVariables2);
      }
      if (finishExecute == "flow_sac_IP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables3 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("IPV_PADRE", inputVariables3);
      }
      if (finishExecute == "flow_sac_CCM") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables4 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("CCM_PADRE", inputVariables4);
      }
      if (finishExecute == "flow_sac_SD") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables5 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("SolDoc_SAC_Padre", inputVariables5);
      }
  	  if (finishExecute == "flow_sac_AACS") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables5 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ACS_PADRE", inputVariables5);
      }
     if (finishExecute == "flow_sac_ESC") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables7 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ESC_PADRE", inputVariables7);
      }
     if (finishExecute == "flow_sac_DP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables8 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("DP_PADRE", inputVariables8);
      }
     if (finishExecute == "flow_sac_SP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables9 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("SPSAC_PADRE", inputVariables9);
      }
     if (finishExecute == "flow_sac_CF") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables10 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("CF_PADRE", inputVariables10);
      }
     if (finishExecute == "flow_sac_SG") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables11 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("SG_PADRE", inputVariables11);
      }
     if (finishExecute == "flow_sac_SDD") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables12 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("SDD_PADRE", inputVariables12);
      }
     if (finishExecute == "flow_sac_ATI") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables13 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ATI_PADRE", inputVariables13);
      }
     if (finishExecute == "flow_sac_ICE") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables14 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ICE_PADRE", inputVariables14);
      }
     if (finishExecute == "flow_sac_ICEA") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables15 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ICEA_PADRE", inputVariables15);
      }
    if (finishExecute == "flow_sac_ENOP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables16 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ENOP_PADRE", inputVariables16);
      } 
    if (finishExecute == "flow_sac_ICPOST") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables17 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ICPOST_PADRE", inputVariables17);
      }
	  if (finishExecute == "flow_sac_ENOPOST") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables18 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("ENOPOSTVENTA_PADRE", inputVariables18);
      }
	  if (finishExecute == "flow_sac_IFOP") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables19 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("IFOP_PADRE", inputVariables19);
      }
	  if (finishExecute == "flow_sac_CE") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables20 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("CE_PADRE", inputVariables20);
      }
	  if (finishExecute == "flow_sac_CNRD") {
        component.set("v.isOpen", false);
        component.set("v.FlowCanvan", true);
  
        var flow = component.find("flowData");
        var inputVariables21 = [
          {
            name: "FlowAccountId", type: "SObject", value: {
              "Id": component.get("v.recordId")
            }
          },
        ];
        flow.startFlow("CNRDSAC_PADRE", inputVariables21);
      }
    },
  })