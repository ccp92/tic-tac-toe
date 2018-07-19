# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
  end

  def has_turn(position)
    @update_grid.execute(:O, position)
    {}
  end
end
