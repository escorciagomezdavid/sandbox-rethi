/*
Name: ResponseTrackingCase
Proposito: Campos que se mapean para la respuesta de la API.
Author: Daniela Sanchez
Fecha: 6/05/2022
*/
global class ResponseTrackingCase {
    public Integer statusCode {get;set;}
    public String  message {get;set;}
    public Boolean success {get;set;}
    public List<TrackingCase> data {get;set;}
}