# Phase 1 Phinal - CLI Application from a (Pokemon) API

# tl/dr "CLI program that sorts through a Pokemon API and returns key information about your deck of Pokemon cards."
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSTALL INSTRUCTIONS:
 - copy and git clone into your terminal
 - in terminal: $ bundle install
 - in terminal: $ ruby bin/run
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This program:
 - Imports an API file that contains data on 100 random Pokemon Cards
 - Sorts those Cards alphabetically and allows the user to see that list, or a list of the 'types' of Pokemon.
 - Given the list of Cards, the user can choose a card and get specific information about that card. 
 - Given the list of Types, the user can choose from any of the types, and get a list returned of all Pokemon that are that type. 
    They can then choose any of those Pokemon, and get details on that specific Pokemon. 
- There are invalid response messages for all menus, as well the ability to exit the program in every menu.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A quick who/what/why about me and this project:

Hello! And so begins my first foray into creation without a net. 
Hopefully this goes a little more Dumbo, and a lot less The Flying Graysons.

    The goal of this project is to create a CLI application that uses data pulled from an API file. 
After looking at some over-complicated API's (Marvel Universe) and some that didn't really resonate with me (too many to mention), 
I came upon a Pokemon API. "Perfect!", I thought. As the father to a 6-year old boy, I have been mindlessly supplying my child with 
all things Pokemon for the better part of 3 years. Cards, books, pokeballs, stuffed animals, action figures, wall decals, hoodies, 
etc. I hope he enjoyed it, because that was his college fund.

The program initially sorts through the "deck", and alphabetizes them for your perusal. After that, you can choose any card in that deck and "flip it over" to see some key information about that card. I thought it would be interesting to get into my son's mind and find out what was important, namely when he's doing battles ["my deck of cards vs. your deck of cards"]. And that's the information I provided in my program. 

Another key component of battles, for those not in the know, is that Pokemon have specific attacks they use, and are susceptible to specific _types_ of attacks. So I wanted to be able to include those types, and be able to circle back and find those Pokemon in my "deck".

If nothing else, my 6-year-old and his friends were totally impressed. 
