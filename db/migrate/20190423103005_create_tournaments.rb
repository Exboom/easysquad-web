class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|

      t.string :name
      t.string :season
      t.integer :location
      t.integer :federation

      t.timestamps
    end
  end
end
