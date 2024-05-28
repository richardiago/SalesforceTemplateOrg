public without sharing class AccountHelper {
    
    public static void updateNumberOfEmployees(List<Account> newRecordList){

        for(Account acc : newRecordList){
            acc.NumberOfEmployees = acc.NumberOfEmployees == null ? 10 : acc.NumberOfEmployees+10; 
        }
    }
}
