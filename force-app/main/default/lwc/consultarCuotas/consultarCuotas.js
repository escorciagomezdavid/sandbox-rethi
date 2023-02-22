import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import consultarCuotas from '@salesforce/apex/ConsultarCuotasController.consultarCuotas';

const columns = [
    { label: 'Cuota', fieldName: 'NUMERO_CUOTA', type: 'number', hideDefaultActions: true, sortable: true},
    { label: 'Vencimiento',   fieldName: 'FECHA_VENCIMIENTO', hideDefaultActions: true, sortable: true, type: 'date', typeAttributes: {year: 'numeric', month: '2-digit', day: '2-digit'}},
    { label: 'Estado',   fieldName: 'ESTADO_CUOTA', hideDefaultActions: true, sortable: true},
    { label: 'Gast Cobr',   fieldName: 'GASTO_COBRANZA', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Intereses', fieldName: 'INTERESES', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Honorario',   fieldName: 'HONORARIOS', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Seguro', fieldName: 'SEGUROS', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Valor Cuota', fieldName: 'VALOR', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }}
];


const columnsCartera = [
    { label: 'Cuota', fieldName: 'NUMERO_CUOTA', type: 'number', hideDefaultActions: true },
    { label: 'Vencimiento',   fieldName: 'FECHA_VENCIMIENTO', hideDefaultActions: true, type: 'date', typeAttributes: {year: 'numeric', month: '2-digit', day: '2-digit'}},
    { label: 'Estado',   fieldName: 'ESTADO_CUOTA', hideDefaultActions: true, sortable: true},
    { label: 'Gast Cobr',   fieldName: 'GASTO_COBRANZA', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Intereses', fieldName: 'INTERESES', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Honorario',   fieldName: 'HONORARIOS', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Seguro', fieldName: 'SEGUROS', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }},
    { label: 'Valor Cuota', fieldName: 'VALOR', hideDefaultActions: true, type: 'currency', typeAttributes: { currencyCode: 'COP' }, cellAttributes: { alignment: 'right' }}
];

export default class ConsultarCuotas extends LightningElement {
    @api recordId;
    @api objeto;

    @track columns = columns;
    @track columnsCartera = columnsCartera;
    @track listCuotas;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;

    connectedCallback(){
        this.callCuotas();
    }

    callCuotas(){
        consultarCuotas({recordId : this.recordId})
        .then((result) => {
            result = JSON.parse(result);

            if (result && result.data.length > 0) {
                
                this.listCuotas = result;

            } else {

                if(result.data.length == 0) {
                    this.hasError = true;
                    this.errorMessage = "No se ha encontrado información relacionada a su consulta.";
                }

                if (result.mensaje) {
                    this.hasError = true;
                    this.errorMessage = result.mensaje;
                }

                this.listCuotas = null;
            }

            console.log('result ListCuotas');
            console.log(this.listCuotas);

            this.loaded = true;
        })
        .catch((error) => {

            console.log('error Componente');
            console.log(error);
            this.showToast('¡Atención!', 'Se produjo un error al cargar el componente por falta de datos de consulta.', 'error');
        });
        
    }

    showToast(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant

        });
        this.dispatchEvent(event);
        
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.listCuotas.data];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.listCuotas.data = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
}