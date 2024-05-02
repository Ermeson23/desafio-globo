global class RemoveOldOrders implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Date threeMonthsAgo = System.today().addMonths(-3);

        List<Order__c> ordersToRemove = [SELECT Id FROM Order__c WHERE LastModifiedDate < :threeMonthsAgo];

        if (!ordersToRemove.isEmpty()) {
            delete ordersToRemove;
        }
    }
}