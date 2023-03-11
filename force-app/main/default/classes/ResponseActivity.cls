global class ResponseActivity {
	public Integer statusCode {get;set;}
    public String  message {get;set;}
    public Boolean success {get;set;}
    public List<TaskResponse> data {get;set;}
}