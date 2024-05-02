trigger SendAnEmailOnCreateOrEditAccount on Account (after insert, after update) {
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter ) {
        AccountHandlerClass.sendEmail(trigger.new);
    }
}