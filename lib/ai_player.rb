# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:, game_state:)
    @update_grid = update_grid
    @game_state = game_state
    @board = @game_state.state
  end

  def execute
<<<<<<< HEAD:lib/ai_player.rb
    empty_spaces = find_empty_spaces
    minimax_result = minimax
    best_turn = minimax_result.index(minimax_result.max)
=======
    empty_spaces = Minimax.new(board: @board).find_empty_spaces
    best_turn = minimax.index(minimax.max)
>>>>>>> master:lib/ai_plays.rb
    plays(empty_spaces[best_turn])
  end

  def plays(position)
    @update_grid.execute(:O, position)
    {}
  end

  def minimax
<<<<<<< HEAD:lib/ai_player.rb
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
=======
    Minimax.new(board: @board).minimax
>>>>>>> master:lib/ai_plays.rb
  end
end
