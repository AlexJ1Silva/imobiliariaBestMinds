public with sharing class ComissaoBO{

    private static ComissaoBO instance = new ComissaoBO();

    public static ComissaoBO getInstance(){
        return instance;
    }

    public void attStatusComissao(List<PropostaCompra__c> lstPropsta){

        //proposta de compra onde o status esteja como finalizada o
        //Status da comissão vai para Paga e e status do ímovel vai para Vendido
        List<Imovel__c> attImoveisStatus = new List<Imovel__c>();

        set<id> propostaListid = new set<id>();

        for(PropostaCompra__c p : lstPropsta){
            if(p.Status__c == 'Finalizada'){
                propostaListid.add(p.Id);
                Imovel__c i = new Imovel__c();
                i.Id = p.Imovel__c;
                i.Status__c = 'Vendido';
                attImoveisStatus.add(i);
            }
        }

        Database.update(attImoveisStatus);

        List<Comissao__c> listComissao = ComissaoDAO.getPropostaCompraIdList(propostaListid);

        if(listComissao.size() >0){
            for(Comissao__c c : listComissao){
                c.Status__c = 'Paga';
            }
        }


        Database.update(listComissao);
    }

}