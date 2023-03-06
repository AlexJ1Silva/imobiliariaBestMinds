trigger PropostaCompraTriggers on PropostaCompra__c (before insert, after update, after insert) {

    
    if(Trigger.isUpdate && Trigger.isAfter){
        ComissaoBO.getInstance().attStatusComissao(Trigger.new);
    }


    if(Trigger.isUpdate && Trigger.isAfter){
        PropostaCompraBO.getInstance().criaComissaoPropostaStatusAgPagamento(Trigger.new);

    }
   /*  else if(Trigger.isInsert && Trigger.isAfter){
        PropostaCompraBO.getInstance().criaComissaoPropostaStatusAgPagamento(Trigger.new);

    } */
}