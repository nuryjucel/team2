public class caseTriggerHandlerT2 {
    public static void updateCase(List<Case> newCases){
        set<id> accIds = new set<id>();
        Map<id, List<Case>> accountToCases = new Map<id, List<Case>>();
        List<Case> cases = new List<Case>();
        
        for(Case c: newCases){
            if(c.AccountId != null){
                accIds.add(c.AccountId);
            }
        }
        
       List<Account> lstAcc = [SELECT Id, (SELECT Id, Origin, ParentId, AccountId FROM Cases ORDER BY CreatedDate ASC) 
                               FROM Account WHERE id IN :accIds];
            
        for(Account a: lstAcc){
            accountToCases.put(a.Id, a.Cases);
        }
        
        for(Case w: newCases){
            if(w.AccountId != null){
                for(Case oldCases: accountTocases.get(w.AccountId)){
                    if((w.Origin == oldCases.Origin) && (w.Id != oldCases.Id)){
                        w.ParentId = oldCases.Id;
                        cases.add(w);
                        
                        break;
                    }
                }
            }
        }
    }
}