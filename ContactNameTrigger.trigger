trigger ContactNameTrigger on Contact (before insert, before update) {

    if (ContactTriggerDisablerHelper.shouldBypassTrigger()) {
        return;
    }

    for (Contact c : Trigger.new) {
        Boolean bypass = false;
        
        // Get all active picklist values
        Schema.DescribeFieldResult fieldResult = Contact.Bypass_Automation_Rules__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();

        // Check if 'Name Validation' is an active picklist value and selected for the current record
        for (Schema.PicklistEntry entry : picklistValues) {
            if (entry.getValue() == 'Name Validation' && entry.isActive()) {
                if (c.Bypass_Automation_Rules__c != null && c.Bypass_Automation_Rules__c.contains(entry.getValue())) {
                    bypass = true;
                    break;
                }
            }
        }

        // If 'Name Validation' is active and selected, bypass the name adjustments
        if (bypass) {
            continue;
        }

        try {
            // Only process names on insert or when they have changed
            if (Trigger.isInsert ||
                (Trigger.isUpdate && 
                    (c.FirstName != Trigger.oldMap.get(c.Id).FirstName ||
                     c.LastName != Trigger.oldMap.get(c.Id).LastName ||
                     c.TargetX_SRMb__Middle_Name__c != Trigger.oldMap.get(c.Id).TargetX_SRMb__Middle_Name__c))) {

                if (c.FirstName != null) {
                    System.debug('Original FirstName: ' + c.FirstName);
                    c.FirstName = ContactNameHelper.properCase(ContactNameHelper.removeInvalidCharacters(c.FirstName));
                    System.debug('Modified FirstName: ' + c.FirstName);
                }

                if (c.LastName != null) {
                    System.debug('Original LastName: ' + c.LastName);
                    c.LastName = ContactNameHelper.properCase(ContactNameHelper.removeInvalidCharacters(c.LastName));
                    System.debug('Modified LastName: ' + c.LastName);
                }

                if (c.TargetX_SRMb__Middle_Name__c != null) {
                    System.debug('Original MiddleName: ' + c.TargetX_SRMb__Middle_Name__c);
                    c.TargetX_SRMb__Middle_Name__c = ContactNameHelper.properCase(ContactNameHelper.removeInvalidCharacters(c.TargetX_SRMb__Middle_Name__c));
                    System.debug('Modified MiddleName: ' + c.TargetX_SRMb__Middle_Name__c);
                }
            }
        } catch (Exception e) {
            System.debug('Error processing contact name: ' + e.getMessage());
            // Optionally, add more handling like throwing a custom exception or logging
        }
    }
}