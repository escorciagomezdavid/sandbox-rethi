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
    
    onDependentFieldChange: function(component, event, helper) {
        
        var tipovalue = event.getSource().get("v.value");
        component.set("v.Testing", tipovalue);
        
        if(tipovalue== "Escalonamiento vendedor")
        {
            component.set("v.Execute", "runFlow31");
            component.set("v.CaseName", tipovalue);
        }
    },
    

    handleStatusChange : function (component, event) {
        
        if(event.getParam("status") === "FINISHED") {
           component.set("v.isOpen", false);
           component.set("v.FlowCanvan", false);         
        }
        
    },
    
      
    createRecord: function(component, event, helper) {
        
        var finishExecute = component.get("v.Execute");
        
        if(finishExecute== "standard")
        {
            
            helper.getRecordType(component);
            component.set("v.isOpen", false);
        }
        
        if(finishExecute=="runFlow")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
            flow.startFlow("SolicituddePazySalvo", inputVariables2);
            
        }
        
        
        if(finishExecute=="runFlow3")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables3 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("CertificadodeSaldoalDia", inputVariables3);
                
                }
                
                
                
                if(finishExecute=="runFlow4")
                {
                component.set("v.isOpen", false);
                component.set("v.FlowCanvan", true);
                
                var flow = component.find("flowData");
                var inputVariables4 = [
                { name : "FlowAccountId", type : "SObject", value: {
                "Id" : component.get("v.recordId")}
                },
                
                
            ];
            
            flow.startFlow("SolicituddeCobroaDomicilio", inputVariables4);
            
        }  
        
        
        if(finishExecute=="runFlow5")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables5 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("Negociacion", inputVariables5);
                
                } 
                
                
        if(finishExecute=="runFlow7")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables7 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("NE_Generico_Padre", inputVariables7);
                
                }
        
         if(finishExecute=="runFlow6")
                {
                component.set("v.isOpen", false);
                component.set("v.FlowCanvan", true);
                
                var flow = component.find("flowData");
                flow.startFlow("Garantias");
                
                }
        
        if(finishExecute=="runFlow8")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables8 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("Flujo_Generacion_Documento", inputVariables8);
                
                }
                
        if(finishExecute=="runFlow9")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables9 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("TMC_Generico_Padre", inputVariables9);
                
                }
        
        if(finishExecute=="runFlow10")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables10 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("SAW_Generico_Padre", inputVariables10);
                
                }
                
         if(finishExecute=="runFlow11")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables11 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("IAW_Generico_Padre", inputVariables11);
                
                }
        
         if(finishExecute=="runFlow11")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables11 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("IAW_Generico_Padre", inputVariables11);
                
                }
                
        if(finishExecute=="runFlow12")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables12 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("IGC_Generico_Padre", inputVariables12);
                
                }
                  
        if(finishExecute=="runFlow13")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables13 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("ICC_Generico_Padre", inputVariables13);
                
                }
                if(finishExecute=="runFlow14")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables14 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("APS_Generico_Padre", inputVariables14);
                
                }
        
        if(finishExecute=="runFlow15")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables15 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("ICR_Generico_Padre", inputVariables15);
                
                }
                
                 if(finishExecute=="runFlow16")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables16 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("ATI_Generico_Padre", inputVariables16);
                
                }
        
        if(finishExecute=="runFlow17")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables17 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("CEC_Generico_Padre", inputVariables17);
                
                }
                if(finishExecute=="runFlow18")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables18 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("IAP_Generico_Padre", inputVariables18);
                
                }
        if(finishExecute=="runFlow19")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables19 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },               
            ];                
                flow.startFlow("CP_Generico_Padre", inputVariables19);
                
                }
                
                 if(finishExecute=="runFlow20")
              {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables20 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                
                flow.startFlow("NCA_Padre", inputVariables20);
                
                }
        if(finishExecute=="runFlow21")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables21 = [
                { name : "FlowAccount", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("SLC", inputVariables21);                
                }
           if(finishExecute=="runFlow22")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables22 = [
                { name : "FlowAccount", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Cancelacion_Dia_De_Pago", inputVariables22);                
                }
        
        if(finishExecute=="runFlow23")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables23 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Contingencia", inputVariables23);                
                }
        if(finishExecute=="runFlow24")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables24 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Actualizacion_De_Datos", inputVariables24);                
                }
        if(finishExecute=="runFlow25")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables25 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Cliente_No_Recibio_Documento", inputVariables25);                
                }
          if(finishExecute=="runFlow26")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables26 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Servicio_Prioritario", inputVariables26);                
                }
        if(finishExecute=="runFlow27")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables27 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Cobro_Domicilio", inputVariables27);                
                }
         if(finishExecute=="runFlow28")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables28 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Otras_Quejas_Cartera", inputVariables28);                
                }
        if(finishExecute=="runFlow29")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables29 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("OSC_PADRE", inputVariables29);                
                }
                
      if(finishExecute=="runFlow30")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables30 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("SCCC_PADRE", inputVariables30);                
                }
        
        if(finishExecute=="runFlow31")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables31 = [
                { name : "FlowAccountId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },                
            ];                
                flow.startFlow("Escalonamiento_Vendedor", inputVariables31);                
                }
     }, 
 })