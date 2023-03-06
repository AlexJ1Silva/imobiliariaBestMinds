public with sharing class ImovelTO {
    @AuraEnabled
    public String id { get; set; }

    @AuraEnabled
    public String numeroImovel { get; set; }

    @AuraEnabled
    public String tipoImovel { get; set; }

    @AuraEnabled
    public String nomeCliente { get; set; }

    @AuraEnabled
    public Decimal valorVenda { get; set; }
    
    @AuraEnabled
    public String Vendedor { get; set; }
    
    @AuraEnabled
    public String idCliente { get; set; }
}