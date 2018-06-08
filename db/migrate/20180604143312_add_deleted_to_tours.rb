class AddDeletedToTours < ActiveRecord::Migration[5.0]
  def change
    add_column :tours, :deleted, :boolean, default: false
  end
end
