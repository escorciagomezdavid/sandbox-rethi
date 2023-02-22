/*
Name: ResponseCase
Proposito: Campos que se mapean para la respuesta de la API.
Author: Daniela Sanchez
Fecha: 2/04/2022
*/
global class ResponseCase {
    public Integer statusCode {get;set;}
    public String  message {get;set;}
    public Boolean success {get;set;}
    public List<GarantiaResponse> data {get;set;}
}