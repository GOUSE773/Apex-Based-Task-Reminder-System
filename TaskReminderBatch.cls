global class TaskReminderBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Subject, Status, OwnerId FROM Task WHERE Status != \'Completed\' AND ActivityDate = TODAY');
    }
    
    global void execute(Database.BatchableContext BC, List<Task> scope) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Task t : scope) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Task Reminder: ' + t.Subject);
            email.setPlainTextBody('You have a pending task: ' + t.Subject);
            email.setTargetObjectId(t.OwnerId);
            email.setSaveAsActivity(false);
            emails.add(email);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
    
    global void finish(Database.BatchableContext BC) {}
}
