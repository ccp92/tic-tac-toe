describe UpdateGrid do
  it 'can output :winner when the computer has won' do
    game_state = spy(state: [nil, :O, :O, :X, nil, :X, nil, :X, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 0)
    expect(game_state).to have_received(:save_result).with(:winner)
  end
end
