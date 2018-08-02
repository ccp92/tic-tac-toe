# frozen_string_literal: true

describe Minimax do
  it 'will generate a tree of 24 branches with 4 spaces left' do
    board = [:O, :X, :O, :X, nil, nil, nil, :O, nil]
    tree = Minimax.new(board: board).tree
    expect(tree.length).to eq(24)
  end

  it 'will generate a tree of 6 branches with 3 spaces left in the right order' do
    board = [:O, :X, :O, :X, :X, nil, nil, :O, nil]
    tree = Minimax.new(board: board).tree
    expect(tree).to eq([[5, 6, 8],[5, 8, 6],[6, 5, 8],[6, 8, 5],[8, 5, 6],[8, 6, 5]])
  end

  it 'will generate an array of scores based on the tree (3 spaces left)' do
    board = [:O, :X, :O, :X, :X, nil, nil, :O, nil]
    scores = Minimax.new(board: board).branch_scores
    expect(scores).to eq([11, 1, -8, 1, -8, 11])
  end

  it 'will generate an array of scores based on the tree (4 spaces left)' do
    board = [:X, :O, :X, :O, nil, nil, :X, nil, nil]
    scores = Minimax.new(board: board).branch_scores
    expect(scores).to eq([12, 1, 12, 1, 12, 12, -7, -7, 12, -9, 12, -9, -7, -7, 12, -9, 12, -9, -7, -7, 1, -9, 1, -9])
  end
end
