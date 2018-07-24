# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
  end

  def execute(*)

    nil_indices = {}
    @update_grid.game_state.state.each_index do |index|
      if @update_grid.game_state.state[index].nil?
        temp_board = @update_grid.game_state.state.dup
        temp_board[index] = :O
        nil_indices[index] = 0 unless spaces_remain?(temp_board)
        nil_indices[index] = 10 if winner?(:O, temp_board)
        nil_indices[index] = -10 if winner?(:X, temp_board)
      end
    end
    has_turn(nil_indices.key(10))
  end

  def has_turn(position)
    @update_grid.execute(:O, position)
    {}
  end

  private

  def winner?(player, board)
    lines = [horizontal_lines(board), vertical_lines(board), diagonal_lines(board)].flatten(1)
    lines.include?([player, player, player])
  end

  def spaces_remain?(board)
    board.include?(nil)
  end

  def horizontal_lines(board)
    [places(0, 1, 2, board), places(3, 4, 5, board), places(6, 7, 8, board)]
  end

  def vertical_lines(board)
    [places(0, 3, 6, board), places(1, 4, 7, board), places(2, 5, 8, board)]
  end

  def diagonal_lines(board)
    [places(0, 4, 8, board), places(2, 4, 6, board)]
  end

  def places(place1, place2, place3, board)
    board.values_at(place1, place2, place3)
  end
end
