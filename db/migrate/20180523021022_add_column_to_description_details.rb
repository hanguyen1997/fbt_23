class AddColumnToDescriptionDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :description_details, :start_day, :datetime
    add_column :description_details, :end_day, :datetime
  end
end
