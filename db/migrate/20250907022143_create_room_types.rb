class CreateRoomTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :room_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
