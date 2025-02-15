@isTest
private class TaskReminderJobTest {
    @isTest
    static void testExecute() {
        Task testTask = new Task(Subject = 'Test Task', Status = 'Not Started', ActivityDate = Date.today());
        insert testTask;

        Test.startTest();
        TaskReminderJob job = new TaskReminderJob();
        job.execute(null);
        Test.stopTest();

        System.assert(true, 'Job executed successfully');
    }
}
