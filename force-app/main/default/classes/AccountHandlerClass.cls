public class AccountHandlerClass {
    public static void sendEmail(List<Account> lstAcc) {

        List<Messaging.Email> lstEmail = new List<Messaging.Email>();

        for (Account acc : lstAcc) {
            if(acc.Email__c != null && acc.EmailSend__c == true) {
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String [] toAddress = new String[]{acc.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSub = 'Conta ' + acc.Name + ' criada/editada com sucesso.';
                emailMsg.setSubject(emailSub);
                String content = 'Olá! ' + acc.Name + ' criada/editada com sucesso! <br/><br/>' + 'Bem-vindo ao Salesforce!';
                emailMsg.SetHtmlBody(content);
                lstEmail.add(emailMsg);
            }
        }
        Messaging.sendEmail(lstEmail);
    }
}