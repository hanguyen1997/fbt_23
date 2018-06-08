class Category < ApplicationRecord
  has_many :childs, class_name: Category.name, foreign_key: :parent_id
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :tours

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  scope :super, ->{where parent_id: nil}
  scope :available, ->{where deleted: false}
  scope :booking_by_id_and_status, ->(id, status) do
    joins(tours: {description_details: :bookings})
      .where "categories.id = ? AND bookings.status = ?", id, status
  end
end
