# frozen_string_literal: true

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
    game_state = spy(state: [:X, nil, :X, :X, nil, nil, nil, :O, :O])
    UpdateGrid.new(game_state: game_state).execute(:O, 6)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with left column' do
    game_state = spy(state: [:O, :X, :X, :O, nil, :X, nil, nil, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 6)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with middle column' do
    game_state = spy(state: [nil, :O, :X, :X, :O, :X, nil, nil, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 7)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with right column' do
    game_state = spy(state: [nil, :X, nil, :X, nil, :O, nil, :X, :O])
    UpdateGrid.new(game_state: game_state).execute(:O, 2)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with the left diagonal' do
    game_state = spy(state: [:O, :X, nil, :X, :O, nil, :X, nil, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 8)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :winner when the computer has won with the right diagonal' do
    game_state = spy(state: [:X, nil, :O, :X, :O, :X, nil, nil, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 6)
    expect(game_state).to have_received(:save_result).with(:winner)
  end

  it 'can output :draw when the board is full with no win' do
    game_state = spy(state: [:O, :X, :O, :X, :O, :X, :X, nil, :X])
    UpdateGrid.new(game_state: game_state).execute(:O, 7)
    expect(game_state).to have_received(:save_result).with(:draw)
  end

  it 'can output :winner when the board is full when they win' do
    game_state = spy(state: [:O, :X, :O, :X, :O, :X, :X, :O, nil])
    UpdateGrid.new(game_state: game_state).execute(:O, 8)
    expect(game_state).to have_received(:save_result).with(:winner)
  end
end
