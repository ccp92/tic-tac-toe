describe ViewGrid do
  it 'creates a blank grid at the beginning of a game' do
    game_state = GameStatePosition.new
    view_grid = ViewGrid.new(game_state: game_state)

    expect(view_grid.execute({})).to eq(grid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'adds a O in top left of the board when computer plays first' do
    game_state = spy(state: [:O, nil, nil, nil, nil, nil, nil, nil, nil])
    view_grid = ViewGrid.new(game_state: game_state)

    response = view_grid.execute({})
    expect(response[:grid]).to eq([[:O, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'adds a X in top middle of the board when human plays' do
    game_state = spy(state: [nil, :X, nil, nil, nil, nil, nil, nil, nil])
    view_grid = ViewGrid.new(game_state: game_state)

    response = view_grid.execute({})
    expect(response[:grid]).to eq([[nil, :X, nil], [nil, nil, nil], [nil, nil, nil]] )
  end

  it 'can return wins if computer has won' do
    game_state = spy(state: [:O, :O, :O, :X, nil, :X, nil, :X, nil], result: :winner)
    view_grid = ViewGrid.new(game_state: game_state)
    response = view_grid.execute({})

    expect(response[:result]).to eq(:winner)
  end

  it 'can return the winning board if computer has won' do
    game_state = spy(state: [:O, :O, :O, :X, nil, :X, nil, :X, nil], result: :winner)
    view_grid = ViewGrid.new(game_state: game_state)
    response = view_grid.execute({})

    expect(response[:grid]).to eq([[:O, :O, :O], [:X, nil, :X], [nil, :X, nil]])
  end

  it 'can return a win with Os on middle row' do
    game_state = spy(state: [:X, nil, :X, :O, :O, :O, nil, :X, nil], result: :winner)

    view_new_grid = ViewGrid.new(game_state: game_state)
    response = view_new_grid.execute({})

    expect(response).to eq({ grid: [[:X, nil, :X], [:O, :O, :O], [nil, :X, nil]], result: :winner })
  end

  it 'can return a win with Os on bottom row' do
    game_state = spy(state: [:X, nil, :X,  nil, :X, nil, :O, :O, :O], result: :winner)

    view_new_grid = ViewGrid.new(game_state: game_state)
    response = view_new_grid.execute({})

    expect(response).to eq({ grid: [[:X, nil, :X], [nil, :X, nil], [:O, :O, :O]], result: :winner })
  end
end
