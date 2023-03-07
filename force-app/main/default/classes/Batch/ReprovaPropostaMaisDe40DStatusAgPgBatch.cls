public with sharing class ReprovaPropostaMaisDe40DStatusAgPgBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){

        Date data = System.today() - 40;
        return Database.getQueryLocator([SELECT Id,  Status__c, Data__c
                                         FROM PropostaCompra__c
                                        WHERE Status__c = 'Aguardando pagamento'
                                         AND Data__c < :data]);
    }

    public  void execute(Database.BatchableContext bc, List<PropostaCompra__c> propostaList){


        PropostaCompraBO.getInstance().reprovaPropostaMaisDe40Dias(propostaList);
    }

    public void finish(Database.BatchableContext bc){
    }
   
}