class DashboardController < ApplicationController
  layout "dashboard"

  def index
    @user = Current.user

    # Dashboard statistics
    @total_rooms = Room.count
    @active_bookings = Booking.where("start_date <= ? AND end_date >= ?", Date.current, Date.current).count
    @room_occupancy = calculate_room_occupancy
    @total_revenue = Payment.sum(:amount) || 0

    # Recent data with nil safety
    @recent_bookings = Booking.includes(:room, :payments)
                              .order(created_at: :desc)
                              .limit(5) || []

    # Low inventory alerts (items with quantity < 10) with nil safety
    @low_inventory_items = Inventory.includes(:rooms)
                                   .where("quantity < ?", 10)
                                   .limit(10) || []

    # Upcoming checkouts (next 7 days) with nil safety
    @upcoming_checkouts = Booking.includes(:room)
                                 .where(end_date: Date.current..7.days.from_now)
                                 .order(:end_date) || []
  end

  private

  def calculate_room_occupancy
    return 0 if @total_rooms == 0
    ((@active_bookings.to_f / @total_rooms) * 100).round(1)
  end
end
