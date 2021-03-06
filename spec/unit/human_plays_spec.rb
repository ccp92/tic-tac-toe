# frozen_string_literal: true

describe HumanPlayer do
  it 'adds an X at the second element of game state' do
    game_state = spy(state: [nil, nil, nil, nil, nil, nil, nil, nil, nil])
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(1)

    expect(game_state).to have_received(:save)
  end

  it 'does not allow a human to play in a position occupied by computer' do
    game_state = spy(state: [:O, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(0)).to eq(errors: [:space_is_taken])
  end

  it 'does not allow a human to play in a position occupied by themselves' do
    game_state = spy(state: [:X, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(0)).to eq(errors: [:space_is_taken])
  end

  it 'does not allow a human to play in a position not on the board' do
    game_state = spy(state: [nil, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(11)).to eq(errors: [:space_does_not_exist])
  end

  it 'does not allow a human to play more than one turn in a row' do
    game_state = spy(state: [:X, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(1)).to eq(errors: [:one_turn_per_player])
  end

  it 'does not save a invalid turn' do
    game_state = spy(state: [:O, nil, nil, nil, nil, nil, nil, nil, nil])
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state), game_state: game_state).plays(0)

    expect(game_state).not_to have_received(:save)
  end
end
