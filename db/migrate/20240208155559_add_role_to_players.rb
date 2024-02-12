class AddRoleToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :role, :string
    remove_column :players, :role_id
  end
end
