class UpdateUserRoles < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :admin
    remove_column :users, :teacher
    remove_column :users, :student
    add_column    :users, :role, :integer
  end
end
