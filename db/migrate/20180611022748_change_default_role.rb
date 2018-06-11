class ChangeDefaultRole < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :role, from: nil, to: 0
  end
end
