class AddColumnToTours < ActiveRecord::Migration[5.0]
  def change
    add_column :tours, :rating, :float
    add_column :tours, :image, :string
    add_column :tours, :itinerary, :string
    add_column :tours, :content, :text
  end
end
