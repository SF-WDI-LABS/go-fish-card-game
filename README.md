# Wheel of Fortune - OO Ruby with Tests
<img src="https://media.giphy.com/media/2SX8z3bnvJe3C/giphy.gif" width=400>

In this lab you will be building a simplified Wheel of Fortune game using Ruby Classes and Rspec Tests.

## Setup
First, make sure you've installed the `rspec` gem.

From the command line (inside the cloned repo directory) run:

```bash
gem install rspec # individually install the rspec gem
# or
bundle install # install all the gems listed in the Gemfile
```

Next, check that the rspec tests are working (they should be failing!):

```bash
rspec
# or
rspec spec/wheel_of_fortune_spec.rb
```

## Building the Game
Take a look inside `wheel_of_fortune.rb` and you'll see some boilerplate code for our `WheelOfFortune` class.

Instance of `WheelOfFortune` will have three important methods:

* making guesses ("Can I have a 'z'...?")
* printing the game board ("Wh__l of Fortun_")
* checking if the game is over (true/false)
 
Follow the tests to get started!

## Tips
You can run your game from the command line by typing:
```bash
ruby wheel_of_fortune.rb
```

**Hint**: Take a look at the Drive Code at the bottom of the file!

You can also load your code into Pry to test your assumptions:
```bash
pry
> require 'wheel_of_fortune.rb'
> w = WheelOfFortune.new({...})
> w.to_s
```


## Mega Bonus
It turns out Wheel of Fortune and Hangman have a lot in common! Can you take this lab even further, and build a hangman game?

          _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      / \
     |
    _|___
    h_ng m_n
