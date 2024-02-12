class Role < ApplicationRecord
  # belongs_to :player, optional: true
  ROLES = ['Libéral','Libéral','Libéral','Libéral', 'Nazi', 'Nazi', 'Hitler']
  validates :title, inclusion: { in: ROLES }
end
