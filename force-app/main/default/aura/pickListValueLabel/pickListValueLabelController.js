({
    loadOptions: function (component, event, helper) {
        var mes = component.get('v.message')
        var mes2 = component.get('v.message2')
        var separator = mes.split(';')
        var separator2 = mes2.split(';')
        var opts = []
        for(var i = 0; i<separator.length; i++){
                
                opts.push({ value: separator2[i], label: separator[i]})            
        }
        console.log(opts)        
        component.set("v.options", opts);
        component.find("mySelect").get("v.value");

    }
})