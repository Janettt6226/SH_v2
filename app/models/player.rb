class Player < ApplicationRecord
  belongs_to :game
  has_one :role, dependent: :destroy
  PARTIES = ["Liberal", "Liberal", "Liberal", "Liberal", "Fascist", "Fascist", "Fascist"]
  validates :username, presence: true
  validates :killed, :chancelier, :president, inclusion: { in: [true, false] }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 7 }, allow_nil: true
  validates :party, inclusion: { in: PARTIES }, allow_nil: true

end
