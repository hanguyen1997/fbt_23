FactoryBot.define do
  factory :rating do
    association :user
    association :tour
    point {Faker::Number.between(1, 5)}
  end
end
