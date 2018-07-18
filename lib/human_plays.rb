# frozen_string_literal: true

class HumanPlayer
  def initialize(game_state: game_state)
    @game_state = game_state
  end

  def has_turn(position)
    UpdateGrid.new(@game_state)
    return { errors: [:space_is_taken] } if space_is_taken?(position)
    return { errors: [:space_does_not_exist] } if !position.between?(0,8)
    grid_updater = UpdateGrid.new(@game_state)
    grid_updater.execute(:X, position)
    {}
  end

  private

  def space_is_taken?(position)
    [:O,:X].include? @game_state.state[position]
  end
end
