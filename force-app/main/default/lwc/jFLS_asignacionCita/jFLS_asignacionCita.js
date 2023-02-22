import { LightningElement, api } from 'lwc';
import validacionPartidas from '@salesforce/apex/JFLS_asignacionCita_ctr.validacionPartidas';
import generacionCita from '@salesforce/apex/JFLS_asignacionCita_ctr.generacionCita';
import agendarCita from '@salesforce/apex/JFLS_asignacionCita_ctr.agendarCita';
import datosHorario from '@salesforce/apex/JFLS_asignacionCita_ctr.datosHorario';
export default class JFLS_asignacionCita extends LightningElement {

    @api recordId;

    horario;
    cita;
    isLoading = false;
    checkboxVal = false;
    handleChange() {
        if(this.checkboxVal == false){
            this.checkboxVal = true;
        }else{
            this.checkboxVal= false;
        }
    }
    validacionPartidas(){
        this.isLoading = true;
        validacionPartidas({RecordId: this.recordId})
        .then((Result) =>{
            if(Result>=1){
                console.log('Adelante');
                this.obtenerHorario();
                //this.callingGeneracionCita();
            }
        })
        .catch((error)=>{
            this.error = error;
        });
    }

    obtenerHorario(){
        datosHorario()
        .then((Result)=>{
            this.horario= Result;
            this.callingGeneracionCita(this.horario);
        });
    }

    callingGeneracionCita(horario){
        generacionCita({RecordId: this.recordId, horas: horario})
        .then((Result)=>{
            this.cita = Result;
            console.log(this.cita);
            setTimeout(this.callingAgendarCita(this.cita),1000);
            //this.agendarCita(this.cita);
        })
        .catch((error)=>{
            this.error = error;
        });
        
    }

    callingAgendarCita(cita){
        agendarCita({citaId: cita})
        .then(()=>{
            this.updateRecordView();
        })
        .catch((error)=>{
            this.error = error;
        });
    }
    
    updateRecordView() {
        this.isLoading = false;
        eval("$A.get('e.force:refreshView').fire();");
     }
}