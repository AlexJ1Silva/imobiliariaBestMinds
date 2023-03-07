public with sharing class ComprovanteComissaoController {


      public String cidade {get; set;} 
      public String dia {get; set;}
      public String mes {get; set;}
      public String ano {get; set;} 
      public String recordId {get; set;} 

      public PropostaCompra__c pc {get; set;}

    public ComprovanteComissaoController() {

        Map<String, String> mapParamUrl = ApexPages.currentPage().getParameters();
        if(mapParamUrl.containsKey('rId')) {
            this.recordId = mapParamUrl.get('rId');
        }

        this.dia = System.now().day().format();
        this.mes = traduzirMeses(System.now().format('MMMM'));
        this.ano = System.now().year().format().replace('.', '');
        this.cidade = 'Itajaí';
        this.pc = PropostaCompraDAO.getPropostaCompra(this.recordId);
       

    }

    public static String traduzirMeses(String month){
        switch on month {
            when 'January' {
                return 'Janeiro';
            } when 'February' {
                return 'Fevereiro';
            } when 'March' {
                return 'Março';
            } when 'April' {
                return 'Abril';
            } when 'May' {
                return 'Maio';
            } when 'June' {
                return 'Junho';
            } when 'July' {
                return 'Julho';
            } when 'August' {
                return 'Agosto';
            } when 'September' {
                return 'Setembro';
            } when 'October' {
                return 'Outubro';
            } when 'November' {
                return 'Novembro';
            } when 'December' {
                return 'Dezembro';
            } when else {
                return null;
            }
        }
    }
}