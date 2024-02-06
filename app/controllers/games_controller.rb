class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game)
  end
end
