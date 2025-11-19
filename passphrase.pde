// Core functionality:
// We have list of number to word mappings
// Generate a word:
//   Roll Five Dice (d6)
//   Combine the dice roll results into a 5-digit number
//   Use that number to look up the word
//   Record the word
// Keep generating words

// Side quests:
//   Add as many words as we like
//   Displaying words (keeping things on the screen)
//   Alter the words 
//     capitalize
//     all caps
//     substitutions (zero for the letter 'o', etc.)
//     add numbers or special characters 
//   Delete words
//   copy-paste?
//   More efficient data structure to hold the words
//   Base 6 encoding

HashMap<Integer,String> wordsDictionary = new HashMap<>();
ArrayList<Word> passphrase = new ArrayList<>();
int modifyIndex = 0;
final int STARTING_TEXT_SIZE = 75;
int sizeOfText = STARTING_TEXT_SIZE;


void setup() { 
  size(1000,800);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0 ; i < lines.length; i++) {
    String[] results = lines[i].split("\t");
    String number = results[0];
    String word = results[1];
    //number = substractOneFromEachDigit(number);
    wordsDictionary.put(fromSixToTen(number), word);
  }
  textSize(48);
  noLoop();
}

void keyPressed() {
  switch (key) {
    case 'n':
      addNewWord();
      break;
    case 'd':
      deleteWord();
      break;
  }
  switch (keyCode) {
    case ENTER:
      addNewWord();
      break;
    case DELETE:
      deleteWord();
      break;
    case RIGHT:
      increaseIndex();
      break;
    case LEFT:
      decreaseIndex();
      break;
    case UP:
      toggleWordCase();
      break;
    case DOWN:
      break;
  }
  redraw();
}

void addNewWord(){
  String lookupString = "";
  for( int i = 0; i < 5; i++ ) {
    lookupString += int(random(0,6)) + 1;
  }
  int lookupInt = fromSixToTen(lookupString);
  String wordFound = wordsDictionary.get(lookupInt);
  passphrase.add(new Word(wordFound));
}

void deleteWord(){
  passphrase.remove(passphrase.get(modifyIndex));
  decreaseIndex();
}
void toggleWordCase(){
  passphrase.get(modifyIndex).toggleCase();
}

void decreaseIndex(){
  if (modifyIndex > 0) {
    modifyIndex--;
  }
}
void increaseIndex(){
  if (modifyIndex < passphrase.size() - 1) {
    modifyIndex++;
  }
}

void draw() {
  showText();
}
void showText() {
  background(240);
  fill(120);
  String text = "";
  for( Word w : passphrase ) {
    text += w.toString();
  }
  sizeOfText = STARTING_TEXT_SIZE; 
  textSize(sizeOfText);
  while(textWidth(text) > width ) {
    sizeOfText--;
    textSize(sizeOfText);
  }
  float x = width/2-textWidth(text)/2;
  float y = height/2;
  
  for( int i = 0; i < passphrase.size(); i++ ) {
    if( i == modifyIndex ) {
      fill(255,0,0);
    } else {
      fill(120);
    }
    Word w = passphrase.get(i);
    text(w.toString(),x,height/2);
    x += textWidth(w.toString());
  }
  
  
}

String substractOneFromEachDigit(String number) {
  String result = "";
  for (int i = 0; i < number.length(); i++) {
    int modified = Character.getNumericValue(number.charAt(i)) - 1;
    result += modified;
  }
  return result;
}
int fromSixToTen(String number) {
  int result = 0;
  for (int i = 0; i < number.length(); i++) {
    int multiplier = (int) pow(6, number.length() - 1 - i);
    int numAtPos = Character.getNumericValue(number.charAt(i));
    result += numAtPos * multiplier;
  }
  return result;
}
int fromSixToTen(int number) {
  return fromSixToTen(Integer.toString(number));
}

class Word {
  String originalWord;
  int wordCase = 0;
  
  Word( String word ) {
    this.originalWord = word;
  }
  
  void toggleCase() {
    if (wordCase < 2) {
      this.wordCase++;
    } else {
      wordCase = 0;
    }
  }
  
  String capitalize(String word) {
    String restOfWord = word.substring(1);
    String firstLetter = word.charAt(0) + "";
    firstLetter = firstLetter.toUpperCase();
    return firstLetter + restOfWord;
  } 
  
  String toString() {
    String newWord = originalWord;
    if( wordCase == 1 ) {
      newWord = this.capitalize(newWord);
    } if ( wordCase == 2 ) {
      newWord = newWord.toUpperCase();
    }
    return newWord;
  }
}

