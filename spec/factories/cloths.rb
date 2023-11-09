FactoryBot.define do
  factory :cloth do
    association :user
    association :cloth_type
    description { "this is test description" }
    last_worn_on { "2000-11-11" }

    after(:build) do |cloth|
      cloth.image.attach(io: File.open(Rails.root.join('spec/fixtures/images/test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
