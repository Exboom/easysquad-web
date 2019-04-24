class CreateTeamTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :team_tournaments, primary_key: [:team, :tournaments] do |t|

      t.integer :team
      t.integer :tournaments

    end
  end
end
