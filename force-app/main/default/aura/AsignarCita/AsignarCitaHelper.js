({
    getRecordType: function(component, event, helper) {
        var recordTypeName = "Asignación o Ajuste de Citas de entrega y Armado de OP";
        var action = component.get("c.getRecordTypeId");
        console.log("recordTypeName: " +recordTypeName);
        action.setParams({
            "recordTypeName": recordTypeName
        });
        
        console.log("recordTypeName2: " +recordTypeName);
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            console.log("State: " +state);
            
            if (component.isValid() && state === "SUCCESS") {
                var recordType = response.getReturnValue();
                var caseId = component.get("v.recordId");
                console.log("RecordTypeId: " +recordType.Id);
                
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "entityApiName": "Case",
                    "recordTypeId": recordType.Id,
                    "defaultFieldValues": {
        			'id' : component.get("v.recordId")
    			}	
                    
                    
                });
                createRecordEvent.fire();
                
            }
            else {
                console.log("Failed payment methods with state: " + state);
            }
        });
        
        // Send action off to be executed
        $A.enqueueAction(action);
    }
    
})