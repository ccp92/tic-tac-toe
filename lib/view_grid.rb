# frozen_string_literal: true

class ViewGrid
  def initialize(game_state:)
    @game_state = game_state
  end

  def execute(*)
    if @game_state.state.nil?
      {
        grid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
        result: nil
      }
    else
      {
        grid: [@game_state.state[0..2], @game_state.state[3..5], @game_state.state[6..8]],
        result: @game_state.result
      }
    end
  end
end
