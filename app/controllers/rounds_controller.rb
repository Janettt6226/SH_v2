require 'pry-byebug'

class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    @game = @round.game
    @players = @game.players
    if @game.rounds.first == @round
      set_first_president
    else
      set_president
    end
    set_chancelier
  end

  def new
    @round = Round.new
    @game = Game.find(params[:game_id])

  end

  def create
    # binding.pry
    @game = Game.find(params[:game_id])

    @round = Round.new(round_params)
    @game.id = @round.game_id
    if @round.save!
      redirect_to @round
    else
      render :new
    end
  end

  private

  def round_params
    params.require(:round).permit(:game_id)
  end

  def set_first_president
    @president = @players.find_by(position: 1)
    @president.update!(president: true) if @president.present?
  end

  def set_president
    @players.each do |player|
      if player.president? && player.position < 7
        @previous_president = player
        next_president = @players.find_by(position: @previous_president.position + 1)
        next_president.update!(president: true)
        @previous_president.update!(president: false)
      end
      if player.president? && player.position == 7
        @previous_president = player
        player.update!(president: false)
        next_president = @players.find_by(position: 1)
        next_president.update!(president: true)
      end
    end
    @president = @players.find_by(president: true)
  end

  def set_chancelier
    @excluded_players = [@previous_president, @previous_chancelier, @president]
    @candidates = @players - @excluded_players
  end
end
