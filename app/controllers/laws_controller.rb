require "pry-byebug"
class LawsController < ApplicationController

  def edit
    @law = Law.find( params[:id])
    @president_draw = Law.where(id: session[:president_draw])

  end

  def update
    president_draw_ids = session[:president_draw]
    @president_draw = Law.where(id: president_draw_ids)
    @law = @president_draw.find_by(id: params[:laws][:title].to_i)
    @law.discard = true
    @law.draw = false
    @law.save!
  end

  private

  def law_params
    params.require(:law).permit(:discard, :draw, :id, :title)
  end
end
