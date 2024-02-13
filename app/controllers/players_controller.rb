class PlayersController < ApplicationController
  before_action :set_game, only: %i[index new create]
  before_action :set_player, only: %i[show]

  def index
    @players = @game.players.all.order(position: :asc)
  end

  def show
    @game = @player.game
    @next_player = Player.find_by(game_id: @game.id, position: @player.position + 1)
    @previous_player = Player.find_by(game_id: @player.game_id, position: @player.position - 1)
    @round = Round.new
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.game = @game
    # set_party
    # @player.party = @assigned_party
    # set_role
    # @player.role = @assigned_role
    if @player.save!
      redirect_to game_path(@game)
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

end
