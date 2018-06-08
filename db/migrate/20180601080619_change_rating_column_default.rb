class ChangeRatingColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tours, :rating, from: nil, to: 0
  end
end
