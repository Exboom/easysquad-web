class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|

      t.integer :whose_event
      t.string :what_event
      t.datetime :time_event

      t.timestamps
    end
  end
end
