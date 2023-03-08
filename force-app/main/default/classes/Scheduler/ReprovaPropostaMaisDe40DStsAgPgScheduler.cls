public with sharing class ReprovaPropostaMaisDe40DStsAgPgScheduler implements Schedulable{
    public static String nome = 'Reprova Propostas com mais de 40 dias aguardando pagamento';
    // Cron de everyday as 5 da manhã    
    public static String expressaoCron = '0 0 5 1/1 * ? *';
    // Método para iniciar o job    
    public static void agendar(){
        System.schedule(nome, expressaoCron, new ReprovaPropostaMaisDe40DStsAgPgScheduler());
    }
    // método para executar a classe desejada.    
    public void execute(SchedulableContext context) {
        Database.executeBatch(new ReprovaPropostaMaisDe40DStatusAgPgBatch());
    }
}