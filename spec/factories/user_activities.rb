FactoryBot.define do
  factory :user_activity do
    visited_at { "2023-05-23 06:20:59" }
    country { "MyString" }
    page_url { "MyString" }
    inbox_id { 1 }
    ip_address { "MyString" }
  end
end
