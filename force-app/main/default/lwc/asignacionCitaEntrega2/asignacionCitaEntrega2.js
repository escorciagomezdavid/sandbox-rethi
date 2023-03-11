import { LightningElement, track, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

import calendarioCitasEntrega from '@salesforce/apex/lwcCitaOp.calendarioCitasEntrega';

import IDOP_FIELD from '@salesforce/schema/Opportunity.IdOP__c';


export default class AsignacionCitaEntrega2 extends LightningElement {
    @api recordId;
    idOp;

    @wire(getRecord, { recordId: '$recordId', fields: [IDOP_FIELD] })
    opportunity;//--- Aqui deben de estar todos los campos de la Opp que se hayan importado arriba

    // if(opportunity) {
    //     console.log('opp');
    //     console.log(opportunity);
    //     this.idOp = getFieldValue(this.opportunity.data, IDOP_FIELD);
    //     console.log('idOp');
    //     console.log(this.idOp);
    // }

    @track currentScreen = 1;
    @track deliveries = [
        {
            "id": "001",
            "desc": "Opcion 1",
            "delivery_date_1": "2023-03-31",
            "delivery_date_2": null
        },
        {
            "id": "002",
            "desc": "Opcion 2",
            "delivery_date_1": "2023-03-13",
            "delivery_date_2": "2023-03-20"
        },
        {
            "id": "002",
            "desc": "Opcion 3",
            "delivery_date_1": "2023-03-14",
            "delivery_date_2": "2023-03-22"
        }
    ];

    get showScreen1() {

        if (this.opportunity.data) {
            this.idOp = getFieldValue(this.opportunity.data, IDOP_FIELD);
            console.log('idOp');
            console.log(this.idOp);
            this.getCalendarioCitasEntega();
        }

        return this.currentScreen === 1;

    }

    getCalendarioCitasEntega(){
        calendarioCitasEntrega({
            idOp: this.idOp
        })
            .then(result => {
                console.log(`result:`);
                console.log(result);
                if(result){
                    if(result.mensaje=== 'NO APLICA'){
                        console.log('No aplica');
                    }
                }
            })
            .catch(error => {
                this.error = error;
            });
    }

}