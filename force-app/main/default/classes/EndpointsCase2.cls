/*
Name: EndPointsCase
Proposito: Endpoints a consultar del API
Author: Daniela Sanchez
Fecha: 19/04/2022
*/
@RestResource(UrlMapping='/v2/Case/')
global class EndpointsCase2 {
    @HttpPost
    global static ResponseCase crearCaso() {
        ResponseCase rc = new ResponseCase();
        middlwareCase Middlware = new middlwareCase();
        String jsonInput = '';
        try{
            RestRequest requestBody = RestContext.request;
            jsonInput = requestBody.requestBody.toString();
            Middlware = (middlwareCase)JSON.deserialize(jsonInput, middlwareCase.class);
            if(Middlware.Caso != null){
                Boolean clienteExiste= CaseClass.ValidacionCliente(Middlware.Caso.identificacion);
                if(clienteExiste == true){              
                    List<GarantiaResponse> cases = CaseClass.CrearCaso(Middlware);
                    rc.message = 'Exitoso';
                    rc.statusCode = 200;
                    rc.success = True;
                    rc.data = cases;                                
                    return rc; 
                }else{
                    rc.message = 'No existe cliente.';
                    rc.statusCode = 200;
                    rc.success = True;
                    return rc;
                }                
            }else{
                rc.message = 'Error procesando el body.';
                rc.statusCode = 400;
                rc.success = False;
                return rc;
            }
        }catch(Exception e){
            rc.message = 'Fallo en la peticion.';
            rc.statusCode = 400;
            rc.success = False;
            return rc;
        }
        //return null;
    }
}