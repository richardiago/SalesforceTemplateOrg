@isTest
global class UtilsClassTest {

    @TestSetup
    public static void makeData(){
        
        Account acc1 = (Account) TestFactory.createSObject(new Account(Name = 'Test Account 1', NumberOfEmployees = 21));
        Account acc2 = (Account) TestFactory.createSObject(new Account(Name = 'Test Account 2', NumberOfEmployees = 26));

        insert new List<Account>{acc1, acc2};
    }

    @isTest
    public static void getPicklistValuesTest(){

        Map<String, String> values = UtilsClass.getPicklistValues('Account', 'Type');
        Assert.isTrue(values.size() > 0);
    }

    @isTest
    public static void isChangedTest(){

        List<Acccount> accs = [SELECT Id, Name, NumberOfEmployees FROM Account];
        Assert.isTrue(UtilsClass.isChanged(accs[0], accs[1], new List<String>{'NumberOfEmployees'}));
        Assert.isFalse(UtilsClass.isChanged(accs[0], accs[0], new List<String>{'NumberOfEmployees'}));
    }

    @isTest
    public static void getObjectDeveloperNameTest(){

        Id accId = [SELECT Id FROM Account LIMIT 1].Id;
        Assert.areEqual('Account', UtilsClass.getObjectDeveloperName(accId, true));
    }

    @isTest
    public static void executeHttpRequestTest(){

        Map<String, String> headers = new Map<String, String>{
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
        };

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpRequestMock());
        HttpResponse res = UtilsClass.executeHttpRequest('https://www.test.com', 'GET', 'test', headers);
        Test.stopTest();
    }

    global class HttpRequestMock implements HttpCalloutMock {

        global HTTPResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setBody('test');
            res.setStatusCode(200);
            return res;
        }
    }
}