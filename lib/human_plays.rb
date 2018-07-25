# frozen_string_literal: true

class HumanPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
  end

  def plays(position)
    return { errors: [:space_is_taken] } if space_is_taken?(position)
    return { errors: [:space_does_not_exist] } unless position.between?(0, 8)
    return { errors: [:one_turn_per_player] } if had_more_turns?
    @update_grid.execute(:X, position)
    {}
  end

  private

  def space_is_taken?(position)
    %i[O X].include? @update_grid.game_state.state[position]
  end

  def had_more_turns?
    @update_grid.game_state.state.count(:X) > @update_grid.game_state.state.count(:O)
  end
end
