# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/2_card_deck_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

###################
#### Card Deck ####
###################

require './spec/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe CardDeck, :type => :model do

  context "[instantiation]" do
    describe "#initialize" do
      it "accepts an optional boolean indicating whether to shuffle" do
        expect { CardDeck.new }.not_to raise_error
        expect { CardDeck.new(true) }.not_to raise_error
        expect { CardDeck.new(false) }.not_to raise_error
      end

      it "results in a deck with shuffled cards if the argument is true" do
        deck1 = CardDeck.new(true)
        deck2 = CardDeck.new(true)
        expect(deck1.cards.map(&:face)).to match_array deck2.cards.map(&:face)
        expect(deck1.cards.map(&:face)).not_to eq deck2.cards.map(&:face)
      end

      it "results in a deck with not-shuffled cards if the argument is false" do
        deck1 = CardDeck.new(false)
        deck2 = CardDeck.new(false)
        expect(deck1.cards.map(&:face)).to eq deck2.cards.map(&:face)
      end
      it "by default results in a deck with shuffled cards if no argument is passed" do
        deck1 = CardDeck.new
        deck2 = CardDeck.new
        expect(deck1.cards.map(&:face)).to match_array deck2.cards.map(&:face)
        expect(deck1.cards.map(&:face)).not_to eq deck2.cards.map(&:face)
      end
    end
  end

  context "[instance methods]" do
    before(:each) do
      new_deck
    end

    describe "#cards" do
      it "returns an array" do
        expect(@card_deck.cards).to be_an Array
      end
      it "ensures that @cards is read-only" do
        expect{ @card_deck.cards = "overwrite it" }.to raise_error(NoMethodError)
      end
      it "populates @cards with 52 instances of class PlayingCard (no jokers)" do
        expect(@card_deck.cards.count).to eq 52 # deck_size
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
      it "returns a shuffled array of cards" do
        expect(@card_deck.shuffle).to be_an Array
        shuffled_cards = @card_deck.shuffle.map(&:face)
        expect(shuffled_cards).to match_array sorted_cards
        expect(shuffled_cards).not_to eq sorted_cards
      end
      it "permanently updates the order of cards in @cards" do
        shuffled_cards = @card_deck.shuffle.map(&:face)
        expect(@card_deck.cards.map(&:face)).to eq shuffled_cards
      end
    end

    describe "#draw" do
      it "returns an array of cards" do
        expect(@card_deck.draw).to be_an Array
      end
      it "by default it returns an array of one card, the last card in @cards" do
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
          n = rand(deck_size)+1
          expect( @card_deck.draw(n).count ).to eq n
        end
        it "permanently removes the drawn cards from @cards" do
          n = rand(deck_size)+1
          last_cards = @card_deck.cards.last(n)
          expect { @card_deck.draw(n) }.to change{ @card_deck.cards.count }.by(-n)
          expect(@card_deck.cards).not_to include(last_cards)
        end
      end

      context "given an integer larger than the number of avilable cards in @cards" do
        it "returns as many cards as it can" do
          expect( @card_deck.draw(100).count ).to eq deck_size
          expect( @card_deck.draw(1).count ).to eq 0
        end
      end
    end

    describe "#draw_one" do
      context "given remaining cards" do
        it "returns a single playing card" do
          expect(@card_deck.draw_one).to be_instance_of PlayingCard
        end
        it "permanently removes the drawn card from @cards" do
          last_card = @card_deck.cards.last
          expect { @card_deck.draw_one }.to change{ @card_deck.cards.count }.by(-1)
          expect(@card_deck.cards).not_to include(last_card)
        end
      end
      context "given no remaining cards" do
        it "returns nil" do
          deck_size.times do
            @card_deck.draw_one
          end
          expect(@card_deck.draw_one).to eq nil
        end
      end
    end

    describe "#push" do
      it "accepts any number of playing card as arguments" do
        card = random_stubbed_card
        expect{ @card_deck.push(card) }.not_to raise_error(ArgumentError)
        expect{ @card_deck.push(card, card, card, card) }.not_to raise_error(ArgumentError)
      end
      it "adds the card to the deck (one)" do
        card = random_stubbed_card
        expect{ @card_deck.push(card) }.to change{ @card_deck.cards.count }.by(1)
        expect(@card_deck.cards).to include(card)
      end
      it "adds the cards to the deck (many)" do
        four_cards = [random_stubbed_card, random_stubbed_card, random_stubbed_card, random_stubbed_card]
        expect{ @card_deck.push(*four_cards) }.to  change{ @card_deck.cards.count }.by(4)
        expect(@card_deck.cards).to include(*four_cards)
      end
    end
  end

end
