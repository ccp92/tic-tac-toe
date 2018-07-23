describe UpdateGrid do
  it 'can output :winner when the computer has won with top row' do
    game_state = spy(state: [nil, :O, :O, :X, nil, :X, nil, :X, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 0)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with middle row' do
    game_state = spy(state: [:X, nil, :X, nil, :O, :O, nil, :X, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 3)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with bottom row' do
    game_state = spy(state: [:X, nil, :X, :X, nil , nil, nil, :O, :O])
    UpdateGrid.new(game_state: game_state).execute(:O, 6)
    expect(game_state).to have_received(:save_result).with(:winner)
  end
end
