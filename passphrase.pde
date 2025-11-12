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
String word = "";

void setup() { 
  size(1000,800);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0 ; i < lines.length; i++) {
    String[] results = lines[i].split("\t");
    words[int(results[0])] = results[1];
  }
  textSize(48);
}

void keyPressed() {
  String lookupString = "";

  for( int i = 0; i < 5; i++ ) {
    lookupString += int(random(0,6)) + 1;
  }
  
  word += words[int(lookupString)];
}

void draw() {
  background(240);
  fill(120);
  float w = textWidth(word);
  text(word,width/2-w/2,height/2);
}
