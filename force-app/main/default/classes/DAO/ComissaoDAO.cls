public with sharing class ComissaoDAO {
    public static List<Comissao__c> getPropostaCompraIdList(set<Id> comissaoId){
        return [SELECT id, Status__c, PropostaCompra__c FROM Comissao__c WHERE PropostaCompra__c  IN: comissaoId];
    }
}