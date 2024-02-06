class AddRoleReferencesToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :role, null: false, foreign_key: true
  end
end
