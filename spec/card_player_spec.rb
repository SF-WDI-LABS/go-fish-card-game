# THIS FILE PERFORMS RSPEC TESTS ON `go_fish.rb`
# TO RUN YOUR TESTS TYPE: `rspec spec/go_fish_spec.rb`

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

end
