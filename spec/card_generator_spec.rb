require './lib/card_generator'
require './lib/card'

RSpec.describe CardGenerator do
  describe "#initialize" do
    before do
      filename = "cards.txt"
      @card_generator = CardGenerator.new(filename)
    end

    it "should initialize the CardGenerator" do
      expect(@card_generator).to be_instance_of CardGenerator
    end

    it "have an array of cards" do
      expect(@card_generator.cards).to be_an Array
    end
  end
end
