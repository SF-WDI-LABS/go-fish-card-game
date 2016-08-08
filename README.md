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
rspec spec/1_playing_card_spec.rb
# or, run only test that match your search
rspec spec/2_card_deck_spec.rb -e "shuffle"
```

## Building the Game

Take a look inside `go_fish.rb` and you'll see some boilerplate code for our classes.

#### Class Interfaces

Your classes will have the following interfaces (take the time to study these closely):

| `PlayingCard` | `CardDeck`    | `HandOfCards` | `CardPlayer`  |
| :----         | :----         | :----         | :----         |
| `initialize`  | `initialize`  | `initialize`  | `initialize`  |
| `rank`        | `cards`       | `cards`       | `hand`        |
| `suit`        | `to_s`        | `to_s`        |               |
| `face`        | `shuffle`     | `shuffle`     |               |
| `to_s`        | `draw`        | `draw`        |               |
|               | `draw_one`    | `draw_one`    |               |
|               | `push`        | `push`        |               |
|               |               | `any?`        |               |
|               |               | `take!`       |               |

Together, these classes and methods will allow us to simulate game play, using the following "Driver Code":

```
# GAME SETUP

deck = CardDeck.new
deck.shuffle

card = deck.draw_one
two_cards = deck.draw(2)

cards1 = deck.draw(5)
h1 = HandOfCards.new(cards1)
p1 = CardPlayer.new(hand: h1)

cards2 = deck.draw(5)
h2 = HandOfCards.new(cards2)
p2 = CardPlayer.new(hand: h2 )


# GAME PLAY

wanted_rank = "3"
puts "p1, do you have any... #{wanted_rank}'s?"
if p1.hand.any?(rank: wanted_rank)
    cards = p1.hand.take!(rank: wanted_rank)
    p2.hand.push(*cards)
else
    puts "Go Fish"
    drawn_card = deck.draw
    p2.hand.push(drawn_card)
end

```

#### Playing Cards
Your first goal will be to build your `PlayingCard` objects. Here's some raw data for you to copy paste (no jokers!):

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

**Follow the tests to get started!**

## Tips
It's easy to get lost in test output / lose sight of the "big picture". Make sure you understand what your goal is before you dive in!

You can run your game's Driver Code from the command line by typing:
```bash
ruby go_fish.rb
```

> **Hint**: Take a look at the "Drive Code" at the bottom of `go_fish.rb`!

You can also load your code into Pry to test your assumptions:
```bash
pry
> load 'go_fish.rb'
> card = Card.new({...})
> card.face # "AC"
```
