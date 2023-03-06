import { LightningElement, api , track } from 'lwc';

import ultimas5VendasImovelCLS from '@salesforce/apex/ImovelController.ultimas5VendasImovel';

export default class ImovelLast5VendasTable extends LightningElement {

    ultimas5VendasList = [];

    showTable = false;

    temDados = false;

    naoTemDados = false;

    showSpinner = true;

    @api imovelTO;


    connectedCallback() {

        console.log(this.recordId);
        ultimas5VendasImovelCLS({ lstImovelTO: this.imovelTO }).then(r => {

            console.log(r);

            if (r.length > 0) {
               
                r.forEach(e => {
                    e.url = 'https://everymind-1e8-dev-ed.develop.lightning.force.com/lightning/r/Imovel__c/'+e.id+'/view';
                    e.cliente = 'https://everymind-1e8-dev-ed.develop.lightning.force.com/lightning/r/Contact/'+e.idCliente+'/view'
                });
                this. ultimas5VendasList = r;
                this.temDados = true;
                this.showSpinner = false; 
                this.showTable = true;
               
            }else{
                    this.naoTemDados= true;
                    this.showSpinner = false;
                }  
        })
    }
}