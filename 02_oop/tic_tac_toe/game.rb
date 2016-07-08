require_relative 'board'
require_relative 'player'

class Game
  
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play
    last_player = @player2
    
    while @board.in_play?
      @board.draw
      if last_player == @player1
        play_turn(@player2)
        last_player = @player2
      else
        play_turn(@player1)
        last_player = @player1
      end
    end
    
    @board.draw
    show_winner

  end

  private
    def play_turn(current_player)
      puts "#{current_player.name}'s turn"
      print "Insert at row: "
      row = gets.chomp.to_i
      print "Insert at col: "
      col = gets.chomp.to_i
      @board.place_token(current_player.token, row, col)
    end

    def show_winner
      if @board.winning_token == "x"
        puts "#{@player1.name} won"
      elsif @board.winning_token == "0"
        puts "#{@player2.name} won"
      else
        puts "It's a draw. Please play again"
      end
    end
end

puts "Game starting\nRegistering players...\n\n"

print "First player name: "
player1_name = gets.chomp
player1 = Player.new(player1_name, "x")
puts "#{player1_name}, playing x, successfully created."

puts ""

print "Second player name: "
player2_name = gets.chomp
player2 = Player.new(player2_name, "0")
puts "#{player2_name}, playing 0, successfully created"

board = Board.new

game = Game.new(board, player1, player2)

puts "Positons start from 0. Have fun!"
game.play
