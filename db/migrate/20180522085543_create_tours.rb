class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :short_description
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
