class Round < ApplicationRecord
  belongs_to :game
  validates :game, presence: true
end
