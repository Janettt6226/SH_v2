require "pry-byebug"
class LawsController < ApplicationController

  def edit
    @law = Law.find( params[:id])
    @president_draw = Law.where(id: session[:president_draw])
    @round = Round.find(params[:id])
    @chancellor = Player.find_by(id: @round.player_id).username
  end

  def update
    president_draw_ids = session[:president_draw]
    @president_draw = Law.where(id: president_draw_ids)
    @law = @president_draw.find_by(id: params[:laws][:title].to_i)
    @law.discard = true
    # @law.draw = false
    @law.save!
    # @chancellor_draw = @president_draw.select{|law|law.discard == false}
  end

  def edit_chancellor_selection
    @law = Law.find(params[:id])
    president_draw_ids = session[:president_draw]
    @president_draw = Law.where(id: president_draw_ids)
    @chancellor_draw = @president_draw.reject{|law|law.discard == true}
  end

  def update_chancellor_selection
    president_draw_ids = session[:president_draw]
    @president_draw = Law.where(id: president_draw_ids)
    @chancellor_draw = @president_draw.select{|law|law.discard == false}
    @law = Law.find_by(id: params[:laws][:title].to_i)
    # @law = @chancellor_draw.select{|law|law.id == params[:laws][:title].to_i}
    # Sélection de la carte à défausser
    @law.discard = true
    @law.save!
    # Je sélectionne la carte qui va être jouée par le chancelier
    @played_law = @chancellor_draw.reject{|law|law.discard == true}.first
    @played_law.draw = false
    if @played_law.save!
      @round = Round.create(game_id: @law.game_id)
      redirect_to game_round(@game, @round)
    else
      render :edit_chancellor_selection, status: :unprocessable_entity
    end
  end

  private

  def law_params
    params.require(:law).permit(:discard, :draw, :id, :title)
  end
end
