# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/go_fish_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

#######################
#### Hand of Cards ####
#######################

require './spec/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe HandOfCards, :type => :model do

  context "[instantiation]" do
    describe "#initialize" do
      it "accepts an optional array" do
        expect { HandOfCards.new }.not_to raise_error
        expect { HandOfCards.new([]) }.not_to raise_error
      end
    end
  end

  context "[instance methods]" do
    before(:each) do
      random_new_hand
    end

    describe "#cards" do
      it "returns an array" do
        expect(@hand.cards).to be_an Array
      end
      it "ensures that @cards is read-only" do
        expect{ @hand.cards = "overwrite it" }.to raise_error(NoMethodError)
      end
      context "when the hand was created with an array of playing cards, the return array" do
        it "is not the same array (i.e. container) as the one it was given" do
          expect(@hand.cards).not_to be @starting_cards
        end
        it "contains the (optionally) provided playing cards" do
          card = random_new_card
          expect( new_hand([card]).cards ).to include(card)
        end
      end
    end

    describe "#draw" do
      it "returns an array of cards" do
        expect(@hand.draw).to be_an Array
      end
      it "by default it returns an array of one card, the last card in @cards" do
        last_card = @hand.cards.last
        expect(@hand.draw).to contain_exactly(last_card)
      end
      it "permanently removes the drawn card from @cards" do
        last_card = @hand.cards.last
        expect { @hand.draw }.to change{ @hand.cards.count }.by(-1)
        expect(@hand.cards).not_to include(last_card)
      end

      context "given an (optional) integer as an argument, specifying the number of cards to draw" do
        it "does not throw an ArgumentError" do
          expect{ @hand.draw(1) }.not_to raise_error
        end
        it "returns the requested number of cards" do
          n = rand(@hand_size)+1
          expect( @hand.draw(n).count ).to eq n
        end
        it "permanently removes the drawn cards from @cards" do
          n = rand(@hand_size)+1
          last_cards = @hand.cards.last(n)
          expect { @hand.draw(n) }.to change{ @hand.cards.count }.by(-n)
          expect(@hand.cards).not_to include(last_cards)
        end
      end

      context "given an integer larger than the number of avilable cards in @cards" do
        it "returns as many cards as it can" do
          expect( @hand.draw(100).count ).to eq @hand_size
          expect( @hand.draw(1).count ).to eq 0
        end
      end
    end

    describe "#draw_one" do
      context "given remaining cards" do
        it "returns a single playing card" do
          expect(@hand.draw_one).to be_instance_of PlayingCard
        end
        it "permanently removes the drawn card from @cards" do
          last_card = @hand.cards.last
          expect { @hand.draw_one }.to change{ @hand.cards.count }.by(-1)
          expect(@hand.cards).not_to include(last_card)
        end
      end
      context "given no remaining cards" do
        it "returns nil" do
          @hand_size.times do
            @hand.draw_one
          end
          expect(@hand.draw_one).to eq nil
        end
      end
    end

    describe "#push" do
      it "accepts any number of playing cards as arguments" do
        expect{ @hand.push(random_new_card) }.not_to raise_error(ArgumentError)
        expect{ @hand.push(random_new_card, random_new_card) }.not_to raise_error(ArgumentError)
        expect{ @hand.push(random_new_card, random_new_card, random_new_hand) }.not_to raise_error(ArgumentError)
      end
    end

    describe "#to_s" do
      it "returns all the card faces in the hand as a single string" do
        expect( @hand.to_s ).to eq @hand.cards.map(&:face).join(" ")
      end
    end

    describe "#any?" do
      context "given a rank (string) to search for" do
        it "returns a boolean indicating whether any card with that rank is present" do
          card = @hand.cards.sample
          expect( @hand.any?(rank: card.rank) ).to be true

          missing_rank = ["X", "Y", "Z"].sample
          expect( @hand.any?(rank: missing_rank) ).to be false
        end
      end
      context "given a suit (string) to search for" do
        it "returns a boolean indicating whether any card with that suit is present" do
          card = @hand.cards.sample
          expect( @hand.any?(suit: card.suit) ).to be true

          missing_suit = ["X", "Y", "Z"].sample
          expect( @hand.any?(suit: missing_suit) ).to be false
        end
      end
    end

    describe "#take!" do
      context "given a rank (string) to search for" do
        it "returns an array of all available cards with that rank" do
          card = @hand.cards.sample
          selection = @hand.take!(rank: card.rank)
          expect( selection ).to include(card)

          missing_rank = ["X", "Y", "Z"].sample
          expect( @hand.take!(rank: missing_rank) ).to be_empty
        end
        it "permanently removes the selected cards from the hand (destructive)" do
          card = @hand.cards.sample
          selection = @hand.take!(rank: card.rank)
          expect( @hand.cards ).to_not include(*selection)
        end
      end
      context "given a suit (string) to search for" do
        it "returns an array of all available cards with that suit" do
          card = @hand.cards.sample
          selection = @hand.take!(suit: card.suit)
          expect( selection ).to include(card)

          missing_suit = ["X", "Y", "Z"].sample
          expect( @hand.take!(suit: missing_suit) ).to be_empty
        end
        it "permanently removes the selected cards from the hand (destructive)" do
          card = @hand.cards.sample
          selection = @hand.take!(suit: card.suit)
          expect( @hand.cards ).to_not include(*selection)
        end
      end
    end
  end

end
