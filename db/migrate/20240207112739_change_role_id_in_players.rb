class ChangeRoleIdInPlayers < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :role_id, :integer, null: true
  end
end
