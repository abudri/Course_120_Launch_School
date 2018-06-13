class GuessingGame
  WINNING_NUM = rand(1..100)
  RANGE = 1..100

  attr_accessor :guess

  def initialize 
    @guess = nil
  end

  def prompt_for_number
    puts "Enter a number between 1 and 100:"
  end

  def within_range?(num)
    RANGE.include?(num)
  end

  def guesses_left(num)
    puts "You have #{num} guesses remaining."
  end

  def too_high_or_low?(num)
    if num < WINNING_NUM
      puts "Your guess is too low"
    elsif num > WINNING_NUM
      puts "Your guess is too high"
    end
  end

  def win?(num)
    num == WINNING_NUM
  end

  def out_of_guesses?(num)
    num == 0
  end

  def play
    guesses = 7
    
    loop do
      guesses_left(guesses)
      prompt_for_number

      loop do # get input and validate if input within range
        self.guess = gets.chomp.to_i
        break if within_range?(guess)
        puts "Invalid guess. Enter a number between 1 and 100:"
      end

      if win?(guess)
        puts "You win!"
        break
      end
      guesses -= 1
      too_high_or_low?(guess)
      if out_of_guesses?(guesses)
        puts "You are out of guesses. You lose."
        break
      end
    end
  end

end

game = GuessingGame.new
game.play

=begin
You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
You win!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low
You are out of guesses. You lose.
=end