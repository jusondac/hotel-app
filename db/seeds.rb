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

master_role = Role.find_or_create_by!(name: "Master") do |role|
  role.description = "System administrator with full access to all hotel management features"
end

manager_role = Role.find_or_create_by!(name: "Manager") do |role|
  role.description = "Hotel manager with access to bookings, staff management, and reporting"
end

staff_role = Role.find_or_create_by!(name: "Staff") do |role|
  role.description = "Hotel staff member with access to daily operations and guest services"
end

receptionist_role = Role.find_or_create_by!(name: "Receptionist") do |role|
  role.description = "Front desk staff with access to check-in/check-out and guest management"
end

puts "Created #{Role.count} roles"

# Create users for hotel management
puts "Creating users..."

master_user = User.find_or_create_by!(email_address: "master@hotel.com") do |user|
  user.password = "master123"
  user.password_confirmation = "master123"
  user.role = master_role
end

manager_user = User.find_or_create_by!(email_address: "manager@hotel.com") do |user|
  user.password = "manager123"
  user.password_confirmation = "manager123"
  user.role = manager_role
end

staff_user = User.find_or_create_by!(email_address: "staff@hotel.com") do |user|
  user.password = "staff123"
  user.password_confirmation = "staff123"
  user.role = staff_role
end

puts "Created #{User.count} users"

# Create inventories for hotel management
puts "Creating inventories..."

towels_inventory = Inventory.find_or_create_by!(name: "Towels") do |inventory|
  inventory.quantity = 50
  inventory.unit = "pieces"
end

bed_sheets_inventory = Inventory.find_or_create_by!(name: "Bed Sheets") do |inventory|
  inventory.quantity = 30
  inventory.unit = "sets"
end

pillows_inventory = Inventory.find_or_create_by!(name: "Pillows") do |inventory|
  inventory.quantity = 40
  inventory.unit = "pieces"
end

toiletries_inventory = Inventory.find_or_create_by!(name: "Toiletries") do |inventory|
  inventory.quantity = 100
  inventory.unit = "sets"
end

tv_inventory = Inventory.find_or_create_by!(name: "Television") do |inventory|
  inventory.quantity = 20
  inventory.unit = "units"
end

puts "Created #{Inventory.count} inventories"

# Create room types
puts "Creating room types..."

standard_room_type = RoomType.find_or_create_by!(name: "Standard Room") do |room_type|
  room_type.description = "Comfortable room with basic amenities"
end

deluxe_room_type = RoomType.find_or_create_by!(name: "Deluxe Room") do |room_type|
  room_type.description = "Spacious room with premium amenities"
end

suite_room_type = RoomType.find_or_create_by!(name: "Suite") do |room_type|
  room_type.description = "Luxury suite with separate living area"
end

puts "Created #{RoomType.count} room types"

# Create rooms with inventory assignments
puts "Creating rooms..."

# Standard rooms with basic inventory
(101..105).each do |room_number|
  Room.find_or_create_by!(name: "Room #{room_number}") do |room|
    room.room_type = standard_room_type
    room.price = 100.00
    room.inventory = towels_inventory
  end
end

# Deluxe rooms with premium inventory
(201..203).each do |room_number|
  Room.find_or_create_by!(name: "Room #{room_number}") do |room|
    room.room_type = deluxe_room_type
    room.price = 150.00
    room.inventory = bed_sheets_inventory
  end
end

# Suites with luxury inventory
(301..302).each do |room_number|
  Room.find_or_create_by!(name: "Suite #{room_number}") do |room|
    room.room_type = suite_room_type
    room.price = 250.00
    room.inventory = tv_inventory
  end
end

puts "Created #{Room.count} rooms"

puts "Seeding completed successfully!"
