@isTest
public class ContactTriggerDisablerHelperTest {
    
    @isTest static void testShouldBypassTrigger_UserLevel() {
        // Setup - Create a Custom Setting record at User level
        Disable_Triggers__c userSetting = new Disable_Triggers__c();
        userSetting.SetupOwnerId = UserInfo.getUserId();
        userSetting.Contact_Process_Bypass__c = true;
        insert userSetting;

        // Test
        Boolean result = ContactTriggerDisablerHelper.shouldBypassTrigger();
        
        // Assert
        System.assertEquals(true, result, 'Trigger should be bypassed for the user level setting.');
    }
    
    @isTest static void testShouldBypassTrigger_ProfileLevel() {
        // Setup - Create a Custom Setting record at Profile level
        Disable_Triggers__c profileSetting = new Disable_Triggers__c();
        profileSetting.SetupOwnerId = UserInfo.getProfileId();
        profileSetting.Contact_Process_Bypass__c = true;
        insert profileSetting;

        // Test
        Boolean result = ContactTriggerDisablerHelper.shouldBypassTrigger();
        
        // Assert
        System.assertEquals(true, result, 'Trigger should be bypassed for the profile level setting.');
    }
    
    @isTest static void testShouldNotBypassTrigger() {
        // No custom setting record

        // Test
        Boolean result = ContactTriggerDisablerHelper.shouldBypassTrigger();
        
        // Assert
        System.assertEquals(false, result, 'Trigger should not be bypassed without any setting.');
    }
}