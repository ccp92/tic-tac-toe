describe ViewGrid do
  it 'creates a blank grid at the beginning of a game' do
    game_state = GameStatePosition.new
    view_grid = ViewGrid.new(game_state: game_state)

    expect(view_grid.execute({})).to eq(grid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'adds a O in top left of the board when computer plays first' do
    game_state = GameStatePosition.new
    ai_plays = AIPlayer.new(game_state: game_state).has_turn
    view_grid = ViewGrid.new(game_state: game_state)

    expect(view_grid.execute()).to eq({ grid: [[:O, nil, nil], [nil, nil, nil], [nil, nil, nil]] })
  end

  it 'adds a X in top middle of the board when human plays' do
    game_state = GameStatePosition.new
    ai_plays = HumanPlayer.new(game_state: game_state).has_turn(1)
    view_grid = ViewGrid.new(game_state: game_state)

    expect(view_grid.execute()).to eq({ grid: [[nil, :X, nil], [nil, nil, nil], [nil, nil, nil]] })
  end
end
