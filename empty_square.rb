class EmptySquare
  def initialize
  end

  def color
    false
  end

  def empty?
    true
  end

  def available_moves
    []
  end

  def inspect
    "."
  end

  def to_s
    " "
  end
end
