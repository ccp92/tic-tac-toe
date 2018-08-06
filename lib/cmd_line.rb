require_relative 'view_grid'
require_relative 'update_grid'
require_relative 'disk_based_memory'
require_relative 'human_plays'
require_relative 'ai_player'
require_relative 'minimax'

puts 'Start game? (y/n)'
starting_input = gets.chomp

def end_of_game?(memory)
  memory.result == :winner || memory.result == :draw
end

def convert_to_cli(grid)
  "[#{grid[0] || ' '}][#{grid[1] || ' '}][#{grid[2] || ' '}]\n" +
  "[#{grid[3] || ' '}][#{grid[4] || ' '}][#{grid[5] || ' '}]\n" +
  "[#{grid[6] || ' '}][#{grid[7] || ' '}][#{grid[8] || ' '}]"
end

def play(position)
  memory = DiskBasedMemory.new
  update_grid = UpdateGrid.new(game_state: memory)
  if end_of_game?(memory)
    nil
  else
    HumanPlayer.new(update_grid: update_grid, game_state: memory).plays(position)
    AIPlayer.new(update_grid: update_grid, game_state: memory).execute unless memory.result == :draw
  end
  board
end

def board
  memory = DiskBasedMemory.new
  response = ViewGrid.new(game_state: memory).execute({})
  grid = memory.state
  return puts 'Computer wins' if memory.result == :winner
  return puts 'Draw' if memory.result == :draw
  output = convert_to_cli(grid)
  puts "#{output}"
  puts 'Your move:'
  human_move = gets.chomp.to_i - 1
  play(human_move)
end

if starting_input == 'y'
  puts "[ ][ ][ ]\n[ ][ ][ ]\n[ ][ ][ ]"
  puts "Your move: (1-9)"
  human_move = gets.chomp.to_i - 1
  play(human_move)
else
  puts 'Game Aborted'
end

