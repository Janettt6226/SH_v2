class CreateLaws < ActiveRecord::Migration[7.0]
  def change
    create_table :laws do |t|
      t.string :title
      t.boolean :discard, default: false
      t.boolean :draw, default: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
