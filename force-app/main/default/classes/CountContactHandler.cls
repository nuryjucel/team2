public class CountContactHandler {
    public static void countActiveContacts(List<Contact> newContacts, List<Contact> oldContacts) {
        Set<Id> accIds = new Set<Id>();

        if (newContacts != null) {
            for (Contact contact : newContacts) {
                if (contact.AccountId != null && contact.Active__c) {
                    accIds.add(contact.AccountId);
                }
            }
        }

        if (oldContacts != null) {
            for (Contact contact : oldContacts) {
                if (contact.AccountId != null && contact.Active__c) {
                    accIds.add(contact.AccountId);
                }
            }
        }

        List<Account> accList = [
            SELECT Id, 
                (SELECT Id FROM Contacts WHERE Active__c = true)
            FROM Account
            WHERE Id IN :accIds
        ];

        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : accList) {
            acc.Active_Contacts__c = acc.Contacts.size();
            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}