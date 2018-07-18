describe HumanPlayer do
  it 'adds an X at the second element of game state' do
    game_state = spy
    HumanPlayer.new(game_state: game_state).has_turn(1)

    expect(game_state).to have_received(:save)
  end

  it 'does not allow a human to play in an occupied position' do
    game_state = GameStatePosition.new
    AIPlayer.new(game_state: game_state).has_turn
    expect{ HumanPlayer.new(game_state: game_state).has_turn(0) }.to raise_error('This space is taken')
  end

  it 'does not save a invalid turn' do
    game_state = spy
    AIPlayer.new(game_state: game_state).has_turn
    HumanPlayer.new(game_state: game_state).has_turn(0)

    expect(game_state).not_to have_received(:save).with([:X, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end
