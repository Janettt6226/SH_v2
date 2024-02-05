class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :username
      t.boolean :killed, default: false
      t.string :role
      t.string :party
      t.boolean :chancelier, default: false
      t.boolean :president, default: false
      t.references :game, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
