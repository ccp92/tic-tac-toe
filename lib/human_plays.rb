class HumanPlayer
  def initialize(game_state: game_state)
    @game_state = game_state
  end

  def has_turn(position)
    @game_state.save([nil, nil, nil, nil, nil, nil, nil, nil, nil]) if @game_state.state.nil?

    if @game_state.state[position] == :O
      raise 'This space is taken'
    else
      @game_state.state[position] = :X
      @game_state.save(@game_state.state)
    end
  end
end
