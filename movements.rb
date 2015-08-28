module Movable
  PATHS = {  :up   => [0, -1],
             :down => [0,  1],
             :left => [-1, 0],
             :right=> [1,  0] }

  def get_moves(direction)
    dx , dy = direction
    positions(dx, dy)
  end

  def positions(dx, dy)
    possible_moves = []
    next_pos = change_pos(pos, [dx, dy])

    while board.empty_board_pos?(next_pos)
      possible_moves << next_pos
      next_pos = change_pos(next_pos, [dx, dy])
    end

    possible_moves << next_pos if opponent_at?(next_pos)

    possible_moves
  end

  def merge_directions(vert, horiz)
    dx, _  = horiz
    _ , dy = vert
   [dx, dy]
  end

  def change_pos(pos, change)
    dx, dy = change
     x, y = pos
    [x + dx, y + dy]
  end
end

##########################
# For Bishops and Queens #
##########################


module Diagonalizable
  include Movable

  def diagonal_moves
    pos_slope_diagonal_moves + neg_slope_diagonal_moves
  end

  private
    def pos_slope_diagonal_moves
      up_right = merge_directions(PATHS[:up], PATHS[:right])
      down_left = merge_directions(PATHS[:down], PATHS[:left])
      get_moves(up_right) + get_moves(down_left)
    end

    def neg_slope_diagonal_moves
      up_left = merge_directions(PATHS[:up], PATHS[:left])
      down_right = merge_directions(PATHS[:down], PATHS[:right])
      get_moves(up_left) + get_moves(down_right)
    end
end

########################
# For Rooks and Queens #
########################

module Lateralizable
  include Movable


  def lateral_moves
    vertical_moves + horizontal_moves
  end

  private
    def vertical_moves
      get_moves(PATHS[:up]) + get_moves(PATHS[:down])
    end

    def horizontal_moves
      get_moves(PATHS[:left]) + get_moves(PATHS[:right])
    end
end

#########################
# For Kings and Knights #
#########################

module SteppingPiece
  def available_moves
    moves = []
    @differentials.each do |differentials|
      new_pos = [differentials[0] + pos[0], differentials[1] + pos[1]]
      moves << new_pos if opponent_at?(new_pos) || board.empty_board_pos?(new_pos)
    end
    moves
  end
end
