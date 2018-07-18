describe UpdateGrid do
  xit 'outputs :winner when the computer has won' do
    game_state = spy([nil, :O, :O, :X, nil, :X, nil, :X, nil])
    grid_updater = UpdateGrid.new(game_state: game_state)
    expect(grid_updater.execute(:O, 0)).to eq(result: :winner)
  end
end
