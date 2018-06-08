class RemoveColumnFromDescriptionDetails < ActiveRecord::Migration[5.0]
  def change
    remove_column :description_details, :image, :string
    remove_column :description_details, :content, :text
    remove_column :description_details, :itinerary, :string
    remove_column :description_details, :duration, :integer
    remove_column :description_details, :rating, :float
  end
end
