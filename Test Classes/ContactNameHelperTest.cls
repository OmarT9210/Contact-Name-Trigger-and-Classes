@isTest
private class ContactNameHelperTest {
    
    static testMethod void testRemoveInvalidCharacters() {
        String test1 = ContactNameHelper.removeInvalidCharacters('-abc');
        System.assertEquals('abc', test1, 'Numbers should be removed');

        String test2 = ContactNameHelper.removeInvalidCharacters('abc-**');
        System.assertEquals('abc-', test2, 'Special characters should be removed');

        String test3 = ContactNameHelper.removeInvalidCharacters('--abc**');
        System.assertEquals('abc', test3, 'Leading special characters should be removed');

        String test4 = ContactNameHelper.removeInvalidCharacters('abc**--');
        System.assertEquals('abc', test4, 'Trailing special characters should be removed');

        String test5 = ContactNameHelper.removeInvalidCharacters('\'--abc--\'');
        System.assertEquals('abc', test5, 'Leading and trailing hyphens and apostrophes should be removed');
    }

    static testMethod void testProperCase() {
        String test1 = ContactNameHelper.properCase('abc def');
        System.assertEquals('Abc Def', test1, 'Each word should start with uppercase');

        String test2 = ContactNameHelper.properCase('abc-def');
        System.assertEquals('Abc-Def', test2, 'Each part should start with uppercase');

        String test3 = ContactNameHelper.properCase('abc\'def');
        System.assertEquals('Abc\'Def', test3, 'Each part should start with uppercase');

        String test4 = ContactNameHelper.properCase('mcdef');
        System.assertEquals('Mcdef', test4, 'Should not change case after mc');

        String test5 = ContactNameHelper.properCase('macdef');
        System.assertEquals('Macdef', test5, 'Should not change case after mac');

        String test6 = ContactNameHelper.properCase('ABC');
        System.assertEquals('Abc', test6, 'All uppercase word should be converted to proper case');

        String test7 = ContactNameHelper.properCase('simple');
        System.assertEquals('Simple', test7, 'Simple word should be converted to proper case');

        String test8 = ContactNameHelper.properCase('o\'leary');
        System.assertEquals('O\'Leary', test8, 'Word with an apostrophe should be converted to proper case');

    }
}