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

        
        if(tipovalue== "Continuar")
        {
            component.set("v.Execute", "runFlow");
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
        
        if(finishExecute=="runFlow")
        {
            component.set("v.isOpen", false);
            component.set("v.FlowCanvan", true);
            
            var flow = component.find("flowData");
            var inputVariables = [
                { name : "FlowOpportunityId", type : "SObject", value: {
                    "Id" : component.get("v.recordId")}
                },
                
                
            ];
                flow.startFlow("Rethi_Flujo_Padre", inputVariables);
                
        }
              
     }, 
 })