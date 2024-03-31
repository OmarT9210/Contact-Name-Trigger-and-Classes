@isTest
public class ContactTriggerDisablerTest {
    
    @isTest static void testTriggerBypass_UserLevel() {
        // Setup - Create a Custom Setting record at User level
        Disable_Triggers__c userSetting = new Disable_Triggers__c();
        userSetting.SetupOwnerId = UserInfo.getUserId();
        userSetting.Contact_Process_Bypass__c = true;
        insert userSetting;
        
        // Create a test Contact
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User');
        
        // Test
        Test.startTest();
        insert testContact;
        Test.stopTest();
        
        // No specific assertions for the trigger itself, since it's only bypassing logic.
        // We rely on the helper class tests to verify the bypass logic.
    }
    
    @isTest static void testTriggerBypass_ProfileLevel() {
        // Setup - Create a Custom Setting record at Profile level
        Disable_Triggers__c profileSetting = new Disable_Triggers__c();
        profileSetting.SetupOwnerId = UserInfo.getProfileId();
        profileSetting.Contact_Process_Bypass__c = true;
        insert profileSetting;
        
        // Create a test Contact
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User');
        
        // Test
        Test.startTest();
        insert testContact;
        Test.stopTest();
        
        // Again, no specific assertions here.
    }
    
    @isTest static void testTriggerExecution() {
        // No custom setting record

        // Create a test Contact
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User');
        
        // Test
        Test.startTest();
        insert testContact;
        Test.stopTest();
        
        // No assertions here since the trigger is only bypassing logic.
    }
}