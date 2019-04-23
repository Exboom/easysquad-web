class ChangeTwo < ActiveRecord::Migration[5.2]
  def change
    change_table :reasons do |t|

      t.remove :created_at
      t.remove :updated_at

    end
    change_table :roles do |t|

      t.remove :created_at
      t.remove :updated_at

    end
  end
end
