class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
    @player = Player.new
    @players = @game.players
    @board = Board.find_by(game_id: @game.id)
    @pile = Law.select{|law| law.game_id == @game.id && law.draw == true}
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save!
      @board = Board.create!(game_id: @game.id) if @game.board.nil?
      redirect_to new_game_player_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_players
    @game = Game.find(params[:id])
    @players = @game.players
  end

  def update_players
    @game = Game.find(params[:id])
    @players = @game.players
    if @players.count == 7
      # set_roles
      # set_partis
      set_roles_and_parties
      redirect_to game_players_path(@game)
    end
  end

  private

  def game_params
    params.require(:game)
  end

  def players_params
    # params.require(:player).permit(:party, :role)
    @players.map do |player|
      # { id: player.id, party: @assigned_party, role: @assigned_role }
      { id: player.id, party: player.party, role: player.role }

    end
  end

  def set_partis
    parties = Player::PARTIES.shuffle
    attributes = {}
    @players.each do |player|
      attributes[player.id] = { party: parties.first}
      parties.shift
    end
    Player.update(attributes.keys, attributes.values)
  end

  def set_roles
    roles = Player::ROLES.shuffle
    attributes = {}
    @players.each do |player|
      attributes[player.id] = { role: roles.first }
      roles.shift
    end
    Player.update(attributes.keys, attributes.values)
  end


  def set_roles_and_parties
    roles = Player::ROLES.shuffle
    @players.each_with_index do |player, index|
      player.update!(role: roles[index])
      if player.role == "Libéral"
        player.update!(party: "Libéral")
      else
        player.update!(party: "Fasciste")
      end
    end
  end
end
