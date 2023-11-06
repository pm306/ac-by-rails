FactoryBot.define do
  factory :cloth do
    user_id { 1 }
    description { "MyText" }
    last_worn_on { "2023-11-06" }
    type_name { "MyString" }
    category { 1 }
  end
end
