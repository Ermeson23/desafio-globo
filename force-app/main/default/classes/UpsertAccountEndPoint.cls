@RestResource(urlMapping='/Account/*')
global with sharing class UpsertAccountEndPoint {
@HttpPut
global static void upsertAccount() {
    RestRequest request = RestContext.request;
    String body = request.requestBody.toString();
    List<Account> accountsToUpsert = (List<Account>) JSON.deserialize(body, List<Account>.class);

    List<Account> accountsToInsert = new List<Account>();
    Map<String, Account> existingAccountsMap = new Map<String, Account>();

    for (Account acc : accountsToUpsert) {
        if (acc.Account_ID__c != null && acc.Account_ID__c != '') {
            existingAccountsMap.put(acc.Account_ID__c, acc);
        }
        else {
            accountsToInsert.add(acc);
        }
    }

    try {
        if (!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }
        if (!existingAccountsMap.isEmpty()) {
            List<Account> existingAccounts = [SELECT Id, Account_ID__c FROM Account WHERE Account_ID__c IN :existingAccountsMap.keySet()];
            for (Account acc : existingAccounts) {
                Account updatedAccount = existingAccountsMap.get(acc.Account_ID__c);
                acc.Name = updatedAccount.Name;
            }
            update existingAccounts;
        }
    } catch (Exception e) {
        RestContext.response.responseBody = Blob.valueOf('Error ' + e.getMessage());
    }
}
/*
    [
{
    "Name": "Teste",
    "Industry": "Energy",
    "Phone": "9999999",
"Account_Id__c": "00038",
    "Rating": "Warm"
}
]

    */
}