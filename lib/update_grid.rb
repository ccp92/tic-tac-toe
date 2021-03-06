# frozen_string_literal: true

class UpdateGrid
  def initialize(game_state:)
    @game_state = game_state
    initial_state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    @game_state.save(initial_state) if @game_state.state.nil?
  end

  def execute(player, position)
    @copy = @game_state.state.dup
    @copy[position] = player
    @game_state.save(@copy)
    @game_state.save_result(:draw) unless spaces_remain?
    @game_state.save_result(:winner) if winner?
  end

  private

  def winner?
    lines = [horizontal_lines, vertical_lines, diagonal_lines].flatten(1)
    lines.include?(%i[O O O])
  end

  def spaces_remain?
    @copy.include?(nil)
  end

  def horizontal_lines
    [places(0, 1, 2), places(3, 4, 5), places(6, 7, 8)]
  end

  def vertical_lines
    [places(0, 3, 6), places(1, 4, 7), places(2, 5, 8)]
  end

  def diagonal_lines
    [places(0, 4, 8), places(2, 4, 6)]
  end

  def places(place1, place2, place3)
    @copy.values_at(place1, place2, place3)
  end
end
