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
    # @law.discard = true
    # @law.draw = false
    if @law.update(discard: true)
      head :no_content
    else
      render :edit, status: :unprocessable_entity
    end
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
    @board = Board.find_by(game_id: @law.game_id)
    @law.update!(discard: true)
      @played_law = @chancellor_draw.reject{|law|law == @law}.first
    if @played_law.update!(draw: false)
      @played_law.title == "Liberal" ? @board.liberal_policies_count += 1 : @board.fascist_policies_count += 1
      @board.save!


      @round = Round.create!(game_id: @law.game_id)
      @next_round = Round.find_by(id: 1 + params[:id].to_i)
      redirect_to game_round_path(@law.game, @next_round)
    else
      render :edit_chancellor_selection, status: :unprocessable_entity
    end

  end

  private

  def law_params
    params.require(:law).permit(:discard, :draw, :id, :title)
  end
end
