class FarmersController < ApplicationController
  before_action :set_farmer, only: [:show, :update, :destroy]

  # GET /farmers
  # GET /farmers.json
  def index
    @farmers = Farmer.all
  end

  # GET /farmers/1
  # GET /farmers/1.json
  def show
  end

  # POST /farmers
  # POST /farmers.json
  def create
    @farmer = Farmer.new(farmer_params)

    if @farmer.save
      render :show, status: :created, location: @farmer
    else
      render json: @farmer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /farmers/1
  # PATCH/PUT /farmers/1.json
  def update
    if @farmer.update(farmer_params)
      render :show, status: :ok, location: @farmer
    else
      render json: @farmer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /farmers/1
  # DELETE /farmers/1.json
  def destroy
    @farmer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farmer
      @farmer = Farmer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def farmer_params
      params.fetch(:farmer, {})
    end
end
