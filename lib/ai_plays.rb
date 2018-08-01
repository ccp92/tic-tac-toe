# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:, game_state:)
    @update_grid = update_grid
    @game_state = game_state
    @board = @game_state.state
  end

  def execute
    empty_spaces = Minimax.new(board: @board).find_empty_spaces
    best_turn = minimax.index(minimax.max)
    plays(empty_spaces[best_turn])
  end

  def plays(position)
    @update_grid.execute(:O, position)
    {}
  end

  def minimax
    Minimax.new(board: @board).minimax
  end
end
