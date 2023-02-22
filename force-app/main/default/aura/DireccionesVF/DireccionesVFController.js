({
    doInit : function(component) {
        var vfOrigin = "https://" + component.get("v.vfHost");
        window.addEventListener("message", $A.getCallback(function(event) {
            if (event.origin !== vfOrigin) {
                // Not the expected origin: Reject the message!
                return;
            }
            console.log("El pais es : " +event.data.idPais);
            console.log("El Depto es :"+event.data.idDepartamento);
            // Handle the message            
            //var cstring = "hola hola prro :v";
            component.set("v.VfPais", event.data.idPais);
            component.set("v.VfDepartamento", event.data.idDepartamento);
            
        }), false);
    }
})