class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, default: ""
      t.integer :owner
      t.integer :captain

      t.timestamps
    end
  end
end
