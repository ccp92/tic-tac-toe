describe 'a game of tic-tac-toe' do
  class GameStatePosition

    attr_reader :state

    def save(state)
      @state = state
    end
  end

  let(:game_state) { GameStatePosition.new }

  let(:view_grid) { ViewGrid.new(game_state: game_state) }

  it 'starts a game by displaying an empty board' do
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'has the computer having the first turn' do
    AIPlayer.new(game_state: game_state).has_turn
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[:O, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'allows a human to take a valid turn' do
    AIPlayer.new(game_state: game_state).has_turn
    HumanPlayer.new(game_state: game_state).has_turn(1)
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[:O, :X, nil], [nil, nil, nil], [nil, nil, nil]])
  end
end
