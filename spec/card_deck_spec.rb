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
  let(:sorted_cards) { ["AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS"] }
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
      # expect(@card_deck.cards.first.class.to_s).to eq "PlayingCard"
      expect(@card_deck.cards.first).to be_instance_of PlayingCard  ## Will this be in scope?
    end
    it "returns a complete deck" do
      expect(@card_deck.cards.map(&:face)).to match_array sorted_cards
    end
    it "returns a sorted deck (grouped by suit, with rank ascending)" do
      expect(@card_deck.cards.map(&:face)).to eq sorted_cards
    end
  end

  describe "#shuffle" do
    it "returns a shuffled array" do
      expect(@card_deck.shuffle).to be_an Array
      shuffled_cards = @card_deck.shuffle.map(&:face)
      expect(shuffled_cards).to match_array sorted_cards
      expect(shuffled_cards).not_to eq sorted_cards
    end
    it "permanently updates the order of cards in @cards" do
      shuffled_cards = @card_deck.shuffle.map(&:face)
      expect(@card_deck.cards.map(&:face)).to match_array shuffled_cards
    end
  end

  describe "#draw" do
    it "returns an Array of cards" do
      expect(@card_deck.draw).to be_an Array
      expect(@card_deck.draw.first).to be_instance_of PlayingCard
    end
    it "by default it returns one card, the last card in @cards" do
      last_card = @card_deck.cards.last
      expect(@card_deck.draw).to contain_exactly(last_card)
    end
    it "permanently removes the drawn card from @cards" do
      last_card = @card_deck.cards.last
      expect { @card_deck.draw }.to change{ @card_deck.cards.count }.by(-1)
      expect(@card_deck.cards).not_to include(last_card)
    end

    context "given an (optional) integer as an argument, specifying the number of cards to draw" do
      it "does not throw an ArgumentError" do
        expect{ @card_deck.draw(1) }.not_to raise_error
      end
      it "returns the requested number of cards" do
        expect( @card_deck.draw(2).count ).to eq 2
      end
      it "permanently removes the drawn cards from @cards" do
        n = 5
        last_cards = @card_deck.cards.last(n)
        expect { @card_deck.draw(n) }.to change{ @card_deck.cards.count }.by(-n)
        expect(@card_deck.cards).not_to include(last_cards)
      end
    end


  end

end
