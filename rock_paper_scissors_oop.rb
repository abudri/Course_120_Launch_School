# Walk-through: OO Rock Paper Scissors
# https://launchschool.com/lessons/dfff5f6b/assignments/ecf92a8c 

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end 

  def scissors? # these 3 below kinds of methods helps in not making typos, will complain method not found
    @value == 'scissors'
  end 

  def rock?
    @value == 'rock'
  end 

  def paper?  # this and 2 above return boolean
    @value == 'paper'
  end 

  def >(other_move) # about 8 or 9 mins in Redesign Video 2
    if rock?
      return true if other_move.scissors? #other_move is a move object, #scissors? yet to write, comparing myself with other_object passed in
      return false 
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end 
  end 

  def <(other_move)
    if rock?
      return true if other_move.paper?
      return false 
    elsif paper?
      return true if other_move.scissors?
      return false 
    elsif scissors?
      return true if other_move.rock?
      return false 
    end 
  end 

  def to_s
    @value # exposes the value in display winner portion, instead of obect itself, about 13 mins in Redesign 2 Video
  end 
end 

class Player
  attr_accessor :move, :name #getter/setter method for @move

  def initialize # Redesign Video 1: (player_type = :human) removed, we don't need Player type state anymore in Player cause subclasses Human
    # and Computer handle that.  @name removed here too. @move = nil  removed here too, since intialized to nil by default anyway
    set_name # initialize will automatically call this when object created
  end 
  # basically all logic is moved to all the subclasses, and when we instantiate player objects, we are instantiating specific 
  # sublclasses of Player class, that instantiation is done in the RPSGame class down below
  # Redesign Video 1: removed set_name from Player class, to Human and Computer classes (respective parts).  self.name is the setter method
  # Redesign Video 1: removed choose from Player class, and its respective parts to Human and Computer classes
  # Redsign Video 1: without Player class level choose or set_name methods, we don't need `def human` method in Player
  # all Player class is now responsible for is setting up getters/setters for :move, :name
end

class Human < Player
  def set_name
      n = ''
      loop do 
        puts "Whats your name?"
        n = gets.chomp  # n is name, here is local variable
        break unless n.empty? # prevents empty name entry 
        puts "Sorry, must enter a value."
      end 
      self.name = n 
  end 

  def choose
    choice = nil # instantiate this variable
      loop do #validate the human choice is correct
        puts "Please choose rock, paper, or scissors: "
        choice = gets.chomp 
        break if Move::VALUES.include?(choice)
        puts "Sorry, invalid choice"
      end 
      self.move = Move.new(choice) # Redesign Video 2 / fter human chose a possible choice
  end 
end 

class Computer < Player
  def set_name
    self.name = ['R2Dw', 'Hal', 'Sammy', 'Delly'].sample
  end 
  def choose
    self.move = Move.new(Move::VALUES.sample) # Redesign Video 2, helps return a move object
  end 
end 

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer # only state in RPSGame class is human and computer

  def initialize
    @human = Human.new #(:human) symbol here will be used internally by Player class above, not needed
    # because its a default in the initialize method of the Player class above
    @computer = Computer.new # remove the `(:computer)` right after new for Redesign 1 video
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end 

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Bye!"
  end 


  def display_winner # has access to @human and @computer since in same class, and each of those
    # has access to their respective moves
    puts "#{human.name} chose #{human.move}" # Redesign Video 1: human.name, human is object of Human class, but
    # still has access to the :name getter method from the Player parent/superclass, same with .move getting method
    puts "#{computer.name} chose #{computer.move}"
    
    if human.move > computer.move # Redesign Video 2
      puts "#{human.name} won!"
    elsif human.move < computer.move 
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
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
    return false # this is if answer == 'n'
  end 

#procedural code is in the play method below
  def play
    display_welcome_message
    loop do 
      human.choose #.choose is an instance method on the Player class, since human is an object of the Player class
      computer.choose
      display_winner
      break unless play_again? #could put play again loop here, but easier to not have double loop here
    end 
    display_goodbye_message
  end
end

RPSGame.new.play