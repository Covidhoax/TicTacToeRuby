module TicTacToe
  class GameBoard
    attr_accessor :cell

    def initialize
      @gameboard = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @run = true
    end

    def display_board
      n = 0
      3.times do
        puts @gameboard[n].to_s + " " + @gameboard[n + 1].to_s + " " + @gameboard[n + 2].to_s
        n += 3
      end
    end

  end
end
include TicTacToe
game = GameBoard.new
game.display_board
