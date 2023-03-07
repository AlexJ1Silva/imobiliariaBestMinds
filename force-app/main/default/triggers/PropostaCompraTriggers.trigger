trigger PropostaCompraTriggers on PropostaCompra__c (before insert, after update, after insert, before update) {

    
    if(Trigger.isUpdate && Trigger.isAfter){
        ComissaoBO.getInstance().attStatusComissao(Trigger.new);
    }


    if(Trigger.isUpdate && Trigger.isAfter){
        PropostaCompraBO.getInstance().criaComissaoPropostaStatusAgPagamento(Trigger.new);

    }
    if(Trigger.isUpdate && Trigger.isBefore){
        PropostaCompraBO.getInstance().preencheDataEntregaChaves(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isBefore){
        PropostaCompraBO.getInstance().preencheDataEntregaChaves(Trigger.new);
    }
        
    
}