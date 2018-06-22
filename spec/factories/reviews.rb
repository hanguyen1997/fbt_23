FactoryBot.define do
  factory :review do
    association :user
    association :tour
    content {Faker::Lorem.paragraph}
  end
end
