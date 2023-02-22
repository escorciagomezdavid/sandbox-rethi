Global class ValidacionesDeDireccion {
 
    public class VTvariable {
        @invocablevariable(Label='Monto' required=true)
        public decimal Monto;
		
        @invocablevariable(Label='Empresa' required=true)
        public string Empresas;			
    }
	
    @InvocableMethod (label='Validaciones para direccion')
    public static  list<String> validateAmount (list<VTvariable> variables){
        list <String> Answerx = new list<String>();
		
        Decimal monto = variables[0].Monto;
		String empresa = variables[0].Empresas;
		
		//Validar monto
		if(monto!=null){
			//validaciones relacionadas al Pais
			if(empresa!=null){
				//validaciones para Colombia
				if(empresa==LABEL.EmpresaColombia){
                    Double nMonto = monto;
                    Double Minimo = Decimal.valueOf(LABEL.MontoMinimoCADColombia);
                    Double Maximo = Decimal.valueOf(LABEL.MontoMaximoCADColombia);
                    
                    //monto minimo						
                    if(nMonto<Minimo){
                        Answerx.add('Monto mínimo para cobro a domicilio Colombia es :'+Minimo);
                    }else if(nMonto>Maximo){//monto maximo	
                        Answerx.add('Monto máximo para cobro a domicilio Colombia es :'+Maximo);
                    }						
					
				}else if(empresa==LABEL.EmpresaPanama){//validaciones para Panama
                    Double nMonto = monto;
                    Double Minimo = Decimal.valueOf(LABEL.MontoMinimoCADPanama);
                    Double Maximo = Decimal.valueOf(LABEL.MontoMaximoCADPanama);
                    
                    //monto minimo						
                    if(nMonto<Minimo){
                        Answerx.add('Monto mínimo para cobro a domicilio Panamá es :'+Minimo);
                    }else if(nMonto>Maximo){//monto maximo	
                        Answerx.add('Monto máximo para cobro a domicilio Panamá es :'+Maximo);
                    }											
				}				
			}else{
				Answerx.add('Se necesita obtener el Pais/Empresa.'); 
			}
		}else{
           Answerx.add('Tiene que indicar un monto.'); 
        }
		
		if(Answerx.size()==0){
			Answerx.add('Validación Correcta');
		}
		
        return Answerx;  
    }               
}