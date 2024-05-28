@isTest
public class OrderPDFControllerTest {
    
    @isTest
    static void testOrderPDFController(){

        Account acc = (Account) TestFactory.createSObject(new Account());
        insert acc;
        
        Product2 prod = (Product2) TestFactory.createSObject(new Product2());
        insert prod;

        PricebookEntry pbe = (PricebookEntry) TestFactory.createSObject(new PricebookEntry(Product2Id = prod.Id, Pricebook2Id = Test.getStandardPricebookId(), UnitPrice = 100));
        insert pbe;
        
        Order ord = (Order) TestFactory.createSObject(new Order(AccountId = acc.Id, Pricebook2Id = Test.getStandardPricebookId()));
        insert ord;
        
        OrderItem ordItem = (OrderItem) TestFactory.createSObject(new OrderItem(OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity = 1, UnitPrice = 100));
        insert ordItem;
        
        Test.startTest();
        OrderPDFController controller = new OrderPDFController(new Apexpages.StandardController(ord));
        Test.stopTest();
    }
}