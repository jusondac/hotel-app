class AddDescriptionToFacilities < ActiveRecord::Migration[8.0]
  def change
    add_column :facilities, :description, :text
  end
end
