FactoryBot.define do
  factory :booking do
    price {Faker::Number.decimal(2)}
    quantity {Faker::Number.between(1, 5)}
  end
end
