class WheelOfFortune
  attr_reader :theme, :guesses

  def initialize(params)
    @theme = params[:theme] || ""
    @phrase = params[:phrase] || ""
    @remaining_characters = unique_chars
    @guesses = []
  end

  def to_s
    return @phrase if game_over?
    @phrase.gsub(unguessed, "_")
  end

  def can_i_have?(input)
    char = sanitize_guess(input)
    good_guess?(char)
  end

  def game_over?
    @remaining_characters.empty?
  end

  private

  def sanitize_guess(input)
    input.strip.downcase
  end

  def add_guess(guess)
    @guesses << guess unless guess.empty?
  end

  def good_guess?(char)
    !!(add_guess(char) && @remaining_characters.delete(char))
  end

  def unguessed
    Regexp.new(@remaining_characters.join('|'), Regexp::IGNORECASE)
  end

  def unique_chars
    @phrase.downcase.delete("^a-z").split("").uniq
  end
end



# # Checks to see if we executed this file from the command-line
# # e.g. `ruby simple_jepordy.rb`
# if __FILE__ == $0

#   # DRIVER CODE
#   j = WheelOfFortune.new( {theme: "card games", phrase: "Go fish"} )
#   j.can_i_have?("g")
#   j.can_i_have?("o")
#   p j
#   puts j # calls j.to_s

# end
