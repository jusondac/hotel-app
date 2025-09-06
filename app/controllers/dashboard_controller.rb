class DashboardController < ApplicationController
  layout 'dashboard'
  
  def index
    @user = Current.user
    @total_users = User.count
    @total_roles = Role.count
    @recent_users = User.includes(:role).order(created_at: :desc).limit(5)
    @user_stats_by_role = User.joins(:role).group('roles.name').count
    
    # If no users have roles yet, create a fallback
    if @user_stats_by_role.empty? && @total_users > 0
      @user_stats_by_role = { "Unassigned" => @total_users }
    end
  end
end
