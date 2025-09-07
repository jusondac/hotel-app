class AddRoomTypeToRooms < ActiveRecord::Migration[8.0]
  def change
    add_reference :rooms, :room_type, null: true, foreign_key: true
  end
end
