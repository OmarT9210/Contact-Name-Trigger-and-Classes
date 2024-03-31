@isTest
private class ContactNameTriggerTest {
    
    static testMethod void testBeforeInsert() {
        // Test standard before insert functionality
        Contact c = new Contact();
        c.FirstName = 'abc def';
        c.LastName = 'ghi-jkl';
        c.TargetX_SRMb__Middle_Name__c = 'mno pqr';
        insert c;

        Contact result = [SELECT FirstName, LastName, TargetX_SRMb__Middle_Name__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('Abc Def', result.FirstName);
        System.assertEquals('Ghi-Jkl', result.LastName);
        System.assertEquals('Mno Pqr', result.TargetX_SRMb__Middle_Name__c);
    }

    static testMethod void testBeforeUpdate() {
        // Test standard before update functionality
        Contact c = new Contact();
        c.FirstName = 'abc def';
        c.LastName = 'ghi-jkl';
        c.TargetX_SRMb__Middle_Name__c = 'mno pqr';
        insert c;

        c.FirstName = 'uvw xyz';
        c.LastName = 'abc-def';
        c.TargetX_SRMb__Middle_Name__c = 'ghi jkl';
        update c;

        Contact result = [SELECT FirstName, LastName, TargetX_SRMb__Middle_Name__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('Uvw Xyz', result.FirstName);
        System.assertEquals('Abc-Def', result.LastName);
        System.assertEquals('Ghi Jkl', result.TargetX_SRMb__Middle_Name__c);
    }

    static testMethod void testBypassAutomationRules() {
        // Test bypass using the picklist value
        Contact c = new Contact();
        c.FirstName = 'abc def';
        c.LastName = 'ghi-jkl';
        c.TargetX_SRMb__Middle_Name__c = 'mno pqr';
        c.Bypass_Automation_Rules__c = 'Name Validation';
        insert c;

        Contact result = [SELECT FirstName, LastName, TargetX_SRMb__Middle_Name__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('abc def', result.FirstName);
        System.assertEquals('ghi-jkl', result.LastName);
        System.assertEquals('mno pqr', result.TargetX_SRMb__Middle_Name__c);
    }

    static testMethod void testBypassTriggerUsingCustomSetting() {
        // Test bypass using the custom setting
        Disable_Triggers__c setting = new Disable_Triggers__c();
        setting.SetupOwnerId = UserInfo.getUserId(); // For specific user setting
        setting.Contact_Process_Bypass__c = true;
        insert setting;

        Contact c = new Contact();
        c.FirstName = 'abc def';
        c.LastName = 'ghi-jkl';
        c.TargetX_SRMb__Middle_Name__c = 'mno pqr';
        insert c;

        Contact result = [SELECT FirstName, LastName, TargetX_SRMb__Middle_Name__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('abc def', result.FirstName, 'FirstName should not be in proper case due to trigger bypass');
        System.assertEquals('ghi-jkl', result.LastName, 'LastName should not be in proper case due to trigger bypass');
        System.assertEquals('mno pqr', result.TargetX_SRMb__Middle_Name__c, 'MiddleName should not be in proper case due to trigger bypass');
    }
}