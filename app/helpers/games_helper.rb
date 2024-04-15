module GamesHelper

  def current_round
    set_game
    current_round = @game.rounds.last
  end

  def activate_powers
    set_game
    set_board
    case @board.fascist_policies_count
      when 2
      render "games/watch_party"
      when 3
        render "games/nominate_president"
      when 4 || 5
        render "games/kill_player"
        
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def set_board
    @board = @game.board
  end
end
