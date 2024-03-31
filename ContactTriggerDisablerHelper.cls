public class ContactTriggerDisablerHelper 
{
    // Method to check if we should bypass the trigger based on the custom setting
    public static Boolean shouldBypassTrigger()
    {
        Disable_Triggers__c userSetting = Disable_Triggers__c.getInstance(UserInfo.getUserId());
        Disable_Triggers__c profileSetting = Disable_Triggers__c.getInstance(UserInfo.getProfileId());
        
        // If a user-specific setting exists, prioritize it.
        if (userSetting != null && userSetting.Contact_Process_Bypass__c)
        {
            return true;
        }
        
        // If no user-specific setting, check for profile-specific setting.
        if (profileSetting != null && profileSetting.Contact_Process_Bypass__c)
        {
            return true;
        }
        
        return false;
    }
}