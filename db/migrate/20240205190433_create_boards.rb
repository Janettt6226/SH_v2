class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.boolean :liberal_1, default: false
      t.boolean :liberal_2, default: false
      t.boolean :liberal_3, default: false
      t.boolean :liberal_4, default: false
      t.boolean :liberal_5, default: false
      t.boolean :fascist_1, default: false
      t.boolean :fascist_2, default: false
      t.boolean :fascist_3, default: false
      t.boolean :fascist_4, default: false
      t.boolean :fascist_5, default: false
      t.boolean :fascist_6, default: false

      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
