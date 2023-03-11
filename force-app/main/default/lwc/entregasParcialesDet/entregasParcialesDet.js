import { LightningElement, track } from 'lwc';

export default class EntregasParcialesDet extends LightningElement {
    deliveryid;
    @track currentScreen;
    @track firstDelivery= [
        {
          "sku": this.deliveryid,
          "fecha_entrega": "2023-03-07T00:00:00",
          "cantidad": 1,
          "es_obsequio": false,
          "padre": null
        },
        {
          "sku": "7022723",
          "fecha_entrega": "2023-03-07T00:00:00",
          "cantidad": 1,
          "es_obsequio": false,
          "padre": null
        },
        {
          "sku": "7015153",
          "fecha_entrega": "2023-03-31T00:00:00",
          "cantidad": 1,
          "es_obsequio": false,
          "padre": null
        }
      ];
    @track secondDelivery= [
        {
          "sku": "7015153",
          "fecha_entrega": "2023-03-31T00:00:00",
          "cantidad": 1,
          "es_obsequio": false,
          "padre": null
        }
      ];


    get showScreen1() {
        if(this.deliveryid){
            this.currentScreen = 1;
        }
        return this.currentScreen === 1;
    }

    
}