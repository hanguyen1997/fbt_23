FactoryBot.define do
  factory :tour do
    association :category
    name {Faker::Name.name}
    short_description {Faker::Lorem.sentence}
    image  Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/app/assets/images/tour-1.jpg")))
    itinerary {Faker::Lorem.sentence}
    content {Faker::Lorem.paragraph}

    after(:build) do |tour|
      5.times do
        tour.description_details << FactoryBot.build(:description_detail, tour: tour)
      end
    end

    factory :tour_has_booking_pending do
      after(:build) do |tour|
        tour.description_details.first.bookings << FactoryBot.build(:booking, description_detail: tour.description_details.first)
      end
    end
  end
end
