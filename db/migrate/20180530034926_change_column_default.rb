class ChangeColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :bookings, :status, from: nil, to: 0
  end
end
