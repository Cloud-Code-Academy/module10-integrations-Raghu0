public with sharing class ContactTriggerHandler extends TriggerHandler {
    public List<Contact> newRecords;
    public List<Contact> oldRecords;
    public ContactTriggerHandler(){
        this.newRecords = (List<Contact>)Trigger.new;
        this.oldRecords = (List<Contact>)Trigger.old;
    }
    public override void beforeInsert(){
    // When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
    for(Contact contact : newRecords){
        if(contact.DummyJSON_Id__c == null){
            contact.DummyJSON_Id__c = String.valueOf(Math.round((Math.random()*100)));
        }
    }
    }
    public override void afterInsert(){
        Integer dummyJsonId;
        //When a contact is inserted
	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
    for(Contact contact : newRecords){
        dummyJsonId = Integer.valueOf(contact.DummyJSON_Id__c);
        if(dummyJsonId <= 100){
            DummyJSONCallout.getDummyJSONUserFromId(contact.DummyJSON_Id__c);
        }
    }
    }
    public override void afterUpdate(){
        Integer dummyJsonId;
    //When a contact is updated
	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
    for(Contact contact : newRecords){
        dummyJsonId = Integer.valueOf(contact.DummyJSON_Id__c);
        if(dummyJsonId > 100){
            DummyJSONCallout.postCreateDummyJSONUser(contact.Id);
        }
    }
    }
}