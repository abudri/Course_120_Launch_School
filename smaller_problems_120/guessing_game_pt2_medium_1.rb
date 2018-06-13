=begin
Number Guesser Part 2
In the previous exercise, you wrote a number guessing game that 
determines a secret numberbetween 1 and 100, and gives the user 7 
opportunities to guess the number.

Update your solution to accept a low and high value when you
 create a GuessingGame object, and use those values to compute 
 a secret number for the game. You should also change the number
  of guesses allowed so the user can always win if she uses a
   good strategy. You can compute the number of guesses with:

Math.log2(size_of_range).to_i + 1 

https://launchschool.com/exercises/e50996f7
=end

class GuessingGame

  attr_accessor :guess, :winning_num, :max_guesses
  attr_reader :range, :low_num, :high_num

  def initialize(low_num, high_num)
    @range = low_num..high_num
    @low_num = low_num
    @high_num = high_num
    @guess = nil
    @winning_num = nil
    @max_guesses = Math.log2(high_num - low_num + 1).to_i + 1
  end

  def set_winning_num
    self.winning_num = rand(low_num..high_num)
  end

  def prompt_for_number
    puts "Enter a number between #{low_num} and #{high_num}:"
  end

  def within_range?(num)
    range.include?(num) # getter for @range
  end

  def guesses_left(num)
    puts "You have #{num} guesses remaining."
  end

  def too_high_or_low?(num)
    if num < winning_num
      puts "Your guess is too low"
    elsif num > winning_num
      puts "Your guess is too high"
    end
  end

  def win?(num)
    num == winning_num
  end

  def out_of_guesses?(num)
    num == 0
  end

  def play
    set_winning_num

    loop do
      guesses_left(max_guesses)
      prompt_for_number

      loop do # get input and validate if input within range
        self.guess = gets.chomp.to_i
        break if within_range?(guess)
        puts "Invalid guess. Enter a number between #{low_num} and #{high_num}:"
      end

      if win?(guess)
        puts "You win!"
        break
      end
      self.max_guesses -= 1
      too_high_or_low?(guess)
      if out_of_guesses?(max_guesses)
        puts "You are out of guesses. You lose."
        break
      end
    end
  end

end

game = GuessingGame.new(53, 233)
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