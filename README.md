# Contact Name Trigger and Classes
 Mix of Triggers and Helper Classes to validate contact names on Salesforce

 I am not a Salesforce Developer by trade. I am a scrappy Salesforce Administrator leveraging self-taught knowledge of Apex, articles, videos, blog posts, and AI. I take no responsibility for any use of this code nor the contents of this project. This is being provided as a template for you to use in good faith in a sandbox to test a functionality that may be very useful to you.

 **Notes**
 - The "middle name" field the ContactNameTrigger / Helper code may need to be edited to your org's "middle name" field since I use a custom one.
 - You need to create custom settings appropriate for whether you'd like to control disabling triggers for specific users, at a profile level, or at the org level. I reference the name of my custom setting in this code.
 - The hyphen/apostrophe logic could likely be shortened. Some parts of this code are redundant, but it's worked in my org for six months without issue.
 - The "only on insert / update" of the respective fields was added because, otherwise,the triggers were running on non-related record changes to the name fields.

 
