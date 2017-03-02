# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/1_playing_card_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

######################
#### Playing Card ####
######################

require './spec/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe PlayingCard, :type => :model do

  context "[instantiation]" do
    describe "#initialize" do
      it "accepts a single argument in the form of a hash" do
        expect { @card }.not_to raise_error
      end
      it "accesses the hash for keys :rank and :suit (and assigns them to an instance variable!)" do
        hash = instance_double("hash")
        expect(hash).to receive(:[]).with(:rank) { random_rank }
        expect(hash).to receive(:[]).with(:suit) { random_suit }
        PlayingCard.new(hash)
      end
    end
  end

  context "[instance methods]" do
    before(:each) do
      random_new_card
    end

    describe "#rank" do
      it "displays the rank (string)" do
        expect(@card.rank).to eq @rank
      end
      it "ensures the rank is read-only" do
        expect{ @card.rank = "overwrite it" }.to raise_error(NoMethodError)
      end
    end

    describe "#suit" do
      it "returns the suit (string)" do
        expect(@card.suit).to eq @suit
      end
      it "ensures the suit is read-only" do
        expect{ @card.suit = "overwrite it" }.to raise_error(NoMethodError)
      end
    end

    describe "#face" do
      it "returns the face value (string) as a combination of rank and suit" do
        expect(@card.face).to eq @face
      end
      it "ensures the face is read-only" do
        expect{ @card.face = "overwrite it" }.to raise_error(NoMethodError)
      end
    end

    describe "#to_s" do
      it "returns the face value of the card (string)" do
        expect(@card.to_s).to eq @face
      end
    end
  end

end
