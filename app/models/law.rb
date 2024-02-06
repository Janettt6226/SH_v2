class Law < ApplicationRecord
  belongs_to :game
  validates :title, inclusion: { in: ["Liberal", "Fascist"] }
  validates :draw, :discard, presence: true
end
