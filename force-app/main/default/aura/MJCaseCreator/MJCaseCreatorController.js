({
    
      
    openModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
    
    
    
    
    closeModel: function(component, event, helper) {  
        component.set("v.isOpen", false);
    },  
    
    
    
    
     handleOnload : function(component, event, helper) {
    var accountRecordId = component.get("v.recordId");

    // requires inputFields to have aura:id
    component.find("lookup").set("v.value", accountRecordId);
   },
      
    
    onhandleSuccess : function (component, event, helper) {
    var payload = event.getParams().response;
    console.log(payload.id);//this is newly created record id
        
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
    "recordId": payload.id,
    "slideDevName": "detail"
	});
	navEvt.fire();
        
    },




    
   createRecord : function (component, event, helper) {
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      "recordId": payload.id,
      "slideDevName": "related"
    });
    navEvt.fire();
} 
    
})