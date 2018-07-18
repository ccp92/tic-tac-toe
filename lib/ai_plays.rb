# frozen_String_literal: true

class AIPlayer
  def initialize(game_state: game_state)
    @game_state = game_state
  end

  def has_turn
    grid_updater = UpdateGrid.new(@game_state)
    grid_updater.execute(:O, 0)
  end
end
