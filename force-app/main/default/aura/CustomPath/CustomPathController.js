({
    doInit : function(component, event, helper) {        		
       helper.getStageNameHelper(component, event, helper);       
	},
    
	stagePicklistSelect : function (component, event, helper) {
        var stepName = event.getParam("detail").value;
        console.log("StepName" + stepName);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
        "title": "Success!",
        "message": "Toast from " + stepName
        });
        toastEvent.fire();
        component.set("v.stagePicklistField.CompletionStages__c", stepName);
        component.find("record").saveRecord($A.getCallback(function(response) {
                if (response.state === "SUCCESS") {
                    $A.get('e.force:refreshView').fire();
                }
            }));
    },

    // changeOPField : function (component, event, helper) {
    //     var value = component.get("v.stagePicklistField.CompletionStages__c");
    //     if (value != undefined) {
    //         var action = component.get("c.saveOpportunitty");
    //         var OpportunityId = component.get("v.recordId");
    //         action.setParams({"OpportunityId": OpportunityId, "stageName": value});
    //         action.setCallback(this, function(response) {
    //             var state = response.getState();
    //             if (state === "SUCCESS") {
    //                 alert('This case has been unescalated!');
    //                 $A.get('e.force:refreshView').fire();
    //             }
    //         } );
    //         $A.enqueueAction(action);
    //     }
    // }
})