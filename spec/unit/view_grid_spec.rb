# frozen_string_literal: true

describe ViewGrid do
  it 'creates a blank grid at the beginning of a game' do
    game_state = spy(state: nil)
    response = ViewGrid.new(game_state: game_state).execute({})

    expect(response[:grid]).to eq([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'adds a O in top left of the board when computer plays first' do
    game_state = spy(state: [:O, nil, nil, nil, nil, nil, nil, nil, nil])
    response = ViewGrid.new(game_state: game_state).execute({})
    expect(response[:grid]).to eq([[:O, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'adds a X in top middle of the board when human plays' do
    game_state = spy(state: [nil, :X, nil, nil, nil, nil, nil, nil, nil])
    response = ViewGrid.new(game_state: game_state).execute({})
    expect(response[:grid]).to eq([[nil, :X, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'can return wins if computer has won' do
    game_state = spy(state: [:O, :O, :O, :X, nil, :X, nil, :X, nil], result: :winner)
    response = ViewGrid.new(game_state: game_state).execute({})

    expect(response[:result]).to eq(:winner)
  end

  it 'can return the winning board if computer has won' do
    game_state = spy(state: [:O, :O, :O, :X, nil, :X, nil, :X, nil], result: :winner)
    response = ViewGrid.new(game_state: game_state).execute({})

    expect(response[:grid]).to eq([[:O, :O, :O], [:X, nil, :X], [nil, :X, nil]])
  end

  it 'can return a win with Os on middle row' do
    game_state = spy(state: [:X, nil, :X, :O, :O, :O, nil, :X, nil], result: :winner)
    response = ViewGrid.new(game_state: game_state).execute({})

    expect(response).to eq(grid: [[:X, nil, :X], [:O, :O, :O], [nil, :X, nil]], result: :winner)
  end

  it 'can return a win with Os on bottom row' do
    game_state = spy(state: [:X, nil, :X, nil, :X, nil, :O, :O, :O], result: :winner)
    response = ViewGrid.new(game_state: game_state).execute({})
    expect(response).to eq(grid: [[:X, nil, :X], [nil, :X, nil], [:O, :O, :O]], result: :winner)
  end

  it 'can return a win with Os on the left column' do
    game_state = spy(state: [:O, :X, :X, :O, nil, :X, :O, nil, nil], result: :winner)
    response = ViewGrid.new(game_state: game_state).execute({})
    expect(response).to eq(grid: [[:O, :X, :X], [:O, nil, :X], [:O, nil, nil]], result: :winner)
  end
end
