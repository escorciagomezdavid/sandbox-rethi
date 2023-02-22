import { LightningElement, api } from 'lwc';
import processAdviserCredit from '@salesforce/apex/AssignmentAdviserCredit.processAdviserCredit';
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class jamarTakeOpAdviserCredit extends LightningElement {

    @api recordId;
    response;
    error;


    handleSuccess(message) {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: message,
                variant: 'success'
            })
        );
    }

    handleFail(message) {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Warning',
                message: message,
                variant: 'warning'
            })
        );
    }

    async handleSearch() {
        await processAdviserCredit({ idOportunity: this.recordId })
            .then((result) => {
                console.log('result processAdviserCredit')
                this.response = result;
                this.error = undefined;
            })
            .catch((error) => {
                console.log('error processAdviserCredit')
                this.error = error;
                this.response = undefined;
            });
    }

    @api async invoke() {
        console.log('this.recordOp')
        await this.handleSearch()
        if (this.response === " Existe Representante de Credito Asignado") {
            this.handleFail(this.response)
        } else {
            this.handleSuccess(this.response)
        }
        console.log(this.response)
        console.log(this.error)

    }
}