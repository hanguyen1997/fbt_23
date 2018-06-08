class AddDecriptionDetailToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :description_detail, foreign_key: true
  end
end
