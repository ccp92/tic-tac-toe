# frozen_string_literal: true

describe AIPlayer do
  it 'adds a O at the beginning of game state' do
    game_state = spy
    AIPlayer.new(update_grid: UpdateGrid.new(game_state: game_state)).has_turn(0)

    expect(game_state).to have_received(:save)
  end
end
