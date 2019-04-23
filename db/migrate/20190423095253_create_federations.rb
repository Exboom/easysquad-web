class CreateFederations < ActiveRecord::Migration[5.2]
  def change
    create_table :federations do |t|

      t.string :name
      t.string :url
      t.string :contacts

      t.timestamps
    end
  end
end
