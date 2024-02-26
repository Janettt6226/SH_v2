require 'pry-byebug'

class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    @game = @round.game
    @players = @game.players
    if @game.rounds.last == @round
      set_first_president
    else
      set_president
    end
    set_chancellor
    @chancellor = Player.find_by(id: @round.player_id)
    set_president_draw
    @law = Law.find(params[:id])
  end

  def new
    @game = Game.find(params[:game_id])
    @round = Round.new
  end

  def create
    @game = Game.find(params[:game_id])
    @round = Round.new(round_params)
    @game.id = @round.game_id
    if @round.save!
      redirect_to game_round_path(@game, @round)
    else
      render :new
    end
  end

  def edit_chancellor
    set_chancellor
    @round = Round.find(params[:id])
    @chancellor = Player.find(params[:player_id])
  end

  def update
    @round = Round.find(params[:id])
    @game = @round.game
    @chancellor = Player.find(params[:round][:player_id])
    if @round.update!(player_id: @chancellor.id)
      redirect_to game_round_path(@game, @round)
    else
      render :edit_chancellor, status: :unprocessable_entity
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

  def set_chancellor
    @excluded_players = [@previous_president, @previous_chancellor, @president]
    @candidates = @players - @excluded_players
  end

  def set_pile
  @pile = Law.all.shuffle
  # @pile = initial_pile.select {|law| law.draw == false }
  @pile.each{|law| law.update!(game_id: @round.game.id)}
  end

  def set_president_draw
    @pile = []
    if @game.rounds.first == @round || @pile == []
      set_pile
    elsif @pile.nil? || @pile.count < 3
      @pile = Law.where(discard: true).shuffle
      @pile.each{|law| law.update!(discard: false, draw: true)}
    else
      @pile = Law.find_by(draw: true)
    end
    @president_draw = @pile.first(3)
    session[:president_draw] = @president_draw.map(&:id)
    @president_draw.each do |law|
      law.update!(draw: true)
    end
  end

end
