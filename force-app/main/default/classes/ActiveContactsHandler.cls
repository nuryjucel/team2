public class ActiveContactsHandler {
    public static void countContacts(List<Contact> cons){
        Set<Id> accIds = new Set<Id>();
        for(Contact con:cons){
          if(!String.isEmpty(con.AccountId)){
            accIds.add(con.AccountId);
            }
        }
        
        List<Account> listAcc = [SELECT Id, Name, Active_Contacts__c, (SELECT id, Active__c FROM Contacts WHERE Active__c = true) FROM Account WHERE Id IN :accIds];
        
        for(Account acc:listAcc){
            acc.Active_Contacts__c = acc.Contacts.size();
        }      
        update listAcc;
        System.debug(listAcc);       
    }
}