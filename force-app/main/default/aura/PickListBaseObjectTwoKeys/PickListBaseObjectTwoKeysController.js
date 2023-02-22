({
    loadOptions: function (component, event, helper) {
        var inputVariable = component.get('v.message')
        var objectJson = JSON.parse(inputVariable)
        var listObjectJson = objectJson.data
        var opts = []
        for(var i = 0; i<listObjectJson.length; i++){
                
                opts.push({ value: listObjectJson[i].code, label: listObjectJson[i].label})            
        }
        console.log(opts)        
        component.set("v.options", opts);
        component.find("mySelect").get("v.value");
      
    },
    handleChange: function (cmp, event, helper) {
        //Do something with the change handler
        var inputVariable = cmp.get('v.message')
        var objectJson = JSON.parse(inputVariable)
        var listObjectJson = objectJson.data
        var opts = []
        for(var i = 0; i<listObjectJson.length; i++){
                
                opts.push({ value: listObjectJson[i].code, label: listObjectJson[i].label})            
        }
        console.log(opts)
        let code = cmp.find("mySelect").get("v.value");
        console.log(code)
        const found = opts.filter(data => data.value == code)
        const result = found.length != 0 ? found[0].label : ""
        console.log(result)
        cmp.set("v.selectedLabel", result);
    }
})