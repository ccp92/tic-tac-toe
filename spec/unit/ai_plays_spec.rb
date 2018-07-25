# frozen_string_literal: true

describe AIPlayer do
  it 'adds a O at the beginning of game state' do
    game_state = spy
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)

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

  it 'will generate a tree of 24 branches with 4 spaces left' do
    game_state = spy(state: [:O, :X, :O, :X, nil, nil, nil, :O, nil])
    tree = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).tree
    expect(tree.length).to eq(24)
  end

  it 'will generate a tree of 6 branches with 3 spaces left in the right order' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    tree = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).tree
    expect(tree).to eq([[5,6,8],[5,8,6],[6,5,8],[6,8,5],[8,5,6],[8,6,5]])
  end

  it 'will generate an array of scores based on the tree (3 spaces left)' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    scores = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).generate_scores
    expect(scores).to eq([10, 0, -10, 0, -10, 10])
  end

  it 'will analyse the scores of every branch to assign a score to each next move' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    scores = AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).minimax
    expect(scores).to eq([0, -10, -10])
  end

  it 'will analyse the scores of every branch to assign a score to each next move' do
    game_state = spy(state: [:O, :X, :O, :X, :X, nil, nil, :O, nil])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute
    expect(game_state).to have_received(:save).with([:O, :X, :O, :X, :X, :O, nil, :O, nil])
  end
end
