class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :bookings
  has_many :comments
  has_many :likes
  has_many :ratings

  enum role: {admin: 1, customer: 0}
end
