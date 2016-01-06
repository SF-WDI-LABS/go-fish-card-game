# THIS FILE PERFORMS RSPEC TESTS ON `wheel_of_fortune.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/wheel_of_fortune_spec.rb`

# require "./solution/wheel_of_fortune.rb"   # use this line to see passing tests
require "./wheel_of_fortune.rb"              # use this line to test your code

##########################
#### Wheel of Fortune ####
##########################

RSpec.describe WheelOfFortune, :type => :model do

  let(:theme) { "card games" }
  let(:phrase) { "Go fish" }
  before(:each) do
    @game = WheelOfFortune.new({theme: theme, phrase: phrase})
  end

  describe "#initialize" do
    it "accepts a single argument in the form of a hash" do
      expect { @game }.not_to raise_error #lazy eval initalizes game here
    end
    it "accesses the hash for keys :phrase and :theme (and assigns them to an instance variable!)" do
      hash = instance_double("Hash")
      expect(hash).to receive(:[]).with(:phrase)
      expect(hash).to receive(:[]).with(:theme)
      WheelOfFortune.new(hash)
    end
  end

  describe "#theme" do
    it "displays the theme" do
      expect(@game.theme).to eq theme
    end
    it "ensures the theme is read-only" do
      expect{ @game.theme = "overwrite it" }.to raise_error(NoMethodError)
    end
  end

  describe "#guesses" do
    it "starts out as an empty array" do
      guesses = @game.guesses
      expect(guesses).to be_an Array
      expect(guesses.empty?).to be true
    end
  end

  describe "#can_i_have?" do
    it "accepts a single argument in the form of a string (the guess)" do
      expect { @game.can_i_have?("x") }.to_not raise_error
    end
    it "returns true if the guess is in the original phrase" do
      expect( @game.can_i_have?("g") ).to be true
    end
    it "returns false if the guess is not in the original phrase" do
      expect( @game.can_i_have?("z") ).to be false
    end
    it "converts uppercase letters to lowercase" do
      expect( @game.can_i_have?("H") ).to be true
    end
    it "adds each guess to guesses" do
      @game.can_i_have?("x")
      @game.can_i_have?("g")
      expect( @game.guesses ).to include("x", "g")
    end
  end

  describe "#to_s" do
    it "displays the original phrase" do
      str = @game.to_s
      expect(str).to be_a String
      expect(str.length).to eq phrase.length
    end
    it "displays underscores in place of (unguessed) characters in the phrase" do
      str = @game.to_s
      expect(str).to eq "__ ____" # "Go fish"

      # Just in case we've hard coded "Go fish" somewhere...
      str = WheelOfFortune.new({theme: "lyrical expression", phrase: "pokerface"}).to_s
      expect(str).to eq "_________" # "pokerface"
    end
    it "displays correctly guessed letters in their original position(s)" do
      @game.can_i_have?("o")
      expect( @game.to_s ).to match "_o ____"
      @game.can_i_have?("f")
      expect( @game.to_s ).to match "_o f___"
    end
    it "displays correctly guessed letters in their original case (upper/lower)" do
      @game.can_i_have?("g")
      expect( @game.to_s ).to match "G_ ____"
    end
    it "matches the original phrase when the game is over" do
      @game.can_i_have?("g")
      @game.can_i_have?("o")
      @game.can_i_have?("f")
      @game.can_i_have?("i")
      @game.can_i_have?("s")
      @game.can_i_have?("h")
      expect(@game.to_s).to match phrase
    end
  end

  describe "#game_over?" do
    it "returns true if the phrase is complete" do
      @game.can_i_have?("g")
      @game.can_i_have?("o")
      @game.can_i_have?("f")
      @game.can_i_have?("i")
      @game.can_i_have?("s")
      @game.can_i_have?("h")
      expect( @game.game_over? ).to be true
    end
    it "returns false if the phrase is incomplete" do
      expect( @game.game_over? ).to be false
      @game.can_i_have?("g")
      expect( @game.game_over? ).to be false
      @game.can_i_have?("o")
      expect( @game.game_over? ).to be false
      @game.can_i_have?("f")
      expect( @game.game_over? ).to be false
      @game.can_i_have?("i")
      expect( @game.game_over? ).to be false
      @game.can_i_have?("s")
      expect( @game.game_over? ).to be false
      @game.can_i_have?("z")
      expect( @game.game_over? ).to be false
    end
  end

end
