class Round
  attr_reader :deck, :turns, :number_correct

  def initialize(deck)
    @counter = 1
    @deck = deck
    @number_correct = 0
    @number_of_cards = deck.count
    @turns = []
  end

  def start
    start_message
    
    until @deck.count == 0
      show_card_and_take_user_guess
    end

    end_message
  end

  def current_card
    @deck.cards.first
  end

  def end_message
    puts "****** Game over! ******"
    puts "You had #{@number_correct} correct guesses out of #{@turns.size} for a total score of #{percent_correct}%."
   
    categories = @turns.map do |turn|
      turn.card.category
    end

    categories.uniq.each do |category|
      puts "#{category} - #{percent_correct_by_category(category)}% correct"
    end
  end
  
  def number_correct_by_category(category)
    number_correct_by_category = 0
    
    @turns.each do |turn|
      if turn.card.category == category
        if turn.correct?
          number_correct_by_category += 1
        end
      end
    end

    number_correct_by_category
  end

  def percent_correct
    (@number_correct * 100).to_f / @turns.size
  end
  
  def percent_correct_by_category(category)
    turns_by_category_count = @turns.find_all do |turn|
      turn.card.category == category
    end.size

   (number_correct_by_category(category) * 100) / turns_by_category_count
  end

  def start_message
    puts "Welcome! You're playing with #{@number_of_cards} cards."
    puts "-------------------------------------------------"
  end
  
  def show_card_and_take_user_guess
    puts "This is card number #{@counter} out of #{@number_of_cards}."
    puts "Question: #{current_card.question}"
    guess = gets.chomp
    turn = take_turn(guess)
    puts turn.feedback
    @counter += 1
  end

  def take_turn(guess)
    turn = Turn.new(guess, current_card)
    @turns << turn
    @number_correct += 1 if turn.correct?
    @deck.cards.shift
    turn
  end
end
