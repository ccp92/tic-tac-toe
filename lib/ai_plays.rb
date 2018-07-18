class AIPlayer
  def initialize(game_state: game_state)
    @game_state = game_state
  end

  def has_turn
    @game_state.save([:O, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end
