public class ContactNameHelper {

    public static String removeInvalidCharacters(String input) {
        if (input == null) {
            return null;
        }

        String output = input.trim();

        // Removing unwanted characters from the start and end
        while (output.startsWith('\'') || output.startsWith('-')) {
            output = output.substring(1);
        }
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

    public static String properCase(String input) {
        if (input == null) {
            return null;
        }

        String[] words = input.split('\\s+');
        List<String> parts = new List<String>();

        Pattern p = Pattern.compile('.*[A-Z].*'); // This is your regex pattern

        for (String word : words) {
            // If the word is in all caps, change it to all lowercase
            if (word.equals(word.toUpperCase())) {
                word = word.toLowerCase();
            }

            Matcher m = p.matcher(word.substring(1)); // Create matcher for the substring of word excluding first character

            if (word.contains('.') || (word.length() > 1 && m.matches())) {
                parts.add(word);
            } else if ((word.length() > 2 && ((word.substring(0, 2).equalsIgnoreCase('mc') || word.substring(0, 3).equalsIgnoreCase('mac'))))) {
                parts.add(word.substring(0, 1).toUpperCase() + (word.length() > 1 ? word.substring(1) : ''));
            } else {
                if (word.contains('-')) {
                    String[] subWords = word.split('-', -1);
                    List<String> subWordParts = new List<String>();
                    for (String subWord : subWords) {
                        if (subWord.length() > 0) {
                            subWordParts.add(subWord.substring(0, 1).toUpperCase() + (subWord.length() > 1 ? subWord.substring(1).toLowerCase() : ''));
                        }
                    }
                    word = String.join(subWordParts, '-');
                } else if (word.contains('\'')) {
                    String[] subWords = word.split('\'', -1);
                    List<String> subWordParts = new List<String>();
                    for (String subWord : subWords) {
                        if (subWord.length() > 0) {
                            subWordParts.add(subWord.substring(0, 1).toUpperCase() + (subWord.length() > 1 ? subWord.substring(1).toLowerCase() : ''));
                        }
                    }
                    word = String.join(subWordParts, '\'');
                } else {
                    word = word.substring(0, 1).toUpperCase() + (word.length() > 1 ? word.substring(1).toLowerCase() : '');
                }
                parts.add(word);
            }
        }

        String finalOutput = String.join(parts, ' ');
        return finalOutput;
    }
}