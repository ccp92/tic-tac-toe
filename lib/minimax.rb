#frozen_string_literal: true

class Minimax
  def initialize(board:)
    @board = board
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
      scores = max?(level) ? scores.map(&:max) : scores.map(&:min)
    end
    scores
  end

  def find_empty_spaces
    empty_spaces = []
    @board.each_index { |i| empty_spaces.push(i) if @board[i].nil? }
    empty_spaces
  end

  private

  def score(branch)
    board = @board.dup
    player = :O
    branch.each do |move|
      depth = board.count(nil)
      board[move] = player
      player = player_switch(player)
      return assign_a_score(board, depth) unless assign_a_score(board, depth).nil?
    end
  end

  def max?(level)
    depth = level + @board.count(nil)
    depth.even?
  end



  def player_switch(player)
    return :X if player == :O
    :O
  end

  def assign_a_score(board, depth)
    return 10 + depth if winner?(:O, board)
    return -10 + depth if winner?(:X, board)
    return 0 + depth unless spaces_remain?(board)
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
