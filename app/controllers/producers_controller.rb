class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :update, :destroy]

  # GET /producers
  # GET /producers.json
  def index
    @producers = Producer.all
  end

  # GET /producers/1
  # GET /producers/1.json
  def show
  end

  # POST /producers
  # POST /producers.json
  def create
    @producer = Producer.new(producer_params)

    if @producer.save
      render :show, status: :created, location: @producer
    else
      render json: @producer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /producers/1
  # PATCH/PUT /producers/1.json
  def update
    if @producer.update(producer_params)
      render :show, status: :ok, location: @producer
    else
      render json: @producer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /producers/1
  # DELETE /producers/1.json
  def destroy
    @producer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer
      @producer = Producer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producer_params
      params.require(:producer).permit(:email, :password, :name, :phone, :address, :logo, :brand, :producer_description, :producer_address, :producer_phone, :inn)
    end
end
