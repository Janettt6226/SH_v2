class Role < ApplicationRecord
  belongs_to :player
  validates :title, inclusion: { in: ['Liberal', 'Fascist', 'Hitler'] }
end
