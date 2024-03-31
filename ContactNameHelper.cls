public class ContactNameHelper {

    // Method to remove invalid characters from the input string
    public static String removeInvalidCharacters(String input) {
        if (input == null) {
            return null;
        }

        // Trim whitespace from the beginning and end of the string
        String output = input.trim();

        // Removing unwanted characters from the start and end
        while (output.startsWith('\'') || output.startsWith('-')) {
            output = output.substring(1);
        }
        // Remove trailing unwanted characters (apostrophes and hyphens)
        while (output.endsWith('\'') || output.endsWith('-')) {
            output = output.substring(0, output.length() - 1);
        }

        // Retain diacritics, remove other special characters, exclude numbers
        output = output.replaceAll('[^\\p{L}\\p{M}\\s\'\\-]', '');

        output = output.replaceAll('(-{2,})', '-'); // Replace multiple hyphens with a single one
        output = output.replaceAll('(\\\'{2,})', '\''); // Replace multiple apostrophes with a single one

        // Remove extra spaces between words
        String[] wordsArray = output.split('\\s+');
        output = String.join(wordsArray, ' ');

        return output;
    }

    // Method to convert a string to proper case, taking into account special, but very common, naming conventions
    public static String properCase(String input) {
        if (input == null) {
            return null;
        }

        // Split the input string into words based on spaces
        String[] words = input.split('\\s+');
        // Create a list to hold the processed words
        List<String> parts = new List<String>();

        // Compile a regex pattern to identify words with any uppercase letters
        Pattern p = Pattern.compile('.*[A-Z].*');

        for (String word : words) {
            // If the word is in all caps, change it to all lowercase
            if (word.equals(word.toUpperCase())) {
                word = word.toLowerCase();
            }

            // Create a matcher object for checking uppercase characters in the word, excluding the first character
            Matcher m = p.matcher(word.substring(1));

            if (word.contains('.') || (word.length() > 1 && m.matches())) {
                parts.add(word);
            } else if ((word.length() > 2 && ((word.substring(0, 2).equalsIgnoreCase('mc') || word.substring(0, 3).equalsIgnoreCase('mac'))))) {
                // Special case handling for "Mc" and "Mac" prefixes in names
                parts.add(word.substring(0, 1).toUpperCase() + (word.length() > 1 ? word.substring(1) : ''));
            } else {
                // Handle names with hyphens and apostrophes, capitalizing parts separately
                if (word.contains('-')) {
                    String[] subWords = word.split('-', -1);
                    List<String> subWordParts = new List<String>();
                    for (String subWord : subWords) {
                        if (subWord.length() > 0) {
                            // Capitalize the first letter of each sub-word
                            subWordParts.add(subWord.substring(0, 1).toUpperCase() + (subWord.length() > 1 ? subWord.substring(1).toLowerCase() : ''));
                        }
                    }
                    word = String.join(subWordParts, '-');
                } else if (word.contains('\'')) {
                    String[] subWords = word.split('\'', -1);
                    List<String> subWordParts = new List<String>();
                    for (String subWord : subWords) {
                        if (subWord.length() > 0) {
                            // Capitalize the first letter of each sub-word
                            subWordParts.add(subWord.substring(0, 1).toUpperCase() + (subWord.length() > 1 ? subWord.substring(1).toLowerCase() : ''));
                        }
                    }
                    word = String.join(subWordParts, '\'');
                } else {
                    // Capitalize the first letter of the word
                    word = word.substring(0, 1).toUpperCase() + (word.length() > 1 ? word.substring(1).toLowerCase() : '');
                }
                parts.add(word);
            }
        }

        // Join all parts to form the final string with proper case applied
        String finalOutput = String.join(parts, ' ');
        return finalOutput;
    }
}