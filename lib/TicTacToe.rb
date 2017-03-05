class String
  #method to check integer within the class String

  def is_int
    self.to_i.to_s == self
  end
end

module TicTacToe
  class GameBoard
    attr_reader :gameboard

    def initialize
      @gameboard = [1..9].to_a
      @run = true
      @exit = false
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

      elsif position.is_a?(String)
        if position.downcase = "exit"
          puts "bye"
          @exit = true
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
      elsif position.is_a?(String)
        if position.downcase == "exit"
          puts "bye bye"
          @exit = false
          return
        end
        puts "ERROR. Only numbers are allowed on gameboard"
        puts "RETRY or type EXIT to exit"
        o_turn
      end
    end

    def win_game
      b = @gameboard
      # 3 to the horizontal
      if(
      (b[0..2].count("X") == 3 ||b[0..2].count("O") == 3) ||
        (b[3..5].count("X") == 3 ||b[3..5].count("O") == 3)  ||
          (b[6..8].count("X") == 3 || b[6..8].count("O") == 3)

      ) then return true
        #3 to the vertical win
      elsif(
      (b.values_at(0,3,6).count("X") == 3 || b.values_at(0,3,6).count("O") == 3) ||
          (b.values_at(1,4,7).count("X") == 3 || b.values_at(1,4,7).count("O") == 3) ||
            (b.values_at(2,5,8).count("X") == 3 || b.values_at(2,5,8).count("O") == 3)
      )then return true
        #two to the diagonal
      elsif(
      (b.values_at(0,4,8).count("X") == 3 || b.values_at(0,4,8).count("O") == 3) ||
          (b.values_at(2,4,6).count("X") == 3 || b.values_at(2,4,6).count("O") == 3)

      )then return true
      else
        return false
      end
    end

    def draw_game
      gameboard.all? { |all| all.is_a? String}
    end

    def result
      if win_game
        display_gameboard
        puts "Game is OVER"
        @running = false
      elsif draw_game
        display_gameboard
        puts "Game is DRAWN"
        @running = false
      end
    end

    def game_status
      until !@running
        x_turn
        break if @exit
        result
        break if !@running
        o_turn
        break if @exit
        result
      end
    end

  end
end

include TicTacToe
game = GameBoard.new
game.game_status

