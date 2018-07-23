# frozen_string_literal: true

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
    response = board_set_up([:O, 0])
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

  it 'returns a win with three Os in a row' do
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(1)
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(2)
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(3)
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(4)
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(6)
    response = view_grid.execute({})
    expect(response).to eq(grid: [[:O, :X, :X], [:O, :X, nil], [:O, nil, nil]], result: :winner)
  end

  it 'can return a win with 0s on top row' do
    response = board_set_up([:X, 7], [:O, 1], [:X, 3], [:O, 2], [:X, 5], [:O, 0])

    expect(response).to eq(grid: [[:O, :O, :O], [:X, nil, :X], [nil, :X, nil]], result: :winner)
  end

  it 'can return a win with Os on middle row' do
    response = board_set_up([:X, 0], [:O, 3], [:X, 7], [:O, 4], [:X, 2], [:O, 5])

    expect(response).to eq(grid: [[:X, nil, :X], [:O, :O, :O], [nil, :X, nil]], result: :winner)
  end

  it 'can return a win with Os on bottom row' do
    response = board_set_up([:X, 0], [:O, 6], [:X, 5], [:O, 7], [:X, 2], [:O, 8])

    expect(response).to eq(grid: [[:X, nil, :X], [nil, nil, :X], [:O, :O, :O]], result: :winner)
  end

  it 'can return a win with 0s on the left column' do
    response = board_set_up([:X, 1], [:O, 0], [:X, 5], [:O, 3], [:X, 2], [:O, 6])

    expect(response).to eq(grid: [[:O, :X, :X], [:O, nil, :X], [:O, nil, nil]], result: :winner)
  end

  it 'can return a win with 0s on the middle column' do
    response = board_set_up([:X, 2], [:O, 1], [:X, 5], [:O, 4], [:X, 6], [:O, 7])

    expect(response).to eq(grid: [[nil, :O, :X], [nil, :O, :X], [:X, :O, nil]], result: :winner)
  end

  it 'can return a win with 0s on the right column' do
    response = board_set_up([:X, 1], [:O, 2], [:X, 4], [:O, 5], [:X, 6], [:O, 8])

    expect(response).to eq(grid: [[nil, :X, :O], [nil, :X, :O], [:X, nil, :O]], result: :winner)
  end

  it 'can return a win with on the left diagonal' do
    response = board_set_up([:X, 1], [:O, 0], [:X, 3], [:O, 4], [:X, 6], [:O, 8])

    expect(response).to eq(grid: [[:O, :X, nil], [:X, :O, nil], [:X, nil, :O]], result: :winner)
  end

  it 'can return a win with on the right diagonal' do
    response = board_set_up([:X, 1], [:O, 2], [:X, 3], [:O, 4], [:X, 7], [:O, 6])

    expect(response).to eq(grid: [[nil, :X, :O], [:X, :O, nil], [:O, :X, nil]], result: :winner)
  end

  it 'can return draw if the board is full with no win' do
    response = board_set_up([:X, 0], [:O, 1], [:X, 2], [:O, 4], [:X, 5], [:O, 6], [:X, 3], [:O, 8], [:X, 7])
    expect(response).to eq(grid: [[:X, :O, :X], [:X, :O, :X], [:O, :X, :O]], result: :draw)
  end

  it 'can return win as it fills the board' do
    response = board_set_up([:O, 0], [:X, 2], [:O, 4], [:X, 5], [:O, 6], [:X, 3], [:O, 1], [:X, 7], [:O, 8],)
    expect(response).to eq(grid: [[:O, :O, :X], [:X, :O, :X], [:O, :X, :O]], result: :winner)
  end

  it 'wont let the same person play twice' do
    HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)
    response = HumanPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(1)
    expect(response).to eq(errors: [:one_turn_per_player])
  end

  private

  def board_set_up(*args)
    update_grid = UpdateGrid.new(game_state: game_state)
    args.each do |turn|
      update_grid.execute(turn[0], turn[1])
    end
    view_new_grid = ViewGrid.new(game_state: game_state)
    view_new_grid.execute({})
  end
end
