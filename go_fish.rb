class PlayingCard
  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K).freeze
  SUITS = %w(C D H S).freeze
  SORTED_CARDS = %w(
    AC AD AH AS 2C 2D 2H 2S 3C 3D 3H 3S
    4C 4D 4H 4S 5C 5D 5H 5S 6C 6D 6H 6S
    7C 7D 7H 7S 8C 8D 8H 8S 9C 9D 9H 9S
    10C 10D 10H 10S JC JD JH JS QC QD QH QS
    KC KD KH KS
  ).freeze

  attr_reader :rank, :suit

  def initialize(hash)
    @suit = hash[:suit]
    @rank = hash[:rank]
  end

  def face
    @rank + @suit
  end

  alias to_s face
end

class CardDeck
  def initialize(_new = true)
    @cards = []
    populate_cards
  end

  def populate_cards
    %w(
      AC AD AH AS 2C 2D 2H 2S 3C 3D 3H 3S
      4C 4D 4H 4S 5C 5D 5H 5S 6C 6D 6H 6S
      7C 7D 7H 7S 8C 8D 8H 8S 9C 9D 9H 9S
      10C 10D 10H 10S JC JD JH JS QC QD QH QS
      KC KD KH KS
    ).each { |c| @cards.push(PlayingCard.new(rank: c[0...-1], suit: c[-1])) }
    @cards
  end

  attr_reader :cards

  def shuffle
    @cards.shuffle!
  end

  def draw(n = 1)
    drawn = []
    n.times do
      drawn << @cards.reverse.shift unless @cards.empty?
      @cards.pop
    end
    drawn
  end

  def draw_one
    draw[0]
  end

  def push(*card)
    @cards << card
    @cards.flatten!
  end
end

class HandOfCards
  def initialize(arr = [])
    @cards = arr
  end

  attr_reader :cards

  def draw(n = 1)
    drawn = []
    n.times do
      drawn << @cards.pop unless @cards.empty?
    end
    drawn
  end

  def draw_one
    draw[0]
  end

  def to_s
    @cards.map(&:face).join(' ')
  end

  def any?(card)
    @cards.each { |c| return true if c.face.index(card[:rank] || card[:suit]) }
    false
  end

  def take!(rank: '', suit: '')
    face = "#{rank}#{suit}"
    matches = []
    @cards.delete_if { |c| matches << c if c.face.match(face) }
    matches
  end
end

class CardPlayer
  def initialize(data = {})
    @hand = data[:hand]
  end

  attr_reader :hand
end

# Driver Code
if __FILE__ == $PROGRAM_NAME
  puts 'This will only print if you run `ruby go_fish.rb`'
  # deck = CardDeck.new
  # # # puts "cards: #{deck.cards}"
  # # # puts "cards: #{deck}"
  # # # puts "shuffled: #{deck.shuffle}"
  # # puts "one drawn card: #{deck.draw_one}"
  # # puts "two drawn cards: #{deck.draw(2)}"

  # cards1 = deck.draw(5)
  # cards2 = deck.draw(5)
  # # # puts "cards1: #{cards1.join(" ")}"
  # # # puts "cards2: #{cards2.join(" ")}"

  # h1 = HandOfCards.new(cards1)
  # h2 = HandOfCards.new(cards2)

  # puts "hand1: #{h1}"
  # puts "hand2: #{h2}"

  # p1 = CardPlayer.new(hand: h1)
  # p2 = CardPlayer.new(hand: HandOfCards.new(deck.draw(5)) )

  # puts "Hands: [ #{p1.hand} ], [ #{p2.hand} ] (before)"

  # ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  # ranks.each do |rank|
  #   print "p1, do you have any... #{rank}'s?"
  #   if p1.hand.any?(rank: rank)
  #     cards = p1.hand.take!(rank: rank)
  #     print " -- YES: [ #{ cards.join(" ") } ]\n"
  #     p2.hand.push(*cards)
  #     break
  #   end
  #   print " -- NO!\n"
  # end

  # puts "Hands: [ #{p1.hand} ], [ #{p2.hand} ] (after)"
end
