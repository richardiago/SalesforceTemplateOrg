public without sharing class AccountHelper {
    
    public static void updateNumberOfEmployees(Map<Id, Account> newRecordsMap){

        for(Account acc : newRecordsMap.values()){
            acc.NumberOfEmployees += 10; 
        }
    }
}
