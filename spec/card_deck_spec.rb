# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/go_fish_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

###################
#### Card Deck ####
###################

RSpec.describe CardDeck, :type => :model do

  # let(:ranks) { ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"] }
  # let(:suits) { ["C", "D", "H", "S"] }
  let(:sorted_deck) { ["AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS"] }
  # let(:face_regex) { /(10|[1-9]|[AJQK])([CDHS])/ }

  # def random_suit
  #   @suit = suits.sample
  # end

  # def random_rank
  #   @rank = ranks.sample
  # end

  def new_deck(shuffled=false)
    @card_deck = CardDeck.new(shuffled)
  end

  before(:each) do
    new_deck
  end

  describe "#initialize" do
    it "accepts an optional boolean" do
      expect { CardDeck.new }.not_to raise_error
      expect { CardDeck.new(true) }.not_to raise_error
      expect { CardDeck.new(false) }.not_to raise_error
    end
  end

  describe "#cards" do
    it "returns an array" do
      expect(@card_deck.cards).to be_an Array
    end
    it "ensures that @cards is read-only" do
      expect{ @card_deck.cards = "overwrite it" }.to raise_error(NoMethodError)
    end
    it "populates @cards with 52 instances of class PlayingCard (no jokers)" do
      expect(@card_deck.cards.count).to eq 52
      expect(@card_deck.cards.first).to be_instance_of PlayingCard
    end
    it "returns a complete deck" do
      expect(@card_deck.cards.map(&:face)).to match_array sorted_deck
    end
    it "returns a sorted deck (grouped by suit, with rank ascending)" do
      expect(@card_deck.cards.map(&:face)).to eq sorted_deck
    end
  end

end
