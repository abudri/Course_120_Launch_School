# Walk-through: OO Rock Paper Scissors | Rubcop On it
# https://launchschool.com/lessons/dfff5f6b/assignments/ecf92a8c
# Rubocop Lesson on this:
# https://launchschool.com/lessons/dfff5f6b/assignments/5b1b6523
# most comments removed from this version,
# see other  see rock_paper_scissors_oop.rb file for comments/explanation

class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  def initialize(value)
    @value = value
  end

  def scissors? # this and 2 below to prevent typos
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper? # this and 2 above return boolean
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end 

  def lizard?
    @value == 'lizard'
  end

  def to_s
    @value # exposes the value in display winner portion
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end 

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end 

  def <(other_move)
    other_move.paper? || other_move.spock?
  end 
end 

class Paper < Move
  def initialize
    @value = 'rock'
  end 

  def >(other_move)
    other_move.rock? || other_move.spock?
  end 

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end 
end 

class Scissors < Move
  def initialize
    @value = 'scissors'
  end 

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end 

  def <(other_move)
    other_move.rock? || other_move.spock?
  end 
end 

class Spock < Move
  def initialize
    @value = 'spock'
  end 

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end 

  def <(other_move)
    other_move.lizard? || other_move.paper?
  end 
end 

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    other_move.spock? || other_move.paper?
  end 

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end 
end 

class Player
  attr_accessor :move, :name, :score # getter/setter method for @move
  def initialize
    set_name # initialize will automatically call this when object created
    @score = 0 #score instance variable for any created player
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "Whats your name?"
      n = gets.chomp # n is name, here is local variable
      break unless n.empty? # prevents empty name entry
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil # instantiate this variable
    loop do # validate the human choice is correct
      puts "Please choose rock, paper, scissors, or spock or lizard: "
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice) # Redesign Video 2
  end
end

class Computer < Player
  def set_name
    self.name = ['R2Dw', 'Hal', 'Sammy', 'Delly'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample) # Redesign Video 2
  end
end


# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}" # Redesign Video 1
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move # Redesign Video 2
      puts "#{human.name} won!"
      human.score += 1 # tracks score in instance var @score
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1 #tracks score in instance var @score
    else
      puts "It's a tie!"
    end
  end

  def keep_score # displaying score 
    puts "Score: #{human.name}: #{human.score} | #{computer.name}: #{computer.score}"
    if human.score == 5
      puts "#{human.name} wins overall with 5 wins!" 
      human.score = 0 # reset scores in case player wants to keep playing
      computer.score = 0
    elsif computer.score == 5 
      puts "#{computer.name} wins overall with 5 wins!"
      computer.score = 0 # reset scores in case player wants to keep playing
      human.score = 0 
    end 
  end 

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?(y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end
    return true if answer == 'y'
    false # returns false if answer == 'n'
  end

  # procedural code is in the play method below
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      keep_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play


