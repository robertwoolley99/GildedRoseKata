# Gilded Rose Refactoring Kata

This is a well known Kata with requirements from ["Gilded Rose Requirements"](https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/master/GildedRoseRequirements.txt)

## Approach

I initially wrote a number of tests to clarify that the code was doing what the requirements said it should.

Once the tests were all green I then started hacking around.  The kata doesn't allow modification of the Item object so I focussed on GildedRose.

I had issues with github so the different commits are missing on this repo but broadly the approach was:

* Comment out existing code

* Run tests - and watch them all break.

* Work out a simple functionality case  - e.g. decrement the quality by 1.

* Write some code.

* Run the tests.

* Look at which tests break and which now pass.

* Work out why tests break

* Write some more code so fewer tests break.  Or refactor prompted by either readability of the code or Rubocop.

The complexity of the original code made life exceptionally difficult. Rather than trying to substitute it line for line, it was easier to hack around - i.e. go TDD.

Rubocop was an excellent tool, tirelessly nagging me to get my code clean.  I ended up splitting methods as required to get branching complexity down. I'm very keen on linters.

I then implemented the additional functionality - conjured items.

## Tools Used

I worked with Rspec and Rubocop.
