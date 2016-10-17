class AddChangePasswordFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_change_needed, :boolean, default: false
  end
end
