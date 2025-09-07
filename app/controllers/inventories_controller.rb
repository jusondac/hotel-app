class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  # GET /inventories
  def index
    @inventories = Inventory.all
  end

  # GET /inventories/1
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories
  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to @inventory, notice: "Inventory was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /inventories/1
  def update
    if @inventory.update(inventory_params)
      redirect_to @inventory, notice: "Inventory was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /inventories/1
  def destroy
    @inventory.destroy!
    redirect_to inventories_url, notice: "Inventory was successfully destroyed."
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:name, :quantity, :unit)
  end
end
