describe 'a game of tic-tac-toe' do
  class GameStatePosition
    def game_state
      @game_state
    end

    def game_state=(game_state)
      @game_state = game_state
    end

    def new_game
      @game_state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    end
  end

  let(:game_state) { GameStatePosition.new.new_game }

  let(:view_grid) { ViewGrid.new(game_state: game_state) }


  it 'starts a game by displaying an empty board' do
    response = view_grid.execute({})
    grid = response[:grid]
    expect(grid).to eq([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end
end
