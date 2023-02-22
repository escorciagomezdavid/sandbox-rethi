import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class DisplayImageS3Carrousel extends LightningElement {

    @api recordId;
    @track record;
    @track error;
    @track photos_arr = [];

    @wire(getRecord, { recordId: '$recordId', fields: ['Case.CaseNumber', 'Case.Images__c'] })
    wiredCase({ error, data }) {
        if (data) {
            this.record = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }
    get name() {
        return this.record.fields.CaseNumber.value;
    }
    get images(){
        return this.record.fields.Images__c.value;
    }
    get photos(){
        let varImages = this.images
        if(varImages !== undefined && varImages !== ''){
            let array_images  = varImages.split(';')
            return array_images
        }
        return null
    }
    
}