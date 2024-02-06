class Player < ApplicationRecord
  belongs_to :game
  has_one :role
  validates :username, :killed, :chancelier, :president, presence: true
  validates :position, numericality: { only_integer: true }, in: 1..7
  validates :party, inclusion: { in: ["Liberal", "Fascist"] }
  validates :role_id, presence: true
end
