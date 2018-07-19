# frozen_string_literal: true

class UpdateGrid
  attr_reader :game_state

  def initialize(game_state:)
    @game_state = game_state
    initial_state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    @game_state.save(initial_state) if @game_state.state.nil?
  end

  def execute(player, position)
    @game_state.state[position] = player
    @game_state.save(@game_state.state)
    @game_state.save_result(:winner) if winner?
  end

  private

  def winner?
    @game_state.state[0..2] == [:O, :O, :O]
  end
end
