# Assignment: Some Improvements
# https://launchschool.com/lessons/97babc46/assignments/d791cc06
# no rubocop offenses after cleaning this up per: 
# https://launchschool.com/lessons/97babc46/assignments/678afb39

class Board # represent a snapshot of board at any time
  WINNNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                   [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                   [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize # values of hash will be a Sqaure class object
    @squares = {} # below creates spaces hash, for values in empty board
    reset # calls Board#reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
    # if unmarked, this key will be returned into returned array from .select
  end

  def full?
    unmarked_keys.empty? # returns true if full, else false
  end

  def someone_won?
    !!winning_marker # object will turn to boolean true by !!,
    # if winning_marker below is nil, !!nil turns into boolean false
  end

  # returns winning marker or nil(meaninin on one won)
  def winning_marker # iterate through winning lines, and see if square
    # in each 3 elements
    # in this line array matches the human marker or computer marker,
    # if so return that marker, if no match return nil
    WINNNING_LINES.each do |line|
      # line is 3 element arr representing winning line
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil # if we dno't put this, then .each will return array
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw # Improvement 6 on site
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1 # alternative to other code which works,
    # markers.min == markers.max
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

  def marked? # Improvement 9 from site
    marker != INITIAL_MARKER
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
  FIRST_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new # collaborator object of Board class,
    # state of board at any point in time
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_MOVE
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      display_result
      break unless play_again?
      reset # reset method within this same class
      display_play_again_message
    end

    display_goodbye_message
  end

  private # Improvement 6 or so (or 11?)

  def display_welcome_message # say hi
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message # say bye
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board # string interpolation calls Sqaure#to_s on objects
    # clear if options[:clear_screen] # if clear boolean is true,
    # clears prior output after each move
    puts "You're a #{human.marker}.  Computer is a #{computer.marker}"
    puts ""
    board.draw # from Improvement 6 on site
    puts ""
  end

  def current_player_moves # Improvement 10 on site
    if human_turn? # human_turn? method call
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that is not a valid choice."
    end

    board[square] = human.marker
    # human is getter method for @human then do .marker
    # just above square is user input in this method, human.marker is X or O
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
    # computer is a Player object, 'O' initial value
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def reset
    board.reset
    @current_marker = FIRST_MOVE # resets player to you when we play again
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must by a y or n"
    end

    answer == 'y' # last line, returns true if so, else false if not y
  end
end

game = TTTGame.new
game.play
