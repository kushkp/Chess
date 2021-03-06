require 'colorize'

class Display
  attr_reader :board, :debugger
  attr_accessor :current_player, :selected_square, :selection_queue

  MOVEMENTS = { "w" => [-1,0],
                "d" => [0,1],
                "s" => [1,0],
                "a" => [0,-1],
                "\r" => [0,0] }

  def initialize(board, player)
    @board = board
    @cursor = [0,0]
    @debugger = false
    @selection_queue = []
    @selected_square = nil
    @current_player = player
  end

  def render
    system("clear")
    if selected_square.nil?
      avail_moves = board[*cursor].available_moves
      avail_moves.select! { |move| board.valid_move?(cursor, move) }
    else
      avail_moves = board[*selected_square].available_moves
      avail_moves.select! { |move| board.valid_move?(selected_square, move) }
    end

    board.size.times do |r|
      board.size.times do |c|
        print color(r, c, avail_moves)
      end
      print "\n"
    end

    print_instructions
    print_debug if debugger
  end

  def update(input)
    return unless valid?(input)
    new_cursor = new_pos(input)
    if result_on_board(new_cursor)
      self.cursor = new_cursor
    end
  end

  private
  attr_accessor :cursor

  def color(r, c, available_moves)
    bg_color = alternating_colors(r, c)
    if cursor == [r, c]
      bg_color = :magenta
    elsif available_moves.include?([r, c])
      if board[r, c].empty?
        bg_color = :light_cyan
      else
        bg_color = :red
      end
    end

    " #{board[r, c].to_s} ".colorize(background: bg_color)
  end

  def alternating_colors(row,col)
    (row + col).even? ? :light_yellow : :green
  end

  def print_debug
    puts "cursor at: #{cursor} "
    puts "available_moves #{@board[*cursor].available_moves} "
    puts "Checkmate Black: #{@board.checkmate?(:black)}"
    puts "Checkmate White: #{@board.checkmate?(:white)}"
    puts "Current Player: #{current_player.color}"
  end

  def print_instructions
    puts "Turn: #{current_player.color}"
    puts "Please make a move."
    puts "___________________________________________"
    puts "Instructions: "
    puts "Use WASD to move the cursor."
    puts "Press ENTER to select a piece and location to move."
    puts "Press Q exit the game."
  end

  def new_pos(input)
    change = MOVEMENTS[input]
    if input == "\r"
      selection_queue << cursor.dup
      handle_selection_queue
      cursor
    else
      [cursor[0] + change[0], cursor[1] + change[1]]
    end
  end

  def handle_selection_queue
    return if selection_queue.empty?
    if selection_queue.size >= 2
      if selection_queue[0] == selection_queue[1]
        selection_queue.shift
        selection_queue.shift
      else
        board.move(selection_queue.shift, selection_queue.shift)
        selected_square = nil
      end
    elsif selection_queue.size == 1
      selected_square = selection_queue.first
    end
  end

  def result_on_board(pos)
    board.on_board?(pos)
  end

  def valid?(input)
    MOVEMENTS.has_key?(input)
  end
end
