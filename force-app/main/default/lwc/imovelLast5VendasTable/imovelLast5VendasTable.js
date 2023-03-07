import { LightningElement, api , track } from 'lwc';

import ultimas5VendasImovelCLS from '@salesforce/apex/ImovelController.ultimas5VendasImovel';

export default class ImovelLast5VendasTable extends LightningElement {

    ultimas5VendasList = [];

    showTable = false;

    temDados = false;

    naoTemDados = false;

    showSpinner = true;

    


    @api imovelTO;


    /* formatNumber(n) {
        // format number 1000000 to 1,234,567
        return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
      } */

    
    connectedCallback() {

        console.log(this.recordId);
        ultimas5VendasImovelCLS({ lstImovelTO: this.imovelTO }).then(r => {

            console.log(r);
            //const formatNumber = new Intl.NumberFormat()

            if (r.length > 0) {
               
                r.forEach(e => {
                    e.url = 'https://everymind-1e8-dev-ed.develop.lightning.force.com/lightning/r/Imovel__c/'+e.id+'/view';
                    e.cliente = 'https://everymind-1e8-dev-ed.develop.lightning.force.com/lightning/r/Contact/'+e.idCliente+'/view'
                    //e.Valor__c = this.formatNumber(e.Valor__c);
                   
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