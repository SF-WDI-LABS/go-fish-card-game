# Go Fish - OO Ruby with Tests
<img src="https://media.giphy.com/media/t0zfcej3qgZeE/giphy.gif" width=200>

In this lab you will be building a card game using Ruby Classes and Rspec Tests. Our game will include classes for: `PlayingCard`, `CardDeck`, `HandOfCards`, and `CardPlayer`. By the end of this lab you should be able to simulate a multi-player game of go_fish.

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
Take a look inside `go_fish.rb` and you'll see some boilerplate code for our classes.
 
Follow the tests to get started!

Your first goal will be to build your `PlayingCard` objects. Here's some raw data (no jokers!):

```ruby
RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
SUITS = ["C", "D", "H", "S"]
SORTED_CARDS = [
    "AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S",
    "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S",
    "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S",
    "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS",
    "KC", "KD", "KH", "KS"
]
```

## Tips
You can run your game from the command line by typing:
```bash
ruby go_fish.rb
```

> **Hint**: Take a look at the "Drive Code" at the bottom of `go_fish.rb`!

You can also load your code into Pry to test your assumptions:
```bash
pry
> require 'go_fish.rb'
> card = Card.new({...})
> card.face # "AC"
```
