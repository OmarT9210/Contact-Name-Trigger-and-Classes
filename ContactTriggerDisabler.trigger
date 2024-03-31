trigger ContactTriggerDisabler on Contact (before insert, before update, before delete) 
{
    if (ContactTriggerDisablerHelper.shouldBypassTrigger())
    {
        return;
    }
}