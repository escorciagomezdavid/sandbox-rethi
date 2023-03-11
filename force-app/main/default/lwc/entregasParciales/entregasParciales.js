import { LightningElement, track } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class EntregasParciales extends NavigationMixin(LightningElement)  {
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

    showDetail(event) {
        console.log(event);
        // const deliveryId = event.target.delivery.id; // Get the delivery id from the event
        console.log('deliveryId');
        // console.log(deliveryId);
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'entregasParcialesDet' // Name of the lightning web component to navigate to 
            }
        });  
    }
}