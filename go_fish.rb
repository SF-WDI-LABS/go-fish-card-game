# class GoFish
# end

class CardDeck
  attr_reader :cards

  def initialize(shuffled=true)
    @cards = []
    generate_cards
    shuffle if shuffled
  end

  def shuffle
    @cards.shuffle!
  end

  def draw(n=1)
    @cards.pop(n).reverse
  end

  def draw_one
    draw.first
  end

  def to_s
    @cards.map {|card| card.face }
  end

  def push(card)
    card.deck = self
    @cards << card
  end

  def discard(card)
    @discards << card
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

# class CardHand
#   def initialize
#     @cards = []
#   end
# end


# Driver Code
if __FILE__ == $0
  # g = GoFish.new(players: 2)
  # p g.players

  deck = CardDeck.new
  # puts "cards: #{deck.cards}"
  puts "cards: #{deck}"
  # puts "shuffled: #{deck.shuffle}"
  puts "draw: #{deck.draw_one}"
  # p deck.draw(2)
end
