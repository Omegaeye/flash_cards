require './lib/turn'
require './lib/card'

RSpec.describe Turn do
  describe "#initialize" do
    before do
      @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @turn = Turn.new("Juneau", @card)
    end

    it "should initialize a Turn" do
      expect(@turn).to be_instance_of(Turn)
    end

    it "should have a card" do
      expect(@turn.card).to eq(@card)
    end
    
    it "should have a guess" do
      expect(@turn.guess).to eq("Juneau")
    end
  end

  describe "#correct?" do
    before do
      @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @turn = Turn.new("Juneau", @card)
    end

    it "should returns correct if the guest matches the answer" do
      expect(@turn.correct?).to be true
    end
  end

  describe "#feedback" do
    it "should return Correct! if correct?" do
      @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @turn = Turn.new("Juneau", @card)

      expect(@turn.feedback).to eq("Correct!")
    end

    it "should return Incorrect! if correct? is false" do
      @card = Card.new("Which planet is closest to the sun?", "Mercury", :STEM)
      @turn = Turn.new("Saturn", @card)

      expect(@turn.feedback).to eq("Incorrect!")
    end
  end
end
