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

  def push(*cards)
    @cards.push(*cards)
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

  def to_s
    @cards.join(" ")
  end

  def any?(rank: "", suit: "")
    face = (rank + suit).upcase
    return false if face.empty?
    @cards.any? {|c| c.face.match(face) }
  end

  def take!(rank: "", suit: "")
    taken = []
    face = (rank + suit).upcase
    return taken if face.empty?

    @cards.delete_if do |c|
      taken.push(c) if c.face.match(face)
    end

    taken
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
  puts "This will only print if you run `ruby go_fish.rb`"
  deck = CardDeck.new
  # # puts "cards: #{deck.cards}"
  # # puts "cards: #{deck}"
  # # puts "shuffled: #{deck.shuffle}"
  # puts "one drawn card: #{deck.draw_one}"
  # puts "two drawn cards: #{deck.draw(2)}"

  cards1 = deck.draw(5)
  cards2 = deck.draw(5)
  # # puts "cards1: #{cards1.join(" ")}"
  # # puts "cards2: #{cards2.join(" ")}"

  h1 = HandOfCards.new(cards1)
  h2 = HandOfCards.new(cards2)

  puts "hand1: #{h1}"
  puts "hand2: #{h2}"

  p1 = CardPlayer.new(hand: h1)
  p2 = CardPlayer.new(hand: h2 )

  puts "Hands: [ #{p1.hand} ], [ #{p2.hand} ] (before)"

  ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  ranks.each do |rank|
    print "p1, do you have any... #{rank}'s?"
    if p1.hand.any?(rank: rank)
      cards = p1.hand.take!(rank: rank)
      print " -- YES: [ #{ cards.join(" ") } ]\n"
      p2.hand.push(*cards)
      break
    end
    print " -- NO!\n"
  end

  puts "Hands: [ #{p1.hand} ], [ #{p2.hand} ] (after)"
end
