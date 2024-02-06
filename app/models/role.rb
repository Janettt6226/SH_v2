class Role < ApplicationRecord
  belongs_to :player, optional: true
  validates :title, inclusion: { in: ['Liberal', 'Nazi', 'Hitler'] }
end
