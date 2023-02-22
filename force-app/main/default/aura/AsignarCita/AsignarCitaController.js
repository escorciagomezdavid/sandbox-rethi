({
  openModel: function(component, event, helper) {
    component.set("v.isOpen", true);
  },

  closeModel: function(component, event, helper) {
    component.set("v.isOpen", false);
  },

  closeFlowModel: function(component, event, helper) {
    component.set("v.FlowCanvan", false);
  },
  onDependentFieldChange: function(component, event) {
    var tipovalue = event.getSource().get("v.value");
    component.set("v.Testing", tipovalue);
    if (tipovalue == "OUTBOUND") {
      component.set("v.Execute", "runFlow");
    }
    if (tipovalue == "INBOUND") {
      component.set("v.Execute", "runFlow2");

    }
    if (tipovalue == "ARMADO") {
      component.set("v.Execute", "runFlow4");

    }
    if (tipovalue == "REASIGNACION") {
            component.set("v.Execute", "runFlow3");            
    }
  },
  handleStatusChange: function(component, event) {
    if (event.getParam("status") === "FINISHED") {
      component.set("v.isOpen", false);
      component.set("v.FlowCanvan", false);
    }
  },
  UpdateRecord: function(component, event, helper) {
    var finishExecute = component.get("v.Execute");

    if (finishExecute == "standard") {
      helper.getRecordType(component);
      component.set("v.isOpen", true);
    }
    if (finishExecute == "runFlow") {
      component.set("v.isOpen", false);
      component.set("v.FlowCanvan", true);
      var flow = component.find("flowData");
      var inputVariables = [
        { name : "caseID", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
        },
        { name : "Proceso", type : "String", value:"OUTBOUND"
        }        
      ];
      flow.startFlow("AEOP_OP_Asignaci_n_de_cita", inputVariables);
    }
      
   if (finishExecute == "standard") {
      helper.getRecordType(component);
      component.set("v.isOpen", true);
    }
    if (finishExecute == "runFlow2") {
      component.set("v.isOpen", false);
      component.set("v.FlowCanvan", true);
      var flow = component.find("flowData");
      var inputVariables = [
        { name : "caseID", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
        },
        { name : "Proceso", type : "String", value:"INBOUND"
        }        
      ];
      flow.startFlow("AEOP_OP_Asignaci_n_de_cita", inputVariables);
    }
      if (finishExecute == "standard") {
            helper.getRecordType(component);
            component.set("v.isOpen", true);
      }
      if (finishExecute == "runFlow3") {
          component.set("v.isOpen", false);
          component.set("v.FlowCanvan", true);
          var flow = component.find("flowData");
          var inputVariables = [
              { name : "caseID", type : "SObject", value: {
                  "Id" : component.get("v.recordId")}
              },
              { name : "Proceso", type : "String", value:"INBOUND"
              }          
          ];
          flow.startFlow("ACS_Asignaci_n_de_cita_Recogida_y_Entrega", inputVariables);
      }
      if (finishExecute == "runFlow4") {
          component.set("v.isOpen", false);
          component.set("v.FlowCanvan", true);
          var flow = component.find("flowData");
          var inputVariables = [
              { name : "caseID", type : "SObject", value: {
                  "Id" : component.get("v.recordId")}
              },{ name : "Proceso", type : "String", value:"ARMADO"
              }      
          ];
          flow.startFlow("AEOP_ARMADO_Asignaci_n_de_cita", inputVariables);
      }
  }
});