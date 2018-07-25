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

  def minimax
    turn_scores = []
    scores = generate_scores
    turns = @board.count(nil)
    (0...scores.length).step(scores.length / turns) do |index|
      turn_scores.push(scores[index, scores.length / turns].min)
    end
    turn_scores
  end

  def tree
    find_empty_spaces.permutation.to_a
  end

  def generate_scores
    scores = []
    tree.each do |branch|
      scores.push(branch_score(branch))
    end
    scores
  end

  private

  def branch_score(branch)
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
