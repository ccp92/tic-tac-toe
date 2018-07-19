# frozen_string_literal: true

class HumanPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
  end

  def has_turn(position)
    @update_grid
    return { errors: [:space_is_taken] } if space_is_taken?(position)
    return { errors: [:space_does_not_exist] } unless position.between?(0, 8)
    @update_grid.execute(:X, position)
    {}
  end

  private

  def space_is_taken?(position)
    [:O, :X].include? @update_grid.game_state.state[position]
  end
end
