class RemoveColumnsFromRooms < ActiveRecord::Migration[8.0]
  def change
    remove_column :rooms, :price, :decimal
    remove_column :rooms, :room_type, :string
    remove_column :rooms, :inventory_id, :integer
  end
end
