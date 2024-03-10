@isTest
global class UtilsClassTest {

    @TestSetup
    public static void makeData(){
        
        Account acc1 = (Account) TestFactory.createSObject(new Account(Name = 'Test Account 1', NumberOfEmployees = 21));
        Account acc2 = (Account) TestFactory.createSObject(new Account(Name = 'Test Account 2', NumberOfEmployees = 26));

        insert new List<Account>{acc1, acc2};
    }

    public static void verifyAutomationSetting(){
            
        Boolean isAutomationEnabled = UtilsClass.verifyAutomationSetting('Account');
    }

    public static void setAutomationSetting(){

        UtilsClass.setAutomationSetting('Account', false);
    }

    public static void getRecordTypeIdTest(){

        UtilsClass.getRecordTypeId('Account', 'Person Account', true);
        UtilsClass.getRecordTypeId('Account', 'Person Account', false);
    }

    @isTest
    public static void getPicklistValuesTest(){

        Map<String, String> values = UtilsClass.getPicklistValues('Account', 'Type');
        Assert.isTrue(values.size() > 0);
    }

    @isTest
    public static void isChangedTest(){

        List<Account> accs = [SELECT Id, Name, NumberOfEmployees FROM Account];
        Assert.isTrue(UtilsClass.isChanged(accs[0], accs[1], new List<String>{'NumberOfEmployees'}));
        Assert.isFalse(UtilsClass.isChanged(accs[0], accs[0], new List<String>{'NumberOfEmployees'}));
    }

    @isTest
    public static void getObjectDeveloperNameTest(){

        Id accId = [SELECT Id FROM Account LIMIT 1].Id;
        Assert.areEqual('Account', UtilsClass.getObjectDeveloperName(accId, true));
    }

    @isTest
    public static void sendSingleEmailTest(){

        List<String> toAddresses = new List<String>{'test@test.test', 'test2@test.test'};
        List<String> ccAddresses = new List<String>();
        String body = 'This is a test';
        Boolean isHtmlBody = false;
        String subject = 'Sending email from Salesforce';
        String displayName = 'Salesforce Tester';
        Boolean isBccSender = false;
        Boolean useSignature = true;
        String replyTo = 'test3@test.test';

        Messaging.SingleEmailMessage email = UtilsClass.buildEmail(toAddresses, ccAddresses, body, isHtmlBody, subject, displayName, isBccSender, useSignature, replyTo);
        UtilsClass.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        
        isHtmlBody = true;
        body = '<b> Your test </b>';

        email = UtilsClass.buildEmail(toAddresses, ccAddresses, body, isHtmlBody, subject, displayName, isBccSender, useSignature, replyTo);
        UtilsClass.sendEmail(new List<Messaging.SingleEmailMessage>{email});
    }

    @isTest
    public static void executeHttpRequestTest(){

        Map<String, String> headers = new Map<String, String>{
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
        };

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpRequestMock());
        UtilsClass.HttpResponseWrapper res = UtilsClass.executeHttpRequest('https://www.test.com', 'GET', 'test', headers);
        Test.stopTest();
    }

    global class HttpRequestMock implements HttpCalloutMock{

        global HTTPResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setBody('test');
            res.setStatusCode(200);
            return res;
        }
    }
}