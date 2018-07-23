describe 'a game of tic-tac-toe' do
  class GameStatePosition

    attr_reader :state
    attr_reader :result

    def save(state)
      @state = state
    end

    def save_result(result)
      @result = result
    end
  end

  let(:game_state) { GameStatePosition.new }

  let(:view_grid) { ViewGrid.new(game_state: game_state) }

  it 'starts a game by displaying an empty board' do
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'has the computer having the first turn' do
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[:O, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'allows a human to take a valid turn' do
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(1)
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[:O, :X, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it 'can return a win with 0s on top row' do
    update_grid = UpdateGrid.new(game_state: game_state)
    update_grid.execute(:X, 7)
    update_grid.execute(:O, 1)
    update_grid.execute(:X, 3)
    update_grid.execute(:O, 2)
    update_grid.execute(:X, 5)
    update_grid.execute(:O, 0)

    view_new_grid = ViewGrid.new(game_state: game_state)
    response = view_new_grid.execute({})

    expect(response).to eq({ grid: [[:O, :O, :O], [:X, nil, :X], [nil, :X, nil]], result: :winner })
  end

  it 'can return a win with Os on middle row' do
    update_grid = UpdateGrid.new(game_state: game_state)
    update_grid.execute(:X, 0)
    update_grid.execute(:O, 3)
    update_grid.execute(:X, 7)
    update_grid.execute(:O, 4)
    update_grid.execute(:X, 2)
    update_grid.execute(:O, 5)

    view_new_grid = ViewGrid.new(game_state: game_state)
    response = view_new_grid.execute({})

    expect(response).to eq({ grid: [[:X, nil, :X], [:O, :O, :O], [nil, :X, nil]], result: :winner })
  end

  it 'can return a win with Os on middle row' do
    update_grid = UpdateGrid.new(game_state: game_state)
    update_grid.execute(:X, 0)
    update_grid.execute(:O, 6)
    update_grid.execute(:X, 5)
    update_grid.execute(:O, 7)
    update_grid.execute(:X, 2)
    update_grid.execute(:O, 8)

    view_new_grid = ViewGrid.new(game_state: game_state)
    response = view_new_grid.execute({})

    expect(response).to eq({ grid: [[:X, nil, :X], [nil, nil, :X], [:O, :O, :O]], result: :winner })
  end
end
