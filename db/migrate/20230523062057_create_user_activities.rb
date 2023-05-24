class CreateUserActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :user_activities do |t|
      t.datetime :visited_at
      t.string :country
      t.string :page_url
      t.integer :inbox_id
      t.string :ip_address

      t.timestamps
    end
  end
end
