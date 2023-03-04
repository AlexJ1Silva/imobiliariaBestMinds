public with sharing class PropostaCompraDAO {
    public static List<PropostaCompra__c> getPropostaCompraIdList(set<Id> propostaId){
        return [SELECT id, Status__c FROM PropostaCompra__c WHERE id  IN: propostaId];
    }
}