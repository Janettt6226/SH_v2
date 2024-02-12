class Player < ApplicationRecord
  belongs_to :game
  # has_one :role, dependent: :destroy
  PARTIES = ["Libéral", "Libéral", "Libéral", "Libéral", "Fasciste", "Fasciste", "Fasciste"]
  ROLES = ['Libéral','Libéral','Libéral','Libéral', 'Nazi', 'Nazi', 'Hitler']

  validates :username, presence: true
  validates :killed, :chancelier, :president, inclusion: { in: [true, false] }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 7 }, allow_nil: true
  validates :party, inclusion: { in: PARTIES }, allow_nil: true
  validates :role, inclusion: { in: ROLES }, allow_nil: true

end
