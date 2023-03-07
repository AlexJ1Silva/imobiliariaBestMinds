public with sharing class PropostaCompraDAO {
    public static List<PropostaCompra__c> getPropostaCompraIdList(set<Id> propostaId){
        return [SELECT id, Status__c FROM PropostaCompra__c WHERE id  IN: propostaId];
    }

    public static PropostaCompra__c getPropostaCompra(String recordId){

        return [SELECT LastModifiedDate, Valor__c, Name, Contact__r.Name, Imovel__r.Name, Vendedor__r.Name, 
                Imovel__r.RecordType.Name, Imovel__r.Metragem__c, Imovel__r.ValorBase__c , Imovel__r.id,Contact__r.Id,
                (SELECT id, Percentual__c, 	Valor__c, Name FROM Comissoes__r)
                FROM PropostaCompra__c                       
                WHERE Id =:recordId
                LIMIT 1];

    }
}