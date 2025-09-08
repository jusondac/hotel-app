# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create roles for hotel management
puts "Creating roles..."
roles = {
  "Master" => "System administrator with full access to all hotel management features",
  "Manager" => "Hotel manager with access to bookings, staff management, and reporting",
  "Staff" => "Hotel staff member with access to daily operations and guest services",
  "Receptionist" => "Front desk staff with access to check-in/check-out and guest management"
}

role_records = roles.transform_values do |desc|
  Role.find_or_create_by!(name: roles.key(desc)) { |role| role.description = desc }
end

puts "Created #{Role.count} roles"

puts "Creating users..."
[
  { email_address: "master@hotel.com", role: role_records["Master"] },
  { email_address: "manager@hotel.com", role: role_records["Manager"] },
  { email_address: "staff@hotel.com", role: role_records["Staff"] },
  { email_address: "receptionist@hotel.com", role: role_records["Receptionist"] }
].each do |attrs|
  User.find_or_create_by!(email_address: attrs[:email_address], role: attrs[:role]) do |u|
    u.password = u.password_confirmation = "password123"
  end
end

puts "Created #{User.count} users"

# Create inventories for hotel management
puts "Creating inventories..."
towels_inventory      = Inventory.find_or_create_by!(name: "Towels")      { |i| i.quantity = 50;  i.unit = "pieces" }
bed_sheets_inventory  = Inventory.find_or_create_by!(name: "Bed Sheets")  { |i| i.quantity = 30;  i.unit = "sets" }
pillows_inventory     = Inventory.find_or_create_by!(name: "Pillows")     { |i| i.quantity = 40;  i.unit = "pieces" }
toiletries_inventory  = Inventory.find_or_create_by!(name: "Toiletries")  { |i| i.quantity = 100; i.unit = "sets" }
tv_inventory          = Inventory.find_or_create_by!(name: "Television")  { |i| i.quantity = 20;  i.unit = "units" }

puts "Created #{Inventory.count} inventories"

# Create room types
puts "Creating room types..."
%w[standard deluxe suite].each do |type|
  # Use instance_variable_set to dynamically create instance variables for each room type.
  # Example: For "Standard Room", creates @standard_room_type = RoomType.find_or_create_by!(name: "Standard Room")
  instance_variable_set(
    "@#{type.downcase.gsub(' ', '_')}_room_type",
    RoomType.find_or_create_by!(name: type, price: rand(80..300), description: "#{type} with all standard amenities")
  )
end

puts "Created #{RoomType.count} room types"
# Create rooms with inventory assignments
puts "Creating rooms..."
[
  { range: 101..105, type: :standard_room_type, price: 100.00, inventory: towels_inventory, prefix: "Room" },
  { range: 201..203, type: :deluxe_room_type,   price: 150.00, inventory: bed_sheets_inventory, prefix: "Room" },
  { range: 301..302, type: :suite_room_type,    price: 250.00, inventory: tv_inventory, prefix: "Suite" }
].each do |config|
  config[:range].each do |room_number|
    Room.find_or_create_by!(name: "#{config[:prefix]} #{room_number}") do |room|
      room.room_type = instance_variable_get("@#{config[:type]}")
    end
  end
end

puts "Created #{Room.count} rooms"

puts "Seeding completed successfully!"
