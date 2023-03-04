public with sharing class ImovelDAO {
    public static List<Imovel__c> getPropostaCompraIdList(set<Id> imovelId){
        return [SELECT id, RecordType.Name FROM Imovel__c WHERE id  IN: imovelId];
    }
}