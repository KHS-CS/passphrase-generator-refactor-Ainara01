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

String[] words = new String[66667];
ArrayList<Word> passphrase = new ArrayList<Word>();
int modifyIndex = 0;
final int STARTING_TEXT_SIZE = 75;
int sizeOfText = STARTING_TEXT_SIZE;

void setup() { 
  size(1000,800);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0 ; i < lines.length; i++) {
    String[] results = lines[i].split("\t");
    words[int(results[0])] = results[1];
  }
  textSize(sizeOfText);
}

void keyPressed() {
  if( key == 'n' ) {
    String lookupString = "";

    for( int i = 0; i < 5; i++ ) {
      lookupString += int(random(0,6)) + 1;
    }
    
    passphrase.add( new Word(words[int(lookupString)]) );
  }
  
  if( key == 'd' ) { 
    passphrase.remove(passphrase.size() - 1);
  }
  
  if( key == '+' ) {
    modifyIndex++;
  }
  
  if( key == '-' ) {
    modifyIndex--;
  }
  // move this functionality to the Word class
  //if( key == 'u' ) {
  //  String wordToModify = passphrase.get(modifyIndex);
  //  String newWord = wordToModify.toUpperCase();
  //  passphrase.set(modifyIndex,newWord);
  //}
  
  if( key == 'c' ) {
    
    Word wordToModify = passphrase.get(modifyIndex);
    wordToModify.toggleCapitalize();
  }
  
  
  //System.out.println(passphrase);
}

void draw() {  
  background(240);
  fill(120);
  String word = "";
  for( Word w : passphrase ) {
    word += w.toString();
  }
  
  sizeOfText = STARTING_TEXT_SIZE; 
  textSize(sizeOfText);
  while( textWidth(word) > width ) {
    System.out.println("Shrinking");
    sizeOfText *= 0.99;
    textSize(sizeOfText);
  }
  
  float x = width/2-textWidth(word)/2;
  
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
  //text(word,width/2-w/2,height/2);
}

class Word {
  String originalWord;
  boolean capitalize = false;
  boolean allUpperCase = false;
  
  Word( String word ) {
    this.originalWord = word;
  }
  
  void toggleCapitalize() {
    this.capitalize = !this.capitalize;
  }
  
  String capitalize(String word) {
    String restOfWord = word.substring(1);
    String firstLetter = word.charAt(0) + "";
    firstLetter = firstLetter.toUpperCase();
    return firstLetter + restOfWord;
  } 
  
  String toString() {
    String newWord = originalWord;
    // modifications
    if( this.capitalize ) {
      newWord = this.capitalize(newWord);
    }
    
    return newWord;
  }
}
