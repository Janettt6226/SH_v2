class Board < ApplicationRecord
  belongs_to :game
  validates :liberal_policies_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :fascist_policies_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }
end
