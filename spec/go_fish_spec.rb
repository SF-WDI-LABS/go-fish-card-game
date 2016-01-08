# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/go_fish_spec.rb`

# require "./solution/go_fish.rb"   # use this line to see passing tests
require "./go_fish.rb"              # use this line to test your code

#################
#### Go Fish ####
#################

RSpec.describe PlayingCard, :type => :model do

  let(:ranks) { ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"] }
  let(:suits) { ["C", "D", "H", "S"] }
  let(:sorted_deck) { ["AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS"] }
  let(:face_regex) { /(10|[1-9]|[AJQK])([CDHS])/ }

  def random_suit
    @suit = suits.sample
  end

  def random_rank
    @rank = ranks.sample
  end

  def random_new_card(rank=random_rank, suit=random_suit)
    @face = rank + suit
    @card = PlayingCard.new(rank: rank, suit: suit)
  end

  before(:each) do
    random_new_card
  end

  describe "#initialize" do
    it "accepts a single argument in the form of a hash" do
      expect { @card }.not_to raise_error #lazy eval initalizes card here
    end
    it "accesses the hash for keys :rank and :suit (and assigns them to an instance variable!)" do
      hash = instance_double("hash")
      expect(hash).to receive(:[]).with(:rank) { random_rank }
      expect(hash).to receive(:[]).with(:suit) { random_suit }
      PlayingCard.new(hash)
    end
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

  # let(:theme) { "card cards" }
  # let(:phrase) { "Go fish" }
  # before(:each) do
  #   @card = PlayingCard.new({theme: theme, phrase: phrase})
  # end

  # describe "#theme" do
  #   it "returns the theme" do
  #     expect(@card.theme).to eq theme
  #   end
  #   it "ensures the theme is read-only" do
  #     expect{ @card.theme = "overwrite it" }.to raise_error(NoMethodError)
  #   end
  # end

  # describe "#guesses" do
  #   it "starts out as an empty array" do
  #     guesses = @card.guesses
  #     expect(guesses).to be_an Array
  #     expect(guesses.empty?).to be true
  #   end
  # end

  # describe "#can_i_have?" do
  #   it "accepts a single argument in the form of a string (the guess)" do
  #     expect { @card.can_i_have?("x") }.to_not raise_error
  #   end
  #   it "returns true if the guess is in the original phrase" do
  #     expect( @card.can_i_have?("g") ).to be true
  #   end
  #   it "returns false if the guess is not in the original phrase" do
  #     expect( @card.can_i_have?("z") ).to be false
  #   end
  #   it "converts uppercase letters to lowercase" do
  #     expect( @card.can_i_have?("H") ).to be true
  #   end
  #   it "adds each guess to guesses" do
  #     @card.can_i_have?("x")
  #     @card.can_i_have?("g")
  #     expect( @card.guesses ).to include("x", "g")
  #   end
  # end

  # describe "#to_s" do
  #   it "displays the original phrase" do
  #     str = @card.to_s
  #     expect(str).to be_a String
  #     expect(str.length).to eq phrase.length
  #   end
  #   it "displays underscores in place of (unguessed) characters in the phrase" do
  #     str = @card.to_s
  #     expect(str).to eq "__ ____" # "Go fish"

  #     # Just in case we've hard coded "Go fish" somewhere...
  #     str = GoFish.new({theme: "lyrical expression", phrase: "pokerface"}).to_s
  #     expect(str).to eq "_________" # "pokerface"
  #   end
  #   it "displays correctly guessed letters in their original position(s)" do
  #     @card.can_i_have?("o")
  #     expect( @card.to_s ).to match "_o ____"
  #     @card.can_i_have?("f")
  #     expect( @card.to_s ).to match "_o f___"
  #   end
  #   it "displays correctly guessed letters in their original case (upper/lower)" do
  #     @card.can_i_have?("g")
  #     expect( @card.to_s ).to match "G_ ____"
  #   end
  #   it "matches the original phrase when the card is over" do
  #     @card.can_i_have?("g")
  #     @card.can_i_have?("o")
  #     @card.can_i_have?("f")
  #     @card.can_i_have?("i")
  #     @card.can_i_have?("s")
  #     @card.can_i_have?("h")
  #     expect(@card.to_s).to match phrase
  #   end
  # end

  # describe "#card_over?" do
  #   it "returns true if the phrase is complete" do
  #     @card.can_i_have?("g")
  #     @card.can_i_have?("o")
  #     @card.can_i_have?("f")
  #     @card.can_i_have?("i")
  #     @card.can_i_have?("s")
  #     @card.can_i_have?("h")
  #     expect( @card.card_over? ).to be true
  #   end
  #   it "returns false if the phrase is incomplete" do
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("g")
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("o")
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("f")
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("i")
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("s")
  #     expect( @card.card_over? ).to be false
  #     @card.can_i_have?("z")
  #     expect( @card.card_over? ).to be false
  #   end
  # end

# end
