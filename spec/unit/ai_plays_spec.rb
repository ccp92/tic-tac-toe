# frozen_string_literal: true

describe AIPlayer do
  it 'adds a O at the beginning of game state' do
    game_state = spy
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).plays(0)

    expect(game_state).to have_received(:save)
  end

  it 'will make the ai pick the winning move with one last choice' do
    game_state = spy(state: [:X, :O, :O, :O, :O, :X, :X, nil, :X])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute
    expect(game_state.state).to eq([:X, :O, :O, :O, :O, :X, :X, :O, :X])
  end

  it 'will make the ai pick the winning move over a loss with two choices' do
    game_state = spy(state: [:X, :O, :X, :X, :X, nil, :O, :O, nil])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute
    expect(game_state.state).to eq([:X, :O, :X, :X, :X, nil, :O, :O, :O])
  end

  it 'will analyse the scores for each branch to assign a score to the next moves with 4 options' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    scores = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).minimax
    expect(scores).to eq([0, -10, -10])
  end

  it 'will analyse the scores for each branch and play in the correct place with 3 options' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute
    expect(game_state).to have_received(:save).with([:O, :X, :O, :X, :X, :O, nil, :O, nil])
  end

  it 'will analyse the scores for each branch to assign a score to the next moves with 4 options' do
    game_state = spy(state: [:X, :O, :X, :O, nil, nil, :X, nil, nil])
    scores = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).minimax
    expect(scores).to eq([10, -10, -10, -10])
  end

  it 'will chose the quickest route to a win' do
    game_state = spy(state: [:X, :O, nil, nil, :O, :X, nil, nil, nil])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute
    expect(game_state).to have_received(:save).with([:X, :O, nil, nil, :O, :X, nil, :O, nil])
  end
end
