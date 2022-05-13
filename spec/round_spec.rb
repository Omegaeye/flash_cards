require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

RSpec.describe Round do
  describe "#initialize" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
    end

    it "should initialize the Round" do
      expect(@round).to be_instance_of(Round)
    end

    it "has a deck" do
      expect(@round.deck).to eq(@deck)  
    end

    it "has turns as an emptry array" do
      expect(@round.turns).to eq([])  
    end

    it "has a number_correct" do
      expect(@round.number_correct).to eq(0)  
    end
  end

  describe "#current_card" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
    end

    it "should return the first card on the deck" do
      expect(@round.current_card).to eq(@card_1)
    end
  end

  describe "#take_turn" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
      @new_turn = @round.take_turn("Juneau")
    end

    it "should return an instance of a Turn" do
      expect(@new_turn).to be_instance_of(Turn)
    end
    
    it "should compare guess to card.answer" do
      expect(@new_turn.correct?).to eq(true)
    end
    
    it "should add the turn to turns array" do
      expect(@round.turns).to eq([@new_turn])
    end
    
    it "should keep track of the number of correct guess" do
      expect(@round.number_correct).to eq(1)
    end
    
    it "should move onto the next card" do
      expect(@round.current_card).to eq(@card_2)
    end

    it "when take_turn is called twice" do
      @round.take_turn("Venus")

      expect(@round.turns.count).to eq(2)
      expect(@round.turns.last.feedback).to eq("Incorrect!")
      expect(@round.number_correct).to eq(1)
      expect(@round.current_card).to eq(@card_3)
    end
  end

  describe "#number_correct_by_category" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
      @new_turn = @round.take_turn("Juneau")

      @round.take_turn("Venus")
    end

    it "should returns an integer" do
      expect(@round.number_correct_by_category(:Geography)).to eq(1)
      expect(@round.number_correct_by_category(:STEM)).to eq(0)
    end
  end

  describe "#percent_correct" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
      @new_turn = @round.take_turn("Juneau")

      @round.take_turn("Venus")
    end

    it "should returns a float of the percentage of correct guess" do
      expect(@round.percent_correct).to eq(50.0)
    end
  end

  describe "#percent_correct_by_category" do
    before do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
      @deck = Deck.new([@card_1, @card_2, @card_3])
      @round = Round.new(@deck)
      @new_turn = @round.take_turn("Juneau")

      @round.take_turn("Venus")
    end

    it "should return a float of the percentage of correct by category" do
      expect(@round.percent_correct_by_category(:Geography)).to eq(100)
    end
  end
end
