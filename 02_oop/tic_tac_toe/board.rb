class Board

  attr_reader :winning_token

  MAX_TOKENS = 9
  ROWS = 3
  COLS = 3

  def initialize
    @grid = Hash.new
    @placed_tokens = 0
    @in_play = true
    @winning_token = nil
  end 
  
  # places a player's token on the board
  # returns true if i and j are valid positions; false otherwise
  def place_token(token, i, j)
    
    if invalid_coordinates?(i, j)
      puts "Invalid coordinates"
      return false
    end
    
    @grid[[i,j]] = token
    @placed_tokens += 1
    
    check_board_validity(i, j)

    return true
  end

  def draw
    for i in 0...ROWS
      for j in 0...COLS
        cell = @grid[[i,j]]
        if cell == nil
          print " |"
        else
          print cell + "|" 
        end
      end
      print "\n"
    end
  end

  def in_play?
    @in_play
  end
  
  def is_full?
    @placed_tokens == 9
  end

  private
      
      # check if the board is still in play
      def check_board_validity(i, j)
        if is_full?
          mark_board_invalid
        end
            
        check_row(i)
        check_col(j)

        if (i == j || i + j == ROWS - 1)
          check_diagonals
        end

        return true
      end

      def check_row(i)
        row = Array.new
        for col_index in 0...COLS
          row << @grid[[i, col_index]]
        end 
        
        if is_winning?(row)
          mark_board_invalid
        end
      end

      def check_col(j)
        col = Array.new
        for row_index in 0...ROWS
          col << @grid[[row_index, j]]
        end

        if is_winning?(col)
          mark_board_invalid
        end
      end

      def check_diagonals
        primary_diagonal = Array.new
        secondary_diagonal = Array.new

        for i in 0...ROWS
          for j in 0...COLS
        
            if i == j
              primary_diagonal << @grid[[i,j]]
            end

            if i + j == ROWS - 1
              secondary_diagonal << @grid[[i, j]]
            end

          end
        end
        
        if is_winning?(primary_diagonal) || is_winning?(secondary_diagonal)
          mark_board_invalid
        end
      end

      def mark_board_invalid
        @in_play = false
      end

      def invalid_coordinates?(i, j)
        if @grid[[i,j]] != nil || i > ROWS || j > COLS  || i < 0 || j < 0
          return true
        end
        
        return false
      end

      def is_winning?(array)
        if array.all? {|cell| cell == "x"} || array.all? {|cell| cell == "0"}
          @winning_token = array.first
          return true
        end

        return false
      end

end
