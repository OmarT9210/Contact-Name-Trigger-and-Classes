trigger ContactTriggerDisabler on Contact (before insert, before update, before delete) 
{
    if (ContactTriggerDisablerHelper.shouldBypassTrigger())
    {
        return;
    }
    // Any other trigger logic you'd want to include in the future
}