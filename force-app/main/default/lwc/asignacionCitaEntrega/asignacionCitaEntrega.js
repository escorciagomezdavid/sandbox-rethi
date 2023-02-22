import { LightningElement, track, wire, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import envioProductosEntrega from '@salesforce/apex/lwcCitaOp.envioProductosEntrega';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import Listo_a_Factruar__c from '@salesforce/schema/Opportunity.Listo_a_Factruar__c';
import CEmpresa__c from '@salesforce/schema/Opportunity.CEmpresa__c';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

const fields = [Listo_a_Factruar__c, CEmpresa__c]

const dates = ["2023-03-13", "2023-02-28"];
let datesSelected = "";
let listoFact = false;

// Get today's date
const today = new Date();

// Get the current month and year
let currentMonth = today.getMonth();
let currentYear = today.getFullYear();


export default class AsignacionCitaEntrega extends LightningElement {
    @track currentScreen = 1;

    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields }) opportunity;

    @wire(CurrentPageReference) pageRef;
    get currentPageReference() {
        console.log("PaginaRef: " + JSON.stringify(this.pageRef.attributes));
        return this.pageRef.attributes.recordId;
    }

    listoFacturar() {
        listoFact = getFieldValue(this.opportunity.data, Listo_a_Factruar__c);
        console.log("Listo a facturar: " + listoFact);
        return listoFact;
    }

    envioProductosEntrega() {
        envioProductosEntrega({
            idOp: this.pageRef.attributes.recordId
        })
            .then(result => {
                console.log(result);
                if (result == 'Success') {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success!',
                        message: 'File Upload Success',
                        variant: 'success'
                    }));
                } else {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'False!',
                        message: result,
                        variant: 'destructive'
                    }));
                }
            })
            .catch(error => {
                console.error('Error: ', error);
            });
    }

    renderCalendar() {
        // Get reference to the calendar header
        const calendarHeader = this.template.querySelector(".month-year");
        console.log("CalendarHeader: " + calendarHeader)

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
                    if (dates.includes(currentDate)) {
                        cell.style.border = "solid";
                        cell.style.borderColor = "#6f9cef";
                        cell.style.fontWeight = 'bold';
                        cell.style.cursor = 'pointer';
                        // eslint-disable-next-line no-loop-func
                        cell.addEventListener('click', () => {
                            datesSelected = `${currentYear}-${("0" + (currentMonth + 1)).slice(-2)}-${("0" + (cell.textContent)).slice(-2)}`;
                            console.log(datesSelected);
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

    get showScreen1() {
        return this.currentScreen === 1;
    }

    get showScreen2() {
        this.listoFacturar();
        return this.currentScreen === 2;
    }

    get showScreen3() {
        return this.currentScreen === 3;
    }

    get showScreen4() {
        return this.currentScreen === 4;
    }

    get showScreen5() {
        return this.currentScreen === 5;
    }

    get showScreen6() {
        return this.currentScreen === 6;
    }

    get showScreenError() {
        return this.currentScreen === 7;
    }

    nextScreen() {
        this.currentScreen += 1;
        if (this.currentScreen === 2) {
            if (listoFact) {
                console.log("Si está listo a Facturar");
                this.currentScreen = 2;
            } else {
                this.currentScreen = 7;
                console.log("NO está listo a Facturar");
                // this.template.querySelector('.lc-listo-facturar-false').style.display = 'block';
            }

        }
    }

    closeModal() {
        this.currentScreen = 1;
    }

    refreshPage() {
        // eslint-disable-next-line no-restricted-globals
        location.reload();
    }

    prevMonth() {
        console.log("Hola Mundo Desde prevMonth");
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        this.renderCalendar();
    }

    nextMonth() {
        console.log("Hola Mundo Desde nextMonth");
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        this.renderCalendar();
    }

}