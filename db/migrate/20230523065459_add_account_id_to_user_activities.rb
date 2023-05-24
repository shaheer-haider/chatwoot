class AddAccountIdToUserActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :user_activities, :account_id, :integer
  end
end
