class String
  #method to check integer within the class String

  def is_int
    self.to_i.to_s == self
  end
end

module TicTacToe
  class GameBoard
    #attr_accessord :board

    def initialize
      @gameboard = [1..9].to_a
      @run = true
    end

    def display_gameboard
      n = 0
      3.times do
        puts @gameboard[n].to_s + " " + @gameboard[n + 1].to_s + " " + @gameboard[n + 2].to_s
        n += 3
      end
    end

    def x_turn
      display_gameboard
      puts "Choose number between 1 to 9 to place a mark for Player X"
      position = gets.chomp
      if position.is_int
        position = position.to_i
      end
      if @gameboard.include?(position)
        @gameboard.map! do |num|
          if num == position
            num = "X"
          else
            num
          end
        end

      elsif position.is_a?(String) == TRUE
        if position.downcase = "exit"
          puts "bye"
          @running = false
          return
        end
        puts "ERROR. Only numbers are allowed on gameboard"
        puts "RETRY or type EXIT to exit"
        x_turn
      end

    end

    def o_turn
      display_gameboard
      puts "Choose a number between 1 to 9 to place a mark for Player O"
      position = gets.chomp
      if position.is_int
        position = position.to_i
      end
      if @gameboard.include?(position)
        @gameboard.map! do |num|
          if num == position
            num = "O"
          else
            num
          end
        end
      elsif position.is_a?(String) == TRUE
        if position.downcase == "exit"
          puts "bye bye"
          @running = false
          return
        end
        puts "ERROR. Only numbers are allowed on gameboard"
        puts "RETRY or type EXIT to exit"
        o_turn

      end

    end

    def play
      # goes on until game is over or win_game is true
      if @running;
      else
        return
      end
      x_turn
      if @running;
      else
        return
      end

      o_turn
      if@running;
      else
        return
      end
      display_gameboard
    end

    def win_game
      false
    end

  end
end
include TicTacToe
game = GameBoard.new
game.play


