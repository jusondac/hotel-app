class RestructureFacilitiesAndInventory < ActiveRecord::Migration[8.0]
  def change
    # Add name column to inventories (moving from facilities)
    add_column :inventories, :name, :string

    # Remove facility_id from inventories since inventory will have many rooms
    remove_foreign_key :inventories, :facilities
    remove_column :inventories, :facility_id, :integer

    # Add inventory_id to rooms since one inventory has many rooms
    add_reference :rooms, :inventory, null: true, foreign_key: true

    # Remove name from facilities since it's moving to inventory
    remove_column :facilities, :name, :string

    # Remove room_type_id from facilities since facilities now only belong to rooms
    remove_foreign_key :facilities, :room_types
    remove_column :facilities, :room_type_id, :integer
  end
end
