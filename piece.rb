require_relative 'movements'

class Piece
  include Movable

  attr_reader :board, :color
  attr_accessor :moved, :pos

  def initialize(pos, board, color)
    @board = board
    @pos = pos
    @color = color
    @moved = false
  end

  def empty?
    false
  end

  def inspect
    "#{color} #{self.class}"
  end

  def dup(pos, board, color)
    self.class.new(pos, board, color)
  end

  def move_into_check?(pos)
    start_pos = self.pos
    end_pos = pos
    new_board = board.dup
    new_board.move!(start_pos, end_pos)
    new_board.in_check?(color)
  end

  def opponent_at?(pos)
    board.on_board?(pos) && board[*pos].color == other_color
  end

  def other_color
    color == :white ? :black : :white
  end

  def to_s
    raise "Not working"
  end
end
