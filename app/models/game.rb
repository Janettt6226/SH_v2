class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :laws
  has_one :board

end
