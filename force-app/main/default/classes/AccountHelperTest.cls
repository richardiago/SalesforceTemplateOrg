@IsTest
public class AccountHelperTest {
    
    @TestSetup
    static void makeData(){

        Account acc = (Account) TestFactory.createSObject(new Account(
            NumberOfEmployees = 100
        ));
        insert acc;
    }

    @isTest
    static void updateNumberEmployeesTest(){

        Account acc = [SELECT NumberOfEmployees FROM Account LIMIT 1];
        
        Assert.areEqual(110, acc.NumberOfEmployees);
    }
}