class AddColumnsToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :liberal_policies_count, :integer
    add_column :boards, :fascist_policies_count, :integer
    remove_column :boards, :liberal_1
    remove_column :boards, :liberal_2
    remove_column :boards, :liberal_3
    remove_column :boards, :liberal_4
    remove_column :boards, :liberal_5
    remove_column :boards, :fascist_1
    remove_column :boards, :fascist_2
    remove_column :boards, :fascist_3
    remove_column :boards, :fascist_4
    remove_column :boards, :fascist_5
    remove_column :boards, :fascist_6
  end
end
