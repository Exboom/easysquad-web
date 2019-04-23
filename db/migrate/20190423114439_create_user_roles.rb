class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles, primary_key: [:user, :role] do |t|

      t.integer :user
      t.integer :role
      t.integer :team

    end
  end
end
