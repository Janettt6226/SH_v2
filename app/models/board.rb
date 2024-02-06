class Board < ApplicationRecord
  belongs_to :game
  validates :liberal_policies_count, numericality: { only_integer: true }, in: 0..5
  validates :fascist_policies_count, numericality: { only_integer: true }, in: 0..6
end
