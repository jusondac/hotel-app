class AccountManagerController < ApplicationController
  layout 'dashboard'
  
  def index
    @users = User.includes(:role).order(:created_at)
    @roles = Role.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.password = "password123"
    
    # Set default role as staff
    staff_role = Role.find_or_create_by(name: "staff")
    @user.role = staff_role
    
    if @user.save
      redirect_to account_manager_index_path, notice: "User created successfully"
    else
      render :new
    end
  end
  
  def update_role
    @user = User.find(params[:id])
    @role = Role.find(params[:role_id])
    
    if @user.update(role: @role)
      render json: { success: true, message: "Role updated successfully" }
    else
      render json: { success: false, errors: @user.errors.full_messages }
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email_address)
  end
end
