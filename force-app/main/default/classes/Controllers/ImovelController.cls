public with sharing class ImovelController {
    @AuraEnabled
    public static List<ImovelTO> ultimas5VendasImovel(){

        List<ImovelTO> lstImovelTO = new List<ImovelTO>();

        try{

            List<PropostaCompra__c> listaProposta = [SELECT LastModifiedDate, Valor__c, Contact__r.Name, Imovel__r.Name, Vendedor__r.Name, Imovel__r.RecordType.Name, Imovel__r.id,Contact__r.Id
                                                    FROM PropostaCompra__c                       
                                                    WHERE Status__c = 'Finalizada' 
                                                    ORDER BY LastModifiedDate DESC NULLS LAST LIMIT 5];
                                           
            for (PropostaCompra__c p : listaProposta ){
                    ImovelTO to = new ImovelTO();
                    to.id = p.Imovel__r.id;
                    to.numeroImovel = p.Imovel__r.Name;
                    to.tipoImovel = p.Imovel__r.RecordType.Name;
                    to.nomeCliente = p.Contact__r.Name;
                    to.idCliente = p.Contact__r.Id;
                    to.valorVenda = p.Valor__c;
                    to.vendedor = p.Vendedor__r.Name;
                    lstImovelTO.add(to);
                

            }

            return lstImovelTO;

        } catch (Exception e){

            throw new AuraHandledException(e.getMessage());

        }

        
    }   
}