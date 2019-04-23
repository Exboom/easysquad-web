class CreatePlayerTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :player_teams, primary_key: [:player, :team] do |t|

      t.integer :player
      t.integer :team

    end
  end
end
