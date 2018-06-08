class DescriptionDetail < ApplicationRecord
  belongs_to :tour
  has_many :bookings

  validates :price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.description_details.limit_price}
  validates :start_day, presence: true
  validates :end_day, presence: true
  validate :check_day, on: [:update, :create]

  scope :available, ->{where deleted: false}
  scope :check_pending_booking, ->(id, status) do
    where "description_details.id = ? AND bookings.status = ?", id, status
  end
  scope :hidden_expired_detail, ->{where "start_day > ?", Date.today}

  def check_day
    if start_day.present? && end_day.present?
      if start_day > end_day || Date.today > start_day
        errors.add :error, I18n.t("error_check_day")
      end
    end
  end

  def pending_booking? id
    DescriptionDetail.joins(:bookings).check_pending_booking(id, :pending).any?
  end
end
