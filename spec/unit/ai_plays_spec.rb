# frozen_string_literal: true

describe AIPlayer do
  it 'adds a O at the beginning of game state' do
    game_state = spy
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)

    expect(game_state).to have_received(:save)
  end

  it 'will make the ai pick the winning move with one last choice' do
    game_state = spy(state: [:X, :O, :O, :O, :O, :X, :X, nil, :X])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute({})
    expect(game_state.state).to eq([:X, :O, :O, :O, :O, :X, :X, :O, :X])
  end

  it 'will make the ai pick the winning move over a loss with two choices' do
    game_state = spy(state: [:X, :O, :X, :X, :X, nil, :O, :O, nil])
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).execute({})
    expect(game_state.state).to eq([:X, :O, :X, :X, :X, nil, :O, :O, :O])
  end
end
