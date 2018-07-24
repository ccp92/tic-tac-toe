# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
    @temp_board = update_grid.game_state.state.dup
  end

  def execute(*)
    nil_indices = []
    board = @update_grid.game_state.state
    board.each_index { |i| nil_indices.push(i) if board[i].nil? }
    best_turn = minimax.index(minimax.max)
    has_turn(nil_indices[best_turn])


  end

  def has_turn(position)
    @update_grid.execute(:O, position)
    {}
  end

  def minimax
    turn_scores = []
    scores = generate_scores
    turns = @update_grid.game_state.state.count(nil)
    (0...scores.length).step(scores.length / turns) do |index|
      turn_scores.push(scores[index, scores.length / turns].min)
    end
    turn_scores
  end

  def tree
    board = @update_grid.game_state.state
    nil_indices = []
    board.each_index { |i| nil_indices.push(i) if board[i].nil? }
    nil_indices.permutation.to_a
  end

  def generate_scores
    scores = []
    tree.each do |branch|
      board = @update_grid.game_state.state.dup
      player = :O
      branch.each do |move|
        board[move] = player
        if player == :O
          player = :X
        else
          player = :O
        end
        unless assign_a_score(board).nil?
          scores.push(assign_a_score(board))
          break
        end
      end
    end
    scores
  end

  private

  def assign_a_score(board)
    return 10 if winner?(:O, board)
    return -10 if winner?(:X, board)
    return 0 unless spaces_remain?(board)
  end

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
