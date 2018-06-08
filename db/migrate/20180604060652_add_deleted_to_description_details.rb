class AddDeletedToDescriptionDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :description_details, :deleted, :boolean, default: false
  end
end
