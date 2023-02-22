Global class ValidacionesdeTelefono {
 
    public class VTvariable {
        @invocablevariable(Label='Telefono' required=true)
        public string Telefonos;
		
        @invocablevariable(Label='Empresa' required=true)
        public string Empresas;	

        @invocablevariable(Label='TipoTelefono' required=true)
        public string TipoTelefono;			
    }
       @InvocableMethod (label='Validaciones para telefono')
    public static  list<String> validatePhone (list<VTvariable> variables){  
        list <String> Answerx = new list<String>();
		
        String telefono = variables[0].Telefonos;
		String empresa = variables[0].Empresas;
		String tipo = variables[0].TipoTelefono;
		
        /**Boolean isnumeric = telefono.isNumeric();
        if(isnumeric == True)
        {
            Answerx.add('Es Numerico');
        }else{
            Answerx.add('No se que show');
        }**/
		
		//Validar Telefono
		if(telefono!=null){
			//no deben iniciar en 0,1,2
			if(telefono.startsWith('0') || telefono.startsWith('1') || telefono.startsWith('2')){
				Answerx.add('Los números de teléfono no pueden iniciar en 0,1,2 .');
			}else if(!telefono.isNumeric()){//El número de teléfono no debe contener caracteres especiales
				Answerx.add('El número de teléfono no debe contener caracteres especiales.');
			}else if(empresa!=null){//validaciones relacionadas al Pais
				//validaciones para Celulares
				if(tipo=='Móvil'){
					//Celular debe tener 8 caracteres en Panamá
					if(empresa==LABEL.EmpresaPanama){
						if(telefono.length()!=8){
							Answerx.add('Celular debe tener 8 caracteres en Panamá');
						}
					}else if(empresa==LABEL.EmpresaColombia){//Celular debe tener 10 caracteres en Colombia
						if(telefono.length()!=10){
							Answerx.add('Celular debe tener 10 caracteres en Colombia');
						}					
					}	
				}else if(tipo=='Fijo'){//validaciones para telefono fijo
					//Los número de teléfono fijo deben contener 7 caracteres para Panamá
					if(empresa==LABEL.EmpresaPanama){
						if(telefono.length()!=7){
							Answerx.add('Los número de teléfono fijo deben contener 7 caracteres para Panamá');
						}
					}else if(empresa==LABEL.EmpresaColombia){//Los número de teléfono fijo deben contener 7 caracteres para Colombia
						if(telefono.length()!=7){
							Answerx.add('Los número de teléfono fijo deben contener 7 caracteres para Colombia');
						}					
					}					
				}
			}else{
				Answerx.add('Se necesita obtener el Pais/Empresa.'); 
			}
		}else{
           Answerx.add('El número de teléfono no puede estar vacio.'); 
        }
		
		if(Answerx.size()==0){
			Answerx.add('Validación Correcta');
		}
		
        return Answerx;  
    }               
}