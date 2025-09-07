class FacilitiesController < ApplicationController
  layout "dashboard"
  before_action :set_room, only: [ :show, :new, :create, :edit, :update, :destroy ]
  before_action :set_facility, only: [ :show, :edit, :update, :destroy ]

  # GET /facilities
  def index
    @facilities = Facility.includes(:room, :inventory).all
  end

  # GET /rooms/:room_id/facilities/:id
  def show
  end

  # GET /rooms/:room_id/facilities/new
  def new
    @facility = @room.facilities.build
    @facility.build_inventory
  end

  # GET /rooms/:room_id/facilities/:id/edit
  def edit
  end

  # POST /rooms/:room_id/facilities
  def create
    @facility = @room.facilities.build(facility_params)
    @facility.build_inventory(inventory_params) if inventory_params.present?

    respond_to do |format|
      if @facility.save
        format.html { redirect_to room_facility_path(@room, @facility), notice: "Facility was successfully created." }
        format.json { render :show, status: :created, location: [ @room, @facility ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/:room_id/facilities/:id
  def update
    respond_to do |format|
      if @facility.update(facility_params)
        @facility.inventory&.update(inventory_params) if inventory_params.present?
        format.html { redirect_to room_facility_path(@room, @facility), notice: "Facility was successfully updated." }
        format.json { render :show, status: :ok, location: [ @room, @facility ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/:room_id/facilities/:id
  def destroy
    @facility.destroy!

    respond_to do |format|
      format.html { redirect_to @room, status: :see_other, notice: "Facility was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id]) if params[:room_id]
  end

  def set_facility
    @facility = @room ? @room.facilities.find(params[:id]) : Facility.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:name)
  end

  def inventory_params
    params.dig(:facility, :inventory_attributes)&.permit(:quantity)
  end
end
