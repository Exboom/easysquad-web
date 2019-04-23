class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|

      t.integer :player
      t.integer :team
      t.integer :tournament

      t.timestamps
    end
  end
end
