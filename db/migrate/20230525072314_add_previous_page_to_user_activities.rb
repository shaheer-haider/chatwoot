class AddPreviousPageToUserActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :user_activities, :previous_page, :string
  end
end
