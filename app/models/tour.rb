class Tour < ApplicationRecord
  belongs_to :category
  has_many :description_details
  has_many :reviews
  has_many :ratings

  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates :itinerary, presence: true
  validates :short_description, presence: true, length: {maximum: Settings.tour.length_short_des}
  validates :content, presence: true
  validates :image, presence: true
  validate :image_size

  scope :name_sort, ->{order "name asc"}
  scope :newest_tour, ->{order "created_at desc"}
  scope :recommended_tour, ->{order "rating desc"}
  scope :select_tours_by_category, ->(category_id){where category_id: category_id}
  scope :except_id, ->(id){where.not id: id}
  scope :search_by_tour_name, ->(name){where "lower(name) LIKE ?", "%#{name.downcase}%"}
  scope :available, ->{where deleted: false}
  scope :check_pending_booking, ->(id, status){where("tours.id = ? AND bookings.status = ?", id, status)}

  def update_rating_average
    rating_average = ratings.any? ? ratings.average(:point).to_i : 0
    self.update_attribute :rating, rating_average
  end

  def has_pending_booking? id
    Tour.joins(description_details: :bookings).check_pending_booking(id, :pending).any?
  end

  def delete_details
    description_details.available.update_all(deleted: true)
  end

  private

  def image_size
    return errors.add :image, I18n.t(".error_image_size") if image.size > 5.megabytes
  end
end
