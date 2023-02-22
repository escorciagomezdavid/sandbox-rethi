({
    loadOptions: function (component, event, helper) {
        let inputVariable = component.get('v.message')
        console.log('json response')
        console.log(inputVariable)
        let objectJson = JSON.parse(inputVariable)
        console.log('json response')
        console.log(objectJson)
        if (objectJson.ps_nuCodError || objectJson.ps_vcMensError){
            component.set("v.error", objectJson.ps_vcMensError);
        }else {
            let data = objectJson.ps_responseClob.data;
            let cupo_max = `${data.cupo_max}`
            let cuotasugmax = `${data.cuotasugmax}`
            let accsug_credito = `${data.accsug_credito}`
            let accsug_tj = `${data.accsug_tj}`
            let desc_accsugcr = `${data.desc_accsugcr}`
            let desc_accsugtj = `${data.desc_accsugtj}`

            console.log('nuevos cambios')
            console.log(desc_accsugtj);
            component.set("v.cupo_max", "Cupo Maximo del Cliente: " + cupo_max);
            component.set("v.cuotasugmax", "Cuota sugerida Maxima: " + cuotasugmax);
            component.set("v.accsug_tj", "Accion Sugerida TJ: " + accsug_tj);
            component.set("v.accsug_credito", "Accion Sugerida Credito: " + accsug_credito);
            component.set("v.desc_accsugcr", "Descripcion Accion sugerida Credito: " + desc_accsugcr);
            component.set("v.desc_accsugtj", "Descripcion Accion sugerida TJ: " + desc_accsugtj);

            console.log(objectJson); 
        } 

          
    }
})