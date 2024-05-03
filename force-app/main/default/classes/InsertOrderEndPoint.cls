@RestResource(urlMapping='/Order__c/*')
global with sharing class InsertOrderEndPoint {
    @HttpPost
    global static void insertOrder() {
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        List<Order__c> ordersToInsert = (List<Order__c>) JSON.deserialize(body, List<Order__c>.class);

        List<Order__c> ordersToInsertList = new List<Order__c>();

        for(Order__c order : ordersToInsert) {
            ordersToInsertList.add(order);
        }

        try {
            if(!ordersToInsertList.isEmpty()) {
                insert ordersToInsertList;
                RestContext.response.responseBody = Blob.valueOf('Ordem(ns) inserida(s) com sucesso! \n' + ordersToInsertList);
            }
        } catch (Exception e) {
            RestContext.response.responseBody = Blob.valueOf('Erro: ' + e.getMessage());
        }
    }
}