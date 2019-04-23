class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|

      t.integer :team_one
      t.integer :team_two
      t.string :name
      t.datetime :time
      t.integer :tournament
      t.string :game_score

      t.timestamps
    end
  end
end
