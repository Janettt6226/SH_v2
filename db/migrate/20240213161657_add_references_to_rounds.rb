class AddReferencesToRounds < ActiveRecord::Migration[7.0]
  def change
    add_reference :rounds, :player
  end
end
