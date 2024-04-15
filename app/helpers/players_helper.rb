module PlayersHelper

  def liberal_players
    liberal_players = @game.players.where(party: "Libéral")
  end

  def fascist_players
    fascist_players = @game.players.where(party: "Fasciste")
  end

  def hitler
    @game.players.find_by(role: "Hitler")
  end
end
