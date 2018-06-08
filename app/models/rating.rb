class Rating < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :point, numericality: {greater_than_or_equal_to: Settings.rating.min_point,
    less_than_or_equal_to: Settings.rating.max_point}
end
