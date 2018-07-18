describe ViewGrid do
  it 'creates a blank grid at the beginning of a game' do
    game_state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    view_grid = ViewGrid.new(game_state: game_state)

    expect(view_grid.execute({})).to eq(grid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] )
  end
end
