class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
  end
end
