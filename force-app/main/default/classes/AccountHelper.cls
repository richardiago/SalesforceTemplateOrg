public without sharing class AccountHelper {
    
    public static void updateNumberEmployees(Map<Id, Account> newRecordsMap){

        for(Account acc : newRecordsMap.values()){
            acc.Employees += 10; 
        }
    }
}
