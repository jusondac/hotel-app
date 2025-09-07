class DashboardController < ApplicationController
  layout "dashboard"

  def index
    @user = Current.user

    # User and role statistics
    @total_users = User.count
    @total_roles = Role.count
    @recent_users = User.includes(:role).order(created_at: :desc).limit(5)
    @user_stats_by_role = User.joins(:role).group("roles.name").count

    # Hotel booking system statistics
    @total_rooms = Room.count
    @total_bookings = Booking.count
    @active_bookings = Booking.where("start_date <= ? AND end_date >= ?", Date.current, Date.current).count
    @total_revenue = Payment.sum(:amount)
    @recent_bookings = Booking.includes(:room, :payments).order(created_at: :desc).limit(5)
    @room_occupancy = calculate_room_occupancy
    @upcoming_checkouts = Booking.where(end_date: Date.current..1.week.from_now).includes(:room).order(:end_date).limit(5)

    # Facilities and inventory
    @total_facilities = Facility.count
    @low_inventory_items = Inventory.joins(:facility).where("quantity < ?", 5).includes(:facility)

    # If no users have roles yet, create a fallback
    if @user_stats_by_role.empty? && @total_users > 0
      @user_stats_by_role = { "Unassigned" => @total_users }
    end
  end

  private

  def calculate_room_occupancy
    return 0 if @total_rooms == 0
    ((@active_bookings.to_f / @total_rooms) * 100).round(1)
  end
end
