class RemoveTourFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_reference :bookings, :tour, foreign_key: true
  end
end
