# Overview
We are trying to make a functional passphrase generator that uses the DiceWare process while allowing for core alterations and a pleasant user experience (UX). 

In the first iteration of this project you completed some of the below side quests. Then, in class on Wednesday, November 12th, we introduced the concept of using a `Word` class to store the orignal word and then to apply some modifications to that word. We also introduced other changes along the way, some of which were complete or partial solutions to some of the side quests.  

In this iteration you have a few tasks:
* Bring the things you completed from the first assignment into this assignment.
* Complete some of the undone tasks from class:
  * Boundary checking when making changes to the `modifyIndex` variable (it shouldn't cause an `IndexOutOfBoundsException`)
  * Make changes to `modifyIndex` when removing a word from the `ArrayList` if necessary
  * Add `toUpperCase` functionality to the `Word` class.
* Continue to complete side quests or come up with new side quests. 

## Core functionality:
* We have list of number to word mappings
* Generate a word:
  * Roll Five Dice (d6)
  * Combine the dice roll results into a 5-digit number
  * Use that number to look up the word
  * Record the word
* Keep generating words

## Side quests:
* Add as many words as we like
* Displaying words (keeping things on the screen)
* Alter the words 
  * capitalize
  * all caps
  * substitutions (zero for the letter 'o', etc.)
  * add numbers or special characters 
* Delete words
* copy-paste?
* More efficient data structure to hold the words
* Base 6 encoding
