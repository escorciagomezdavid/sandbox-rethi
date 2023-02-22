({
    loadOptions: function (component, event, helper) {
        var mes = component.get('v.message')
        var separator = mes.split(';')
        var opts = []
        for(var i = 0; i<separator.length; i++){
                
                opts.push({ value: separator[i], label: separator[i]})            
        }
        console.log(opts)        
        component.set("v.options", opts);
        component.find("mySelect").get("v.value");

    }
})