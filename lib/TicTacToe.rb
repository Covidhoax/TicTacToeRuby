class String
  #method to check integer within the class String

  def is_int
    self.to_i.to_s == self
  end
end

module TicTacToe
  class Game

    def initialize
      @gameboard = [1..9].to_a
      @running = true
      @exit = false
    end

    def display_gameboard
      n = 0
      b = @gameboard
      3.times do
        puts "  " + b[n].to_s + " | " + b[n+1].to_s + " | " + b[n+2].to_s
        puts " -----------"
        n += 3
      end
      puts ""
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
          return @exit = true
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
      gameboard.all? { |all| all.is_a? String} #true when nobody wins
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

    def try_sides
      if @gameboard[1].is_a? Fixnum
        return @gameboard[1] = "O"
      elsif @gameboard[3].is_a? Fixnum
        return @gameboard[3] = "O"
      elsif @gameboard[5].is_a? Fixnum
        return @gameboard[5] = "O"
      elsif @gameboard[7].is_a? Fixnum
        return @gameboard[7] = "O"
      end
    end

    def try_corners
      if @gameboard[0].is_a? Fixnum
        return @gameboard[0] = "O"
      elsif @gameboard[2].is_a? Fixnum
        return @gameboard[2] = "O"
      elsif @gameboard[6].is_a? Fixnum
        return @gameboard[6] = "O"
      elsif @gameboard[8].is_a? Fixnum
        return @gameboard[8] = "O"
      end
    end

    def npc_turn #checks the possibility to win before human wins
      for i in range(0...9)
        origin = @gameboard[i]
        @gameboard[i] = "o" if @gameboard[i] != "X"
        win_game ? return : @gameboard[i] = origin #return for early break out if win game is true
      end

      for i in range(0...9) # if not possibe to win before other player
        origin = @gameboard[i]
        @gameboard[i] = "X" if @gameboard[i] != "O"
        if win_game
          return @gameboard[i] = "O"
        else
          @gameboard[i] = origin
        end
      end

      if !@gameboard[4].is_a?(String) # default place is center if winning is not possible
        return @gameboard[4] = "O"
      end

      if @gameboard[4].is_a?(String)
        rand > 0.499 ? try_sides || try_corners : try_corners || try_sides
      end
    end

    def npcgame_status
      if rand > 0.3
        until !@running
          x_turn
          break if @exit
          result
          break if@running
          puts "NPC is thinking."
          sleep[0.6]
          puts "NPC is thinking.."
          sleep[0.6]
          puts "NPC is thinking..."
          sleep(0.3)
          npc_turn
          result
        end
      else
        until !@running
          puts "NPC is thinking."
          sleep(0.6)
          puts "NPC is thinking.."
          sleep(0.6)
          puts "NPC is thinking..."
          sleep(0.3)
          npc_turn
          result
          break if @running
          x_turn
          break if @exit
          result
        end
      end
    end
  end

  def play
    match = Game.new
    puts "Welcome to TicTacToe by Farhan Islam. Press 1 for a two player match. Press 2 to play against CPU"
    puts "Type EXIT to quit"
    choice = gets.chomp.to_i
    case choice
      when 1 then match.game_status
      when 2 then match.npcgame_status
      else
        puts "Not Possible"
    end
  end
end



