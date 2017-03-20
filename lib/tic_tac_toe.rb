require 'colorize'

# Possible ways to win
WAYS_TO_WIN = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
               [0, 3, 6], [1, 4, 7], [2, 5, 8],
               [0, 4, 8], [2, 4, 6]].freeze

class GameBoard
  attr_accessor :cells

  def initialize
    @cells = Array.new(9) # { nil }
  end

  def as_string
    stringed_gameboard = @cells.map.with_index(1) do |symbol, idx|
      symbol || idx
    end

    stringed_gameboard.each_slice(3).map do |row|
      "  #{row.join(' | ')}"
    end.join("\n ---+---+---\n")
  end

  def cell_open?(position)
    @cells[position - 1].nil?
  end

  def win_game?(symbol)
    WAYS_TO_WIN.any? do |seq|
      seq.all? { |a| @cells[a] == symbol }
    end
  end

  def full?
    @cells.all?
  end

  def place_symbol(position, symbol)
    @cells[position - 1] = symbol
  end
end

# game logic
class Game
  def initialize
    @gameboard = GameBoard.new
    # default states
    @player1 = Human.new(@gameboard, 'Player 1', 'X'.red)
    @player2 = AI.new(@gameboard, 'Player 2', 'O'.blue)
    @current_player = @player2
    greet
    start_screen
  end

  private

  def start_screen(choice = gets)
    choice.strip!.downcase! if choice
    until %w(1 2 3 exit).include?(choice)
      puts 'You silly goose, try again.'
      choice = gets.chomp.downcase
    end
    select_game_mode(choice)
    display_board
    run_game
  end

  def select_game_mode(choice)
    case choice
      when '1'    then @player2 = Human.new(@gameboard, 'Player 2', 'O'.blue)
      when '3'    then @player1 = AI.new(@gameboard, 'AIx', 'X'.red)
      when 'exit' then exit
    end
  end

  def greet
    print "\nWelcome to Tic Tac Toe.\n\n"
    print "\nPress 1 to play against another player.\n"
    print "\nPress 2 to play against AI(NPC).\n"
    print "\nPress 3 to watch AI play against AI\n"
    print "\nType EXIT  to quit.\n\n"
    print "\n\nGame created by Farhan\n"
  end

  def display_board
    puts "\e[H\e[2J" # clear ANSI
    print @gameboard.as_string, "\n\n"
  end

  def run_game
    until game_over?
      swap_players
      check_place
      display_board
      if game_over?
        puts display_result
        exit
      end
    end
  end

  def game_over?
    @gameboard.win_game?(@current_player.symbol) || @gameboard.full?
  end

  def check_place
    position = @current_player.take_input
    @gameboard.place_symbol(position.to_i, @current_player.symbol) unless position.nil?
  end

  def display_result
    if @gameboard.win_game?(@current_player.symbol)
      "Game Over Loser, #{@current_player.name} has won."
    elsif @gameboard.full?
      'Draw.'
    end
  end

  def swap_players
    case @current_player
      when @player1 then @current_player = @player2
      else               @current_player = @player1
    end
  end
end

# players in the game
class Player
  attr_reader :name, :symbol

  def initialize(gameboard, name, symbol)
    @gameboard = gameboard
    @name = name
    @symbol = symbol
  end
end

# human players in the game
class Human < Player
  def take_input(input = nil)
    until (1..9).cover?(input) && @gameboard.cell_open?(input)
      puts "Choose number 1 to 9 to place mark #{name}."
      input = validate_input(gets.chomp)
    end
    input
  end

  private

  def validate_input(input)
    if input.to_i == 0
      exit if input.casecmp('exit').zero?
      puts 'What makes you think you can use anything but numbers? Use a number from 1 to 9'
    else
      position = validate_position(input.to_i)
    end
    position
  end

  def validate_position(position)
    if !(1..9).cover? position
      puts 'Out of bounds.'
      puts 'You can try again or exit'
    elsif !@gameboard.cell_open? position
      puts 'Place taken, you must try again'
      puts 'Try again or exit'
    end
    position
  end
end

class AI < Player
  attr_reader :gameboard

  def take_input
    loading_simulation
    win_or_block(symbol) || win_or_block(other_symbol) || check_defaults
  end

  private

  # first check if possible to win before human player.
  # if not, check if possible to block opponent from winning.
  def win_or_block(sym)
    finished = false
    0.upto(8) do |i|
      origin = gameboard.cells[i]
      gameboard.cells[i] = sym if origin.nil?
      finished = i + 1 if gameboard.win_game?(sym)
      gameboard.cells[i] = origin
    end
    finished
  end

  # default to center, if occupied, choose randomly between sides and corners.
  # if occupied after random throw, execute reverse failsafe check.
  def check_defaults
    if gameboard.cells[4]
      rand < 0.51 ? possible_position(&:even?) : possible_position(&:odd?)
    else
      5
    end
  end

  def possible_position(&block)
    result = (0..8).select(&block).each do |i|
      return i + 1 if gameboard.cells[i].nil?
    end
    result.is_a?(Integer) ? result : gameboard.cells.rindex(nil) + 1
  end

  def other_symbol
    symbol == 'X' ? 'O' : 'X'
  end

  def loading_simulation
    str = "\r#{name} is scheming"
    10.times do
      print str += '.'
      sleep(0.1)
    end
  end
end


Game.new
