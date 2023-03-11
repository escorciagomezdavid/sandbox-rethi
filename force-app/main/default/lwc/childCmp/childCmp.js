import { LightningElement } from 'lwc';

export default class ChildCmp extends LightningElement {
    searchKey;
    handleChange(event){
        this.searchKey = event.target.value;
        console.log(`Event 7: `);
        console.log(this.searchKey);

        //create event
        const searchEvent = new CustomEvent("getsearchvalue", {
            detail: this.searchKey
        });

        //Dispatches the event
        this.dispatchEvent(searchEvent);
    }
}