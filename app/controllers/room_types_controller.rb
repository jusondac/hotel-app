class RoomTypesController < ApplicationController
  layout "dashboard"
  before_action :set_room_type, only: %i[ show edit update destroy ]

  # GET /room_types or /room_types.json
  def index
    @room_types = RoomType.includes(:facilities, :rooms).all
  end

  # GET /room_types/1 or /room_types/1.json
  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @room_type.as_json(
          include: {
            facilities: {
              include: :inventory
            }
          }
        )
      }
    end
  end

  # GET /room_types/new
  def new
    @room_type = RoomType.new
    # Start with 3 empty facilities for the form
    3.times { @room_type.facilities.build.build_inventory }
  end

  # GET /room_types/1/edit
  def edit
    # Add one empty facility if none exist
    @room_type.facilities.build.build_inventory if @room_type.facilities.empty?
  end

  # POST /room_types or /room_types.json
  def create
    @room_type = RoomType.new(room_type_params)

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to @room_type, notice: "Room type was successfully created." }
        format.json { render :show, status: :created, location: @room_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_types/1 or /room_types/1.json
  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to @room_type, notice: "Room type was successfully updated." }
        format.json { render :show, status: :ok, location: @room_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_types/1 or /room_types/1.json
  def destroy
    @room_type.destroy!

    respond_to do |format|
      format.html { redirect_to room_types_path, status: :see_other, notice: "Room type was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_room_type
    @room_type = RoomType.find(params[:id])
  end

  def room_type_params
    params.require(:room_type).permit(:name, :description,
      facilities_attributes: [ :id, :name, :description, :_destroy,
        inventory_attributes: [ :id, :quantity, :unit, :_destroy ] ])
  end
end
