# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/4_card_player_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

#####################
#### Card Player ####
#####################

require './spec/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe CardPlayer, :type => :model do

  context "[instantiation]" do
    describe "#initialize" do
      it "accepts a single argument in the form of a hash" do
        expect { CardPlayer.new({}) }.not_to raise_error
      end
      it "accesses the hash for the value at key :hand (and assigns it to an instance variable!)" do
        watched_hash = instance_double("hash")
        expect(watched_hash).to receive(:[]).with(:hand) { random_new_hand }
        CardPlayer.new(watched_hash)
      end
    end
  end

  context "[instance methods]" do
    describe "#hand" do
      it "returns the player's hand (a HandOfCards object)" do
        hand = random_new_hand
        watched_hash = instance_double("hash")
        expect(watched_hash).to receive(:[]).with(:hand) { hand }
        player = CardPlayer.new(watched_hash)
        expect( player.hand ).to be( hand )
      end
      it "ensures the hand is read-only" do
        hand = random_new_hand
        expect{ @card.hand = "overwrite it" }.to raise_error(NoMethodError)
      end
    end
  end

end
