class CardGame
end

module Drawable
  attr_reader :cards

  def initialize(*args)
    @cards = []
    post_initialize(*args)
  end

  # overridden by class
  def post_initialize(*args)
    nil
  end

  def draw(n=1)
    @cards.pop(n).reverse
  end

  def draw_one
    draw.first
  end

  def push(card)
    card.deck = self
    @cards << card
  end
end

class CardDeck
  include Drawable

  def post_initialize(shuffled=true)
    generate_cards
    shuffle if shuffled
  end

  def to_s
    @cards.map {|card| card.face }
  end

  def shuffle
    @cards.shuffle!
  end

  private

  def generate_cards(decks=1)
    ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["C", "D", "H", "S"]

    @cards.clear

    decks.times do |i|
      ranks.each do |rank|
        suits.each do |suit|
            self.push( PlayingCard.new(rank: rank, suit: suit) )
        end
      end
    end
  end

end


class PlayingCard
  attr_reader :rank, :suit, :face
  attr_accessor :deck

  def initialize(args)
    @rank = args[:rank]
    @suit = args[:suit]
    @face = @rank + @suit
  end

  def to_s
    @face
  end
end

class HandOfCards
  include Drawable

  def post_initialize(starting_cards=[])
    @cards += starting_cards
  end

  def any?(rank: nil, suit: nil)
    return false if rank.nil? and suit.nil?
    return @cards.any? {|c| c.rank == rank && c.suit == suit } if rank and suit
    return @cards.any? {|c| c.rank == rank } if rank
    @cards.any? {|c| c.suit == suit }
  end

  def take!(rank: nil, suit: nil)
    return [] if rank.nil? and suit.nil?
    return @cards.select! {|c| c.rank == rank && c.suit == suit } if rank and suit
    return @cards.select! {|c| c.rank == rank } if rank
    @cards.select! {|c| c.suit == suit }
  end
end

class CardPlayer

  attr_reader :hand

  def initialize(args)
    @hand = args[:hand]
  end

end


# Driver Code
if __FILE__ == $0
  # g = CardGame.new(players: 2)
  # p g.players

  deck = CardDeck.new
  # puts "cards: #{deck.cards}"
  puts "cards: #{deck}"
  # puts "shuffled: #{deck.shuffle}"
  puts "draw: #{deck.draw_one}"
  # p deck.draw(2)
end
