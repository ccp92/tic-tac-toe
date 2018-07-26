# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
    @board = update_grid.game_state.state
  end

  def execute
    empty_spaces = find_empty_spaces
    minimax_result = minimax
    best_turn = minimax_result.index(minimax_result.max)
    plays(empty_spaces[best_turn])
  end

  def plays(position)
    @update_grid.execute(:O, position)
    {}
  end

  def minimax
    Minimax.new(update_grid: @update_grid).minimax
  end

  def find_empty_spaces
    Minimax.new(update_grid: @update_grid).find_empty_spaces
  end

  private

  def find_empty_spaces
    empty_spaces = []
    @board.each_index { |i| empty_spaces.push(i) if @board[i].nil? }
    empty_spaces
  end
end
