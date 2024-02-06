class AddDefaultValuesToBoards < ActiveRecord::Migration[7.0]
  def change
    change_column :boards, :liberal_policies_count, :integer, default: 0
    change_column :boards, :fascist_policies_count, :integer, default: 0
  end
end
