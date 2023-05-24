# == Schema Information
#
# Table name: user_activities
#
#  id         :bigint           not null, primary key
#  country    :string
#  ip_address :string
#  page_url   :string
#  visited_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#  inbox_id   :integer
#
class UserActivity < ApplicationRecord
end
