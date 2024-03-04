class PlayersController < ApplicationController
  before_action :set_game, only: %i[index new create]
  before_action :set_player, only: %i[show]

  def index
    @players = @game.players.all.order(position: :asc)
    if @players.any?{|p|p.role.nil? && p.party.nil?} && @players.count == 7
      set_available_roles
      @players.each do |player|
        player.role = @available_roles.pop
        if player.role == "Libéral"
          player.party = "Libéral"
        else
          player.party = "Fasciste"
        end
        player.save!(role: player.role, party: player.party)
      end
    end
  end

  def show
    @game = @player.game
    @next_player = Player.find_by(game_id: @game.id, position: @player.position + 1)
    @previous_player = Player.find_by(game_id: @player.game_id, position: @player.position - 1)
    @round = Round.new
    @hitler = @game.players.find_by(role: "Hitler")
    @second_nazi = @game.players.select{|p|p.role == "Nazi" && p.username != @player.username}.first
  end

  def new
    @player = Player.new
    @new_round = Round.new
    @round = Round.find_by(game_id: @game.id)
  end

  def create
    @player = Player.new(player_params)
    @player.game = @game
    # set_available_roles
    # @player.role = @available_roles.pop
    # remove_assigned_role(@player.position)
    if @player.save! && @game.players.count == 7
      redirect_to game_players_path(@game)
    elsif @player.save!
      redirect_to new_game_player_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:username, :killed, :party, :chancelier, :president, :position)
  end

  def set_available_roles
    @available_roles = Player::ROLES.shuffle
  end

  def remove_assigned_role(position)
    @available_roles.delete(position)
  end

end
