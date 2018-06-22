day = Faker::Date.forward(10)

FactoryBot.define do
  factory :description_detail do
    association :tour
    price {Faker::Number.decimal(2)}
    start_day day
    end_day day + 5.days
  end
end
