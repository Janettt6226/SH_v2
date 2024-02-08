class Role < ApplicationRecord
  belongs_to :player, optional: true
  validates :title, inclusion: { in: ROLES }

  ROLES = ['Liberal','Liberal','Liberal','Liberal', 'Nazi', 'Nazi', 'Hitler']
end
