# frozen_String_literal: true

class AIPlayer
  def initialize(update_grid:)
    @update_grid = update_grid
    @board = update_grid.game_state.state
  end

  def execute
    empty_spaces = find_empty_spaces
    best_turn = minimax.index(minimax.max)
    has_turn(empty_spaces[best_turn])
  end

  def has_turn(position)
    @update_grid.execute(:O, position)
    {}
  end

  def tree
    find_empty_spaces.permutation.to_a
  end

  def branch_scores
    scores = []
    tree.each do |branch|
      scores.push(score(branch))
    end
    scores
  end

  def minimax
    scores = branch_scores
    (2...@board.count(nil)).each do |level|
      scores = scores.each_slice(level).to_a
      scores.map!(&:min) unless max?(level)
      scores.map!(&:max) if max?(level)
    end
    scores
  end

  private

  def max?(level)
    depth = level + @board.count(nil)
    return true if depth.even?
  end

  def score(branch)
    board = @board.dup
    player = :O
    branch.each do |move|
      board[move] = player
      player = player_switch(player)
      return assign_a_score(board) unless assign_a_score(board).nil?
    end
  end

  def find_empty_spaces
    empty_spaces = []
    @board.each_index { |i| empty_spaces.push(i) if @board[i].nil? }
    empty_spaces
  end

  def player_switch(player)
    return :X if player == :O
    :O
  end

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
