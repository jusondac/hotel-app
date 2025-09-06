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
puts "Seeding completed successfully!"
