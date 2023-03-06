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

        List<Comissao__c> listComissao = ComissaoDAO.getPropostaCompraIdList(propostaListid);
        
        Database.update(attImoveisStatus);


        if(listComissao.size() >0){
            for(Comissao__c c : listComissao){
                c.Status__c = 'Paga';
            }
        }

        Database.update(listComissao);
    }

    /* public void attStatusPropostaCompraFinalizado(List<Comissao__c> lstAttComissao){

        set<id> propostaListid = new set<id>();

        List<PropostaCompra__c> attPropostaList = new  List<PropostaCompra__c>();
        
        List<Comissao__c> listComissao = ComissaoDAO.getPropostaCompraIdList(propostaListid);

        for(Comissao__c c : lstAttComissao){
            if(c.Status__c == 'Paga'){
                propostaListid.add(c.Id);
                PropostaCompra__c p = new PropostaCompra__c();
                p.id = c.PropostaCompra__c;
                p.Status__c = 'Finalizada';
                attPropostaList.add(p);

            }
        }

        Database.update(attPropostaList);
    } */

}