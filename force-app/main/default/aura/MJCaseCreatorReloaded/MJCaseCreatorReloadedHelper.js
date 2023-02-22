({
    getRecordType: function(component, event, helper) {
        var recordTypeName = component.get("v.tipovalue");
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
                var accountid = component.get("v.recordId");
                console.log("RecordTypeId: " +recordType.Id);
                
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "entityApiName": "Case",
                    "recordTypeId": recordType.Id,
                    "defaultFieldValues": {
        			'AccountId' : component.get("v.recordId")
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