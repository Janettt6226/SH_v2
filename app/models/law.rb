class Law < ApplicationRecord
  belongs_to :game
  validates :title, inclusion: { in: ["Liberal", "Fascist"] }
  validates :draw, :discard, inclusion: { in: [true, false] }, allow_nil: true
end
