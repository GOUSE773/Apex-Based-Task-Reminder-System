global class TaskReminderJob implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<Task> pendingTasks = [SELECT Id, Subject, Status, OwnerId 
                                   FROM Task 
                                   WHERE Status != 'Completed' AND ActivityDate = TODAY];

        for (Task t : pendingTasks) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Task Reminder: ' + t.Subject);
            email.setPlainTextBody('You have a pending task: ' + t.Subject);
            email.setTargetObjectId(t.OwnerId);
            email.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
    }
}
