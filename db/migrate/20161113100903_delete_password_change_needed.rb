class DeletePasswordChangeNeeded < ActiveRecord::Migration
  def change
    remove_column :users, :password_change_needed
  end
end
