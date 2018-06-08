class CreateDescriptionDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :description_details do |t|
      t.string :image
      t.text :content
      t.string :itinerary
      t.integer :duration
      t.float :price
      t.float :rating
      t.references :tour, foreign_key: true

      t.timestamps
    end
  end
end
