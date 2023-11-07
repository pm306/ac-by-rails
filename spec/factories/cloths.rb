FactoryBot.define do
  factory :cloth do
    association :user
    description { "this is test description" }
    last_worn_on { "2023-11-06" }
    association :cloth_type
  end
end
