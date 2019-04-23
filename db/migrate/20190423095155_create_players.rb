class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|

      t.string :name, default: ""
      t.date :birthday
      t.integer :gamenumber

      t.timestamps
    end
  end
end
