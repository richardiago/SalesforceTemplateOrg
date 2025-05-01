public without sharing class OrderPDFController {
    
    //public Id recordId {get;set;}
    public Order order {get;set;}

    public OrderPDFController(ApexPages.StandardController stdController){

        //this.recordId = ApexPages.CurrentPage().getParameters().get('id');
        this.order = [SELECT Id, Name, Account.Name, Account.BillingStreet, Account.BillingCity, Account.BillingState, Account.BillingPostalCode, Account.BillingCountry, TotalAmount,
                    OrderNumber, EffectiveDate, (SELECT Id, Product2.Name, Quantity, UnitPrice, TotalPrice FROM OrderItems) 
                 FROM Order WHERE Id = : stdController.getRecord().Id];

        ApexPages.currentPage().getHeaders().put('content-disposition', 'inline; filename=Order' + order.OrderNumber + '.pdf');
    }
}