FactoryBot.define do
  factory :booking do
    association :user
    association :description_detail
    price {Faker::Number.decimal(2)}
    quantity {Faker::Number.between(1, 5)}
  end
end
