import { LightningElement, track, wire, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import envioProductosEntrega from '@salesforce/apex/lwcCitaOp.envioProductosEntrega';
import calendarioCitasEntrega from '@salesforce/apex/lwcCitaOp.calendarioCitasEntrega';
import asignacionCitaEntregaOp from '@salesforce/apex/lwcCitaOp.asignacionCitaEntregaOp';
import calendarioArmado from '@salesforce/apex/lwcCitaOp.calendarioArmado';
import asignacionArmado from '@salesforce/apex/lwcCitaOp.AsignacionArmado';
import aplicaArmado from '@salesforce/apex/lwcCitaOp.aplicaArmado';
import Id from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

/* Metodos de prueba de la clase de pruebas */
// import asignacionCitaEntregaOp from '@salesforce/apex/TestsClass.asignacionCitaEntregaOp';
// import aplicaArmado from '@salesforce/apex/TestsClass.aplicaArmado';
// import asignacionArmado from '@salesforce/apex/TestsClass.AsignacionArmado';
// import calendarioCitasEntrega from '@salesforce/apex/TestsClass.calendarioCitasEntrega';
// import calendarioArmado from '@salesforce/apex/TestsClass.calendarioArmado';






import Listo_a_Factruar__c from '@salesforce/schema/Opportunity.Listo_a_Factruar__c';
import FechaEntrega__c from '@salesforce/schema/Opportunity.FechaEntrega__c';
import CEmpresa__c from '@salesforce/schema/Opportunity.CEmpresa__c';

import IDOP_FIELD from '@salesforce/schema/Opportunity.IdOP__c';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

const fields = [Listo_a_Factruar__c, CEmpresa__c, IDOP_FIELD, FechaEntrega__c]

let datesEntrega = [];
let datesArmado = [];
// let datesSelected = "";
// let datesSelectedArmado = "";
let listoFact = false;
let tieneFechaEntrega = false;
let numeroMes = 1;
let codPais = '';
let tecnico = '';
let codRecurso = '';

// Get today's date
const today = new Date();

// Get the current month and year
let currentMonth = today.getMonth();
let currentYear = today.getFullYear();

// Get today's date
const todayArmado = new Date();

// Get the current month and year
let currentMonthArmado = todayArmado.getMonth();
let currentYearArmado = todayArmado.getFullYear();


export default class AsignacionCitaEntrega extends LightningElement {
    @track currentScreen = 1;
    @track products;
    @track datesSelected;
    @track datesSelectedArmado;
    @track error;
    @track userId = Id;
    @track isReasignacion = false;
    // @track datesEntrega;

    @api recordId; //--- idOpp para este LWC
    @wire(getRecord, { recordId: '$recordId', fields }) opportunity;

    // @wire(CurrentPageReference) pageRef;
    // get currentPageReference() {
    //     return this.pageRef.attributes.recordId;
    // }

    initialLoad() {
        var result;
        if (this.currentScreen === 1) {
            result = this.loadCitasEntrega();
            console.log(result);
            if(result){
                console.log('result 84');
                console.log(result);
                this.currentScreen = 3;
            }
            // this.nextScreen();
            // this.renderCalendar();
        }
    }

    connectedCallback(){
        
    }

    listoFacturar() {
        listoFact = getFieldValue(this.opportunity.data, Listo_a_Factruar__c);
        return listoFact;
    }

    getFechaEntrega() {
        tieneFechaEntrega = getFieldValue(this.opportunity.data, FechaEntrega__c) ? true : false;
        return tieneFechaEntrega;
    }

    getNumeroMes(tuple) {
        if (tuple) {

            let firstDate = tuple[0];
            let monthNumber = parseInt(firstDate.split('-')[1], 10);
            numeroMes = Math.abs(monthNumber) - 1; //-- Se le resta uno (1) porque las funciones que cargan los calendarios comienzan desde la posicion 0 = Enero

        }
        return numeroMes;
    }

    removeTwoPoints(tuple) {
        for (let i = 0; i < tuple.length; i++) {
            tuple[i] = tuple[i].replace(':', '');
        }
        return tuple;
    }

    loadProducts() {
        envioProductosEntrega({
            idOportunidad: this.recordId
        })
            .then(result => {
                this.products = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    async loadCitasEntrega() {
        var resultOut;
        console.log('LoadCitasEntrega');
        await calendarioCitasEntrega({
            idOp: getFieldValue(this.opportunity.data, IDOP_FIELD)
        }).then(result => {
            if (result) {
                console.log(result);
                resultOut = result;
                if (result.mensaje) {
                    if (result.mensaje === "NO APLICA") { //--- Proceso NORMAL
                        datesEntrega = result.fechas;
                        currentMonth = this.getNumeroMes(result.fechas);

                    } else if (result.mensaje === "APLICA") { //--- Proceso ENTREGAS PARCIALES

                    }
                }
            }

        }).catch(error => {
            this.error = error;
        });

        return resultOut;
    }

    assignFechaEntrega() {
        if (this.datesSelected) {
            asignacionCitaEntregaOp({
                idOp: getFieldValue(this.opportunity.data, IdOP__c),
                citaEntrega: this.datesSelected,
                userOperacion: this.userId,
                reasignacion: this.isReasignacion
            }).then(result => {

                if (result === 'CITA ASIGNADA EXITOSAMENTE') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: result,
                        variant: 'success'
                    }));

                    aplicaArmado({
                        idOp: getFieldValue(this.opportunity.data, IdOP__c)
                    }).then(resultArmado => {
                        if (resultArmado === 'ARMABLE') {
                            this.nextScreen();
                        } else {
                            this.currentScreen = 4;
                            this.nextScreen();
                        }
                    })
                        .catch(error => {
                            this.error = error;
                        });

                } else if (result === 'CITA NO FUE ASIGNADA') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: result,
                        variant: 'error'
                    }));//--success, error
                }

            })
                .catch(error => {
                    this.error = error;
                });
            // this.nextScreen(); //-- Quitar esto cuando se descomente lo de arriba, xD!
        } else {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'Debe Seleccionar una Fecha de Entrega',
                variant: 'error'
            }));
        }

    }

    loadCalendarioArmado() {
        codPais = getFieldValue(this.opportunity.data, CEmpresa__c) === 'JA' ? '01' : '02'; //--codigoPais
        calendarioArmado({
            idOp: getFieldValue(this.opportunity.data, IdOP__c),
            fechaEntrega: this.datesSelected,
            pais: codPais
        }).then(result => {
            datesArmado = this.removeTwoPoints(result[0].fechas);
            currentMonthArmado = this.getNumeroMes(datesArmado);
            tecnico = result[0].tecnico; //--tecnico
            codRecurso = result[0].recurso; //--recurso
            this.renderCalendarArmado();
        })
            .catch(error => {
                this.error = error;
            });
    }

    assignFechaArmado() {
        if (codPais && this.datesSelectedArmado && tecnico && codRecurso) {
            asignacionArmado({
                idOp: getFieldValue(this.opportunity.data, IdOP__c),
                codigoPais: codPais,
                citaArmado: this.datesSelectedArmado,
                tecnico: tecnico,
                codRecurso: codRecurso,
                reasignacion: this.isReasignacion,
                userOperacion: this.userId

            })
                .then(result => {
                    if (result === 'CITA ASIGNADA EXITOSAMENTE') {
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Success',
                            message: result,
                            variant: 'success'
                        }));//--success, error
                        this.nextScreen();
                    } else if (result === 'CITA NO FUE ASIGNADA') {
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Error',
                            message: result,
                            variant: 'error'
                        }));//--success, error
                    }

                })
                .catch(error => {
                    this.error = error;
                });
            // this.nextScreen(); //-- Quitar esto cuando se descomente lo de arriba, xD!
        } else {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'Debe Seleccionar una Fecha de Armado',
                variant: 'error'
            }));
        }
    }

    renderCalendar() {

        console.log('Render calendar');
        // Get reference to the calendar header
        const calendarHeader = this.template.querySelector(".month-year");

        // Get reference to the calendar body
        const calendarBody = this.template.querySelector('.calendar-dates');

        // Get reference to the previous and next buttons
        // eslint-disable-next-line no-unused-vars
        const prevButton = this.template.querySelector('.prev-month');
        // eslint-disable-next-line no-unused-vars
        const nextButton = this.template.querySelector('.next-month');

        // Create an array of all the months
        const months = [
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Diciembre"
        ];

        // Set the calendar header
        calendarHeader.textContent = `${months[currentMonth]} ${currentYear}`;

        // Get the number of days in the current month
        const numDaysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

        // Get the first day of the month
        const firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();

        // Create a variable to keep track of the current day
        let currentDay = 1;

        // Clear the calendar body
        calendarBody.textContent = '';
        // Create the calendar rows
        for (let i = 0; i < 6; i++) {
            // Create a table row
            const row = document.createElement('tr');

            // Create the table cells
            for (let j = 0; j < 7; j++) {
                // Create a table cell
                const cell = document.createElement('td');
                cell.style.border = "none";

                // Check if the current cell should have a date
                if (i === 0 && j < firstDayOfMonth) {
                    cell.textContent = '';
                } else if (currentDay <= numDaysInMonth) {
                    cell.textContent = currentDay;
                    let currentDate = `${currentYear}-${("0" + (currentMonth + 1)).slice(-2)}-${("0" + (currentDay)).slice(-2)}`;
                    cell.style.alignContent = "center";
                    if (datesEntrega.includes(currentDate)) {
                        cell.style.border = "solid";
                        cell.style.borderColor = "#6f9cef";
                        cell.style.fontWeight = 'bold';
                        cell.style.cursor = 'pointer';
                        // eslint-disable-next-line no-loop-func
                        cell.addEventListener('click', () => {
                            this.datesSelected = `${currentYear}-${("0" + (currentMonth + 1)).slice(-2)}-${("0" + (cell.textContent)).slice(-2)}`;
                            this.dispatchEvent(new ShowToastEvent({
                                title: `${this.datesSelected}`,
                                message: `La Fecha Seleccionada es: ${this.datesSelected}`,
                                variant: 'success'
                            }));
                        });
                    } else {
                        cell.style.color = "black";
                        cell.style.opacity = "50%";
                    }
                    currentDay++;
                } else {
                    cell.textContent = '';
                }

                // Append the cell to the row
                row.appendChild(cell);

            }

            // Append the row to the calendar body
            calendarBody.appendChild(row);
        }
        return true;
    }

    renderCalendarArmado() {
        // Get reference to the calendar header
        const calendarHeaderArmado = this.template.querySelector(".month-year-armado");

        // Get reference to the calendar body
        const calendarBodyArmado = this.template.querySelector('.calendar-dates-armado');

        // Get reference to the previous and next buttons
        // eslint-disable-next-line no-unused-vars
        const prevButton = this.template.querySelector('.prev-month');
        // eslint-disable-next-line no-unused-vars
        const nextButton = this.template.querySelector('.next-month');

        // Create an array of all the monthsArmado
        const monthsArmado = [
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Diciembre"
        ];

        // Set the calendar header
        calendarHeaderArmado.textContent = `${monthsArmado[currentMonthArmado]} ${currentYearArmado}`;

        // Get the number of days in the current month
        const numDaysInMonthArmado = new Date(currentYearArmado, currentMonthArmado + 1, 0).getDate();

        // Get the first day of the month
        const firstDayOfMonthArmado = new Date(currentYearArmado, currentMonthArmado, 1).getDay();

        // Create a variable to keep track of the current day
        let currentDayArmado = 1;

        // Clear the calendar body
        calendarBodyArmado.textContent = '';

        // Create the calendar rowArmados
        for (let i = 0; i < 6; i++) {
            // Create a table rowArmado
            const rowArmado = document.createElement('tr');

            // Create the table cellArmados
            for (let j = 0; j < 7; j++) {
                // Create a table cellArmado
                const cellArmado = document.createElement('td');
                cellArmado.style.border = "none";

                // Check if the current cellArmado should have a date
                if (i === 0 && j < firstDayOfMonthArmado) {
                    cellArmado.textContent = '';
                } else if (currentDayArmado <= numDaysInMonthArmado) {
                    cellArmado.textContent = currentDayArmado;
                    let currentDateArmado = `${currentYearArmado}-${("0" + (currentMonthArmado + 1)).slice(-2)}-${("0" + (currentDayArmado)).slice(-2)}`;
                    cellArmado.style.alignContent = "center";
                    if (datesArmado.includes(currentDateArmado)) {
                        cellArmado.style.border = "solid";
                        cellArmado.style.borderColor = "#6f9cef";
                        cellArmado.style.fontWeight = 'bold';
                        cellArmado.style.cursor = 'pointer';
                        // eslint-disable-next-line no-loop-func
                        cellArmado.addEventListener('click', () => {
                            this.datesSelectedArmado = `${currentYearArmado}-${("0" + (currentMonthArmado + 1)).slice(-2)}-${("0" + (cellArmado.textContent)).slice(-2)}`;
                            this.dispatchEvent(new ShowToastEvent({
                                title: `${this.datesSelectedArmado}`,
                                message: `La Fecha Seleccionada es: ${this.datesSelectedArmado}`,
                                variant: 'success'
                            }));
                        });
                    } else {
                        cellArmado.style.color = "black";
                        cellArmado.style.opacity = "50%";
                    }
                    currentDayArmado++;
                } else {
                    cellArmado.textContent = '';
                }

                // Append the cellArmado to the rowArmado
                rowArmado.appendChild(cellArmado);

            }

            // Append the rowArmado to the calendar body
            calendarBodyArmado.appendChild(rowArmado);
        }
    }

    get spinnerInit() {
        this.initialLoad();
        return this.currentScreen === 1;
    }

    get productsOp() {
        this.listoFacturar();
        this.getFechaEntrega();
        return this.currentScreen === 2;
    }

    get calendarEntrega() {
        console.log('CalendarEntrega');
        return this.currentScreen === 3;
    }

    get calendarArmado() {
        return this.currentScreen === 4;
    }

    get resumenFinal() {
        return this.currentScreen === 5;
    }

    get errorNoListaFactu() {
        return this.currentScreen === 6;
    }

    get reasignarCita() {

        return this.currentScreen === 7;
    }

    reasignacion() {
        this.isReasignacion = true;
        this.currentScreen = 1;
        this.nextScreen();

    }

    nextScreen() {
        console.log('nextScreen');
        this.currentScreen += 1;
        if (this.currentScreen === 2) {
            if (this.isReasignacion) {
                this.loadProducts();
                this.currentScreen = 2;
            } else if (listoFact && !tieneFechaEntrega) {
                this.loadProducts();
                this.currentScreen = 2;
            } else if (listoFact && tieneFechaEntrega) {
                this.currentScreen = 7;
                //-- En esta pantalla mostraría la opcion para reasignar cita de entrega y 
                //-- colocaría la variable booleana de reasignación en true para pasar
                //-- de la pantalla de cita entrega a la de finalización
            } else {
                this.currentScreen = 6;
            }

        } else if (this.currentScreen === 3) {
            // console.log('2---');
        } else if (this.currentScreen === 4) {
            this.loadCalendarioArmado();
        }
    }

    closeModal() {
        this.isReasignacion = false; //-- Reseteo la variable para que siempre revise
        this.currentScreen = 1;
    }

    refreshPage() {
        // eslint-disable-next-line no-restricted-globals
        location.reload();
    }

    prevMonth() {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        this.renderCalendar();
    }

    nextMonth() {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        this.renderCalendar();
    }

    prevMonthArmado() {
        currentMonthArmado--;
        if (currentMonthArmado < 0) {
            currentMonthArmado = 11;
            currentYearArmado--;
        }
        this.renderCalendarArmado();
    }

    nextMonthArmado() {
        currentMonthArmado++;
        if (currentMonthArmado > 11) {
            currentMonthArmado = 0;
            currentYearArmado++;
        }
        this.renderCalendarArmado();
    }

}