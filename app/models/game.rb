class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :laws, dependent: :destroy
  has_one :board, dependent: :destroy

end
