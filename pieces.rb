require_relative "piece"
require_relative "empty_square"

class Rook < Piece
  include Lateralizable

  def available_moves
    lateral_moves
  end

  def to_s
    color == :white ? "\u2656".white : "\u265c".black
  end
end

#####################


class Knight < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super
    @differentials = [[-1, -2], [1, -2], [-1, 2], [1, 2],
                      [-2, -1], [-2, 1], [2, -1], [2, 1]]
  end

  def to_s
    color == :white ? "\u2658".white : "\u265e".black
  end
end

#####################


class Bishop < Piece
  include Diagonalizable

  def available_moves
    diagonal_moves
  end

  def to_s
    color == :white ? "\u2657".white : "\u265d".black
  end
end

#####################

class King < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super
    @differentials = [ [-1, -1],  [-1, 0],  [-1, 1],
                       [0,  -1],            [0,  1],
                       [1,  -1],  [1,  0],  [1,  1] ]
  end

  def to_s
    color == :white ? "\u2654".white : "\u265a".black
  end
end

#####################

class Queen < Piece
  include Diagonalizable
  include Lateralizable

  def available_moves
    lateral_moves + diagonal_moves
  end

  def to_s
    color == :white ? "\u2655".white : "\u265b".black
  end
end

########################

class Pawn < Piece
  DIRECTION = { :black => [1,0], :white => [-1,0] }
  attr_reader :moved, :direction

  def initialize(pos, board, color)
    super
    @direction = DIRECTION[color]
  end

  def has_moved
    @moved = true
  end

  def available_moves
    vertical_moves + capture_moves
  end

  def to_s
    color == :white ? "\u2659".white : "\u265f".black
  end

  private
    def adjust_pos(differential, pos)
      dy , dx = differential
      y  , x  = pos

      [y + dy, x + dx]
    end

    def capture_moves
      dy , _ = direction
      left_capture = adjust_pos([dy, -1], pos)
      right_capture = adjust_pos([dy, 1], pos)

      [left_capture, right_capture].select { |position| opponent_at?(position) }
    end

    def vertical_moves
      num_moves = (moved ? 1 : 2)
      vertical_moves = []
      new_pos = pos

      num_moves.times do
        new_pos = adjust_pos(direction, new_pos)
        vertical_moves << new_pos
      end

      vertical_moves.select { |move| board[*new_pos].empty? }
    end
end
