class ChangeRoleType < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :role
    change_column :users, :role, :integer
  end
end
