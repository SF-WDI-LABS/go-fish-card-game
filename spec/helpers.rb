#################################
# DO NOT USE IN CODE CHALLENGE! #
#################################

# CONFIG
RSpec::Expectations.configuration.warn_about_potential_false_positives = false

# TEST HELPER MODULES

module PlayingCardHelper
  RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  SUITS = ["C", "D", "H", "S"]
  SORTED_CARDS = [
      "AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S",
      "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S",
      "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S",
      "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS",
      "KC", "KD", "KH", "KS"
  ]
  FACE_REGEX = /(10|[1-9]|[AJQK])([CDHS])/

  def face_regex
    FACE_REGEX
  end

  def ranks
    RANKS
  end

  def suits
    SUITS
  end

  def sorted_cards
    SORTED_CARDS
  end

  def deck_size
    SORTED_CARDS.count
  end

  def random_suit
    @suit = suits.sample
  end

  def random_rank
    @rank = ranks.sample
  end

  def random_new_card(rank=random_rank, suit=random_suit)
    @face = rank + suit
    @card = PlayingCard.new(rank: rank, suit: suit)
  end

  def random_stubbed_card(rank=random_rank, suit=random_suit)
    @face = rank + suit
    @card = instance_double("PlayingCard", rank: rank, suit: suit)
  end

end

#

module CardDeckHelper
  def new_deck(shuffled=false)
    @card_deck = CardDeck.new(shuffled)
  end
end

#

module CardPlayerHelper
  # def new_card_player(args)
  #   @card_deck = CardDeck.new(args)
  # end
end

#

module HandOfCardsHelper
  def random_new_hand(size=5)
    @hand_size = size || rand(5)+1
    @hand = HandOfCards.new([random_new_card, random_new_card, random_new_card, random_new_card, random_new_card])
  end

  def new_hand(starting_cards=[])
    @starting_cards = starting_cards
    @hand = HandOfCards.new(starting_cards)
  end
end

#

module Helpers
  include PlayingCardHelper
  include CardDeckHelper
  include HandOfCardsHelper
  include CardPlayerHelper
end

#################################
# DO NOT USE IN CODE CHALLENGE! #
#################################
