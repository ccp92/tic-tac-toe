class ViewGrid
  def initialize(game_state:)
    @game_state = game_state
  end

  def execute(*)
    {
      grid: [@game_state[0..2],@game_state[3..5],@game_state[6..8]]
    }
  end
end
