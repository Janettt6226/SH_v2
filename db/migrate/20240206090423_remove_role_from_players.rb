class RemoveRoleFromPlayers < ActiveRecord::Migration[7.0]
  def change
    remove_column :players, :role
  end
end
