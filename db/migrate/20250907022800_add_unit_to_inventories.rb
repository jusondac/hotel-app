class AddUnitToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :unit, :string
  end
end
