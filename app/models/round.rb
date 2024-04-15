class Round < ApplicationRecord
  belongs_to :game
  has_many :players, through: :game
  validates :game, presence: true

  def current_round
    @game = Game.find(params[:game_id])
    current_round = @game.rounds.last
  end
end
