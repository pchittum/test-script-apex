trigger TestParentTrigger on test_Parent__c (after insert) {

    List<test_Child__c> insertList = new List<test_Child__c>();

    for (test_Parent__c rec: Trigger.new){
        insertList.add(new test_Child__c(Name='Child of ' + rec.Name, test_Parent__c=rec.Id));
    }

    insert insertList;

}