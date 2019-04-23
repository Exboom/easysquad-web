class CreateChekins < ActiveRecord::Migration[5.2]
  def change
    create_table :chekins do |t|

      t.integer :player
      t.integer :team
      t.integer :game
      t.boolean :chekin, default: false
      t.integer :reasons
      t.boolean :presence, default: false
      t.string :comment

      t.timestamps
    end
  end
end
