class RemoveColumnFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :start_day, :datetime
    remove_column :bookings, :end_day, :datetime
  end
end
