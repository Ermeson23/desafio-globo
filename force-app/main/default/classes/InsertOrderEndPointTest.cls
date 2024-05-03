@isTest
private class InsertOrderEndPointTest {
    @isTest
    static void testInsertOrder() {
        List<Order__c> ordersToInsert = new List<Order__c>();
        ordersToInsert.add(new Order__c(Name = 'Pedido A', Email__c = 'pedidoA@gmail.com', Order_Value__c = 100, AccountName__c = 'Teste'));
        ordersToInsert.add(new Order__c(Name = 'Pedido B', Email__c = 'pedidoB@gmail.com', Order_Value__c = 150, AccountName__c = 'Teste'));
        ordersToInsert.add(new Order__c(Name = 'Pedido C', Email__c = 'pedidoC@gmail.com', Order_Value__c = 200, AccountName__c = 'Teste'));

        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(JSON.serialize(ordersToInsert));
        RestContext.request = request;

        Test.startTest();
        InsertOrderEndPoint.insertOrder();
        Test.stopTest();

        List<Order__c> insertedOrders = [SELECT Id, Name, Email__c FROM Order__c];
        System.assertEquals(3, insertedOrders.size(), 'Insere 3 pedidos');
    }
}