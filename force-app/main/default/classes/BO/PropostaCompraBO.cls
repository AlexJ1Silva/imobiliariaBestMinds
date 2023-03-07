public with sharing class PropostaCompraBO{
    private static PropostaCompraBO instance = new PropostaCompraBO();
    public static PropostaCompraBO getInstance(){
        return instance;
    }

    public void criaComissaoPropostaStatusAgPagamento(List<PropostaCompra__c> lstPropostas){

        Map<String, ConfiguracaoPropostaCompra__mdt> mapCpc = new Map<String, ConfiguracaoPropostaCompra__mdt>();
        List<Comissao__c> criarComissao = new List<Comissao__c>();
        set<id> propostaListid = new set<id>();
        set<id> imovelId = new set<id>();
        Map<Id, Imovel__c> imovelMap = new Map<Id, Imovel__c>();
        //map para identificar se já existe uma comissão para essa proposta,
        //caso tenha não a comissão não será criada.
        Map<Id, Comissao__c> mapComissao = new Map<Id, Comissao__c>();

        for (ConfiguracaoPropostaCompra__mdt cpc : [SELECT id, Tipo__c, PercentualComissao__c, Label
                                                    FROM ConfiguracaoPropostaCompra__mdt]){
            mapCpc.put(cpc.Label, cpc);
        }

        for (PropostaCompra__c p : lstPropostas){
            imovelId.add(p.Imovel__c);
            propostaListid.add(p.Id);
        }

        for (Imovel__c i : ImovelDAO.getPropostaCompraIdList(imovelId)){
            imovelMap.put(i.Id, i);

        }

        for (Comissao__c c : ComissaoDAO.getPropostaCompraIdList(propostaListid)){
            mapComissao.put(c.PropostaCompra__C, c);
        }

        for (PropostaCompra__c p : lstPropostas){
            //valida se ja existe comissão para essa proposta.
            if (mapComissao.containsKey(p.id)){

                continue;
            }
            //System.debug('#######################' + p.Status__c);
            if (p.Status__c == 'Aguardando pagamento'){
                Comissao__c c = new Comissao__c();
                c.OwnerId = p.Vendedor__c;
                c.PropostaCompra__c = p.Id;
                //System.debug(p.Imovel__r.RecordType.Name);
                //pegando o nome do tipo do registro do imovel
                String rtNameImovel = imovelMap.get(p.Imovel__c).RecordType.Name;
                //pegrando o tipo de percentual de comissão para o tipo de registro do imovel
                Decimal porcentagem = mapCpc.get(rtNameImovel).PercentualComissao__c;
                //System.debug(porcentagem);
                c.Valor__c = (p.Valor__c * porcentagem) / 100;
                c.Status__c = 'Em pagamento';

                criarComissao.add(c);
                // System.debug('############LISTA COMISSÃO##############');
                //System.debug(c);
            }
        }
        //System.debug('#############Lista COmissoes#############');
        //System.debug(criarComissao);
        Database.insert (criarComissao);
    }

    public void preencheDataEntregaChaves(List<PropostaCompra__c> lstPropostas){
        set<id> imovelId = new set<id>();
        set<id> propostaListid = new set<id>();
        Map<Id, Imovel__c> imovelMap = new Map<Id, Imovel__c>();
        Map<String, ConfiguracaoPropostaCompra__mdt> mapCpcTipoImovel = new Map<String, ConfiguracaoPropostaCompra__mdt>();
        for (ConfiguracaoPropostaCompra__mdt cpc : [SELECT id, Tipo__c, PercentualComissao__c, Label, DiasEntregaChavesMetadata__c
                                                    FROM ConfiguracaoPropostaCompra__mdt]){
            mapCpcTipoImovel.put(cpc.Label, cpc);
        }

        for (PropostaCompra__c p : lstPropostas){
            imovelId.add(p.Imovel__c);
            propostaListid.add(p.Id);
        }

        for (Imovel__c i : ImovelDAO.getPropostaCompraIdList(imovelId)){
            imovelMap.put(i.Id, i);
        }
        for (PropostaCompra__c p : lstPropostas){

            if (p.Status__c == 'Finalizada'){
                String tipo = imovelMap.get(p.Imovel__c).RecordType.Name;
                //System.debug('###>>>>> TIPO');
                //System.debug(tipo);
                Integer prazo = (Integer) mapCpcTipoImovel.get(tipo).DiasEntregaChavesMetadata__c;
                //System.debug('####>>>>>>PRAZO');
                //System.debug(prazo);
                p.DataEntregaChaves__c = System.today() + prazo;
            }
        }
    }

    public void reprovaPropostaMaisDe40Dias(List<PropostaCompra__c> propostaList){

        for(PropostaCompra__c p : propostaList){
           
                p.Status__c = 'Reprovada';
          
            
        }
        //System.debug('###>>>>>>LISTA');
        //System.debug(propostaList);
        Database.update(propostaList);
    }
}