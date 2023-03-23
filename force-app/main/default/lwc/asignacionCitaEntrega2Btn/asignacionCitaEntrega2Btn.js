import { LightningElement, track, wire, api } from 'lwc';
import envioProductosEntrega from '@salesforce/apex/lwcCitaOp.envioProductosEntrega';
import calendarioCitasEntrega from '@salesforce/apex/lwcCitaOp.calendarioCitasEntrega';
import asignacionCitaEntregaOp from '@salesforce/apex/lwcCitaOp.asignacionCitaEntregaOp';
import calendarioArmado from '@salesforce/apex/lwcCitaOp.calendarioArmado';
import asignacionArmado from '@salesforce/apex/lwcCitaOp.AsignacionArmado';
import aplicaArmado from '@salesforce/apex/lwcCitaOp.aplicaArmado';
import Id from '@salesforce/user/Id';
import asignacionCitaEntregaParcial from '@salesforce/apex/lwcCitaOp.asignacionCitaEntregaParcial';
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
// let listoFact = false;
// let tieneFechaEntrega = false;
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

export default class AsignacionCitaEntrega2Btn extends LightningElement {
    @track currentScreen = 11; //--- Estaba el 3
    @track products;
    @track datesSelected = [];
    @track datesSelectedArmado;
    @track error;
    @track userId = Id;
    @track isReasignacion = false;
    @track deliveries;
    @track opcion;
    @track isRenderCalendar = false;
    @track isArmable = false;
    @track firstDelivery;
    @track secondDelivery = '';

    @api recordId; //--- idOpp para este LWC
    @wire(getRecord, { recordId: '$recordId', fields }) opportunity;


    listoFacturar() {
        return getFieldValue(this.opportunity.data, Listo_a_Factruar__c);
    }

    getFechaEntrega() {
        return getFieldValue(this.opportunity.data, FechaEntrega__c) ? true : false;
    }

    makeGroups(opcion, idOp){
        let arrayDeCadenas = idOp.split('_');
        let info_rem = {};
        info_rem.tienda = arrayDeCadenas[1];
        info_rem.per = arrayDeCadenas[2];
        info_rem.numop = arrayDeCadenas[3];
        let reparto = {};
        reparto.info_rem = info_rem;
        let grupos = [];

        opcion.data.forEach(element => {
            let delivery = {};
            let products = [];
            delivery.cita_entrega = element.fecha_entrega.split('-').reverse().join('-');
            element.productos.forEach(producto =>{
                let product = {};
                product.cod = producto.sku;
                product.csc = producto.csc;
                products.push(product);
            });
            delivery.productos = products;
            grupos.push(delivery);
        });
        reparto.grupos = grupos;
        reparto.actualizaop = 'S';
        return JSON.stringify(reparto);
    }

    /**
     * Esta funcion le agrega un id incremental a cada opcion de entrega
     * para poder identificar la Opcion escogida al mostrar el detalle de la misma.
     * This function takes in a JSON array and adds an id property to each object in the array.
     * @param {Array} json - The JSON array to which the id property needs to be added.
     * @returns {Array} - A new JSON array with each object having an added id property.
     */ 
    addId(json){
        var idx = 1;
        var jsonOut = []; //declare jsonOut as an array 
        // eslint-disable-next-line vars-on-top
        for (var i = 0; i < json.length; i++) {
            // eslint-disable-next-line vars-on-top
            var obj = {}; //declare obj inside for loop 
            obj.id = idx; 
            obj.data = json[i]; 
            jsonOut.push(obj); //push obj into jsonOut array 
            idx ++; 
        }
    
        return jsonOut; //add return statement 
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

    loadCitasEntrega() {
        console.log('LoadCitasEntrega');
        calendarioCitasEntrega({
            idOp: getFieldValue(this.opportunity.data, IDOP_FIELD)
        }).then(result => {
            if (result) {
                console.log('result:');
                console.log(result);
                if (result.mensaje) {
                    if (result.mensaje === "NO APLICA") { //---                 Proceso NORMAL
                        
                        console.log('NO APLICA 164');
                        console.log(result);
                        datesEntrega = result.fechas;
                        currentMonth = this.getNumeroMes(result.fechas);
                        this.isRenderCalendar = true;
                        this.currentScreen = 2;
                        this.nextScreen();

                    } else if (result.mensaje === "APLICA") { //---             Proceso ENTREGAS PARCIALES
                        
                        console.log('APLICA');

                        if(this.isReasignacion){
                            console.log('ENTREGA NORMAL');
                            console.log(result);
                            // datesEntrega = result.entregaParcial;
                            // currentMonth = this.getNumeroMes(result.fechas);
                            // this.isRenderCalendar = true;
                            this.currentScreen = 12;
                            // this.nextScreen();
                        }else{
                            console.log('ENTREGA PARCIAL');
                            result.entregaParcial = this.addId(result.entregaParcial);
                            this.deliveries = result.entregaParcial;
                            console.log(result.entregaParcial);
                            this.currentScreen = 7;
                            this.nextScreen();
                        }
                        

                    }else if (result.mensaje === "FALLO ENTREGAS PARCIALES"){
                        console.log('FALLO ENTREGAS PARCIALES');
                        this.currentScreen = 9;
                        this.nextScreen();
                    }
                }
            }

        }).catch(error => {
            this.error = error;
        });

    }

    assignFechaEntrega() {
        if (this.datesSelected && this.datesSelected.length > 0) {
            asignacionCitaEntregaOp({
                idOp: getFieldValue(this.opportunity.data, IDOP_FIELD),
                citaEntrega: this.datesSelected[0],
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
                        idOp: getFieldValue(this.opportunity.data, IDOP_FIELD)
                    }).then(resultArmado => {
                        if (resultArmado === 'ARMABLE') {
                            this.currentScreen = 3;
                            this.nextScreen();
                        } else {
                            this.currentScreen = 4;
                            this.nextScreen();
                        }
                    }).catch(error => {
                        this.error = error;
                    });

                } else if (result === 'CITA NO FUE ASIGNADA') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: result,
                        variant: 'error'
                    }));
                }

            }).catch(error => {
                this.error = error;
            });
        } else {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'Debe Seleccionar una Fecha de Entrega',
                variant: 'error'
            }));
        }

    }

    assignFechaEntregasParciales() {
        if(this.opcion.id === 1){ //---                                         Camino normal
            asignacionCitaEntregaOp({
                idOp: getFieldValue(this.opportunity.data, IDOP_FIELD),
                citaEntrega: this.opcion.data[0].fecha_entrega,
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
                        idOp: getFieldValue(this.opportunity.data, IDOP_FIELD)
                    }).then(resultArmado => {
                        if (resultArmado === 'ARMABLE') {
                            this.currentScreen = 3;
                            this.nextScreen();
                        } else {
                            this.currentScreen = 4;
                            this.nextScreen();
                        }
                    }).catch(error => {
                        this.error = error;
                    });

                } else if (result === 'CITA NO FUE ASIGNADA') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: result,
                        variant: 'error'
                    }));//--success, error
                }

            }).catch(error => {
                this.error = error;
            });
        }
        else if (this.opcion.id > 1){ //---                              Asignación Entregas Parciales
            console.log('this.opcion');
            console.log(this.opcion);
            console.log('this.makeGroups(this.opcion)');
            console.log(this.makeGroups(this.opcion, getFieldValue(this.opportunity.data, IDOP_FIELD)));
            console.log('idOp');
            console.log(getFieldValue(this.opportunity.data, IDOP_FIELD));
            console.log('usuario');
            console.log(this.userId);

            
            asignacionCitaEntregaParcial({
                idOp: getFieldValue(this.opportunity.data, IDOP_FIELD),
                grupos: this.makeGroups(this.opcion, getFieldValue(this.opportunity.data, IDOP_FIELD)),
                usuario: this.userId
            }).then(result => {
                console.log('294');
                console.log(result);
                if(result === 'Reparto guardado correctamente'){
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: result,
                        variant: 'success'
                    }));
                    this.opcion.data.forEach(element =>{
                        this.datesSelected.push(element.fecha_entrega);
                    });

                    aplicaArmado({
                        idOp: getFieldValue(this.opportunity.data, IDOP_FIELD)
                    }).then(resultArmado => {
                        if (resultArmado === 'ARMABLE') {
                            this.isArmable = true;
                        }
                    }).catch(error => {
                        this.error = error;
                    });

                    if(this.datesSelected.length > 0){
                        this.firstDelivery = this.datesSelected[0]
                    }
                    if(this.datesSelected.length > 1){
                        this.secondDelivery = this.datesSelected[1];
                    }
                    
                    this.currentScreen = 4;
                    this.nextScreen();
                }
            }).catch(error => {
                console.log('297');
                console.log(error);
                this.error = error;
            });
        }
    }

    loadCalendarioArmado() {
        codPais = getFieldValue(this.opportunity.data, CEmpresa__c) === 'JA' ? '01' : '02'; //--codigoPais
        console.log('370-loadCalendarioArmado');
        console.log(getFieldValue(this.opportunity.data, IDOP_FIELD));
        calendarioArmado({
            idOp: getFieldValue(this.opportunity.data, IDOP_FIELD),
            fechaEntrega: this.datesSelected[0],
            pais: codPais
        }).then(result => {
            datesArmado = this.removeTwoPoints(result[0].fechas);
            currentMonthArmado = this.getNumeroMes(datesArmado);
            tecnico = result[0].tecnico; //--tecnico
            codRecurso = result[0].recurso; //--recurso
            this.renderCalendarArmado();
        }).catch(error => {
            this.error = error;
        });
    }

    assignFechaArmado() {
        console.log('this.userId');
        console.log(this.userId);
        if (codPais && this.datesSelectedArmado && tecnico && codRecurso) {
            asignacionArmado({

                idOp: getFieldValue(this.opportunity.data, IDOP_FIELD),
                codigoPais: codPais,
                citaArmado: this.datesSelectedArmado,
                tecnico: tecnico,
                codRecurso: codRecurso,
                reasignacion: this.isReasignacion,
                usuario: this.userId

            }).then(result => {
                if (result === 'CITA ASIGNADA EXITOSAMENTE') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: result,
                        variant: 'success'
                    }));//--success, error
                    this.isRenderCalendar = false;
                    this.nextScreen();
                } else if (result === 'CITA NO FUE ASIGNADA') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: result,
                        variant: 'error'
                    }));//--success, error
                    this.isRenderCalendar = false;
                }

            }).catch(error => {
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

    showDetail(event){
        this.opcion = this.deliveries[event.target.label - 1];
        console.log('deliveries 274');
        console.log(this.opcion);
        this.currentScreen = 8;
        this.nextScreen();
    }

    get spinnerInit() {
        //--- Aqui coloco a que valide si es la pantalla 11 (this.currentScreen) 
        //--- pues es la inicial y 
        //--- no quiero que valide a menos que sea diferente de la pantalla INICIAL
        if(this.listoFacturar()=== false && this.currentScreen !== 11){
            this.currentScreen = 6;
            console.log('No está lista a FACTURAR');
        }

        if (this.currentScreen === 1) {
            this.loadCitasEntrega();
        }
        return this.currentScreen === 1;
    }

    get productsOp() {
        // this.listoFacturar();
        // this.getFechaEntrega();
        return this.currentScreen === 2;
    }

    get calendarEntrega() {
        if(this.isRenderCalendar){
            console.log(`Entró en CalendarEntrega para cargar Calendario 386: ${datesEntrega}`);
            this.renderCalendar();
            return this.currentScreen === 3;
        }
        if (this.currentScreen === 3) {
            this.loadCitasEntrega();
        }
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

    get opcionesEntrega() {
        return this.currentScreen === 8;
    }

    get detalleEntrega() {
        return this.currentScreen === 9;
    }

    get errorEntregasParciales() {
        return this.currentScreen === 10;
    }

    get showBtnInit() {
        return this.currentScreen === 11;
    }

    get reasignarCitaParciales() {
        return this.currentScreen === 12;
    }

    reasignacion() {
        this.isReasignacion = true;
        this.currentScreen = 3;
        // this.nextScreen();
    }

    // nextScreen() {
    //     console.log('nextScreen');
    //     this.currentScreen += 1;
    //     if (this.currentScreen === 2) {
    //         if (this.isReasignacion) {
    //             this.loadProducts();
    //             this.currentScreen = 2;
    //         } else if (this.listoFacturar() && !this.getFechaEntrega()) {
    //             this.loadProducts();
    //             this.currentScreen = 2;
    //         } else if (this.listoFacturar() && this.getFechaEntrega()) {
    //             this.currentScreen = 7;
    //         } else {
    //             this.currentScreen = 6;
    //         }

    //     } else if (this.currentScreen === 3) {
    //         // console.log("Renderizando Calendario...");
    //         this.renderCalendar();
    //     } else if (this.currentScreen === 4) {
    //         this.loadCalendarioArmado();
    //     } else if (this.currentScreen === 12){
    //         this.currentScreen = 3;
    //     }
    // }

    nextScreen() {
        console.log('nextScreen');
        this.currentScreen += 1;
        if(this.currentScreen === 12){
            if(this.listoFacturar()){
                if(this.getFechaEntrega()){
                    this.currentScreen = 7; //--- Muestro mensaje de reasignacion
                }else{
                    this.currentScreen = 3; //--- Valido Aplica Entregas Parciales
                }
                
            }
            
        }else if (this.currentScreen === 4){
            this.loadCalendarioArmado();
        }
    }

    prevScreen() {
        console.log('prevScreen');
        this.currentScreen -= 1;
    }

    closeModal() {
        this.isReasignacion = false; //-- Reseteo la variable para que siempre revise
        this.isRenderCalendar = false;
        this.currentScreen = 11;
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

    renderCalendar() {

        console.log('Render calendar');
        // Get reference to the calendar header
        const calendarHeader = this.template.querySelector(".month-year");

        const spinner = this.template.querySelector('lightning-spinner');
        spinner.style.visibility = 'hidden';

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
                            this.datesSelected = [];
                            this.datesSelected.push(`${currentYear}-${("0" + (currentMonth + 1)).slice(-2)}-${("0" + (cell.textContent)).slice(-2)}`);
                            this.dispatchEvent(new ShowToastEvent({
                                title: `${this.datesSelected[0]}`,
                                message: `La Fecha Seleccionada es: ${this.datesSelected[0]}`,
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
    }

    renderCalendarArmado() {
        console.log('render calendar');
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
}