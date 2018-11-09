class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :update, :destroy]

  # GET /consumers
  # GET /consumers.json
  def index
    @consumers = Consumer.all
  end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
  end

  # POST /consumers
  # POST /consumers.json
  def create
    @consumer = Consumer.new(consumer_params)

    if @consumer.save
      render :show, status: :created, location: @consumer
    else
      render json: @consumer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /consumers/1
  # PATCH/PUT /consumers/1.json
  def update
    if @consumer.update(consumer_params)
      render :show, status: :ok, location: @consumer
    else
      render json: @consumer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /consumers/1
  # DELETE /consumers/1.json
  def destroy
    @consumer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = Consumer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:phome, :email, :password)
    end
end
