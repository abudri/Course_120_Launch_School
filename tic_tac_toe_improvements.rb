# Assignment: Some Improvements
# https://launchschool.com/lessons/97babc46/assignments/d791cc06

require 'pry'

class Board # represent a snapshot of board at any time
  WINNNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +   # columns
                  [[1, 5, 9], [3, 5, 7]]                # diagonals

  def initialize # values of hash will be a Sqaure class object
    @squares = {} # below creates spaces hash, for values in empty board
    reset #calls Board#reset
  end

  def get_square_at(key)
    @squares[key] # returns Square object
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker # .marker is setter method
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
    #if unmarked, this key will be returned into returned array from .select
  end

  def full?
    unmarked_keys.empty? # returns true if full, else false
  end

  def someone_won?
    !!detect_winner # object will turn to boolean true by !!, 
    # if detect_winner below is nil, !!nil turns into boolean false
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
    #above, iterating and transforming arr of square objecdts, calling .marker
    # on each of them, return a new arr of markers - arr of strings - and we
    # can use array#count method to count times string TTGame::HUMAN_MARKER
    # occurs in array squares.collect(&:marker), if number is 3, then return
    # human marker as winning condition
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER) # vid 8 refactor
  end

  # returns winning marker or nil(meaninin on one won)
  def detect_winner # iterate through winning lines, and see if square in each 3 elements
    # in this line array matches the human marker or computer marker, if so return that marker
    # if no match return nil
    WINNNING_LINES.each do |line|  # line is 3 element arr representing winning line
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER # vid 8 refactor
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil # if we dno't put this, then .each will return array
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER # if so(ie, space is blank " ", considered unmarked
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new #collaborator object of Board class, state of board at any point in time
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message # say hi
    puts "Welcome to Tic Tac Toe!"; puts ""
  end

  def display_goodbye_message # say bye
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system 'clear'
  end
  
  def display_board(clear_screen = true) # string interpolation calls Sqaure#to_s on objects
    clear if clear_screen # if clear boolean is true, clears prior output after each move
    puts "You're a #{human.marker}.  Computer is a #{computer.marker}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that is not a valid choice."
    end

    board.set_square_at(square, human.marker) # human is getter method for @human then do .marker
    # just above square is user input in this method, human.marker is X or O
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker) # computer is a Player object, 'O' initial value
  end

  def display_result
    display_board

    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must by a y or n"
    end

    answer == 'y' # last line, returns true if so, else false if not y
  end

  def play
    display_welcome_message
    clear
        
    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end
      display_result
      break unless play_again?
      board.reset
      clear
      puts "Let's play again!" # if answer is yes, if not we say goodbye below
      puts ""
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play


