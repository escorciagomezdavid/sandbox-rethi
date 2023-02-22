import { LightningElement, api , track} from 'lwc';
import saveFile from '@salesforce/apex/lwcFileUpload.saveFile';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const MAX_FILE_SIZE = 4500000;
const CHUNK_SIZE = 750000;

export default class UploadFieldsS3 extends LightningElement {

    @api recordId;
    @track filesUploaded = [];
    isLoading = false;


    handleFilesChange(event) {
        if (event.target.files.length > 0) {
            let files = [];
            for(var i=0; i< event.target.files.length; i++){
                let file = event.target.files[i];
                let reader = new FileReader();
                reader.onload = e => {
                    let fileContents = reader.result;
                    console.log(fileContents);
                    this.filesUploaded.push({Title: file.name, base64: fileContents});
                };
                reader.readAsDataURL(file);
            }
            console.log('record handle ');
            console.log(this.recordId);
        }
    }

    saveFile(event){
        saveFile({
            idrecord: this.recordId,
            files:    this.filesUploaded
        })
        .then(result => {
            if(result == 'Success') {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: 'File Upload Success',
                    variant: 'success'
                }));
                           
            }else{
                this.dispatchEvent(new ShowToastEvent({
                    title: 'false!',
                    message: result,
                    variant: 'destructive'
                }));
            }
        })
        .catch(error => {
            console.error('Error: ', error);
        });

        
    }
}