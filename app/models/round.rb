class Round < ApplicationRecord
  belongs_to :game
  has_many :players, through: :game
  validates :game, presence: true
end
