class Consumer::AsksController < ApplicationController
  before_action :set_ask, only: [:show, :update, :destroy]
  include Exceptable

  # GET /asks
  # GET /asks.json
  def index
    build do
      @asks = Ask.where(consumer: current_user).includes(:orders).order('created_at DESC')
      message 'Список заказов покупателя'
      view 'consumer/asks/index'
    end
  end

  # GET /asks/1
  # GET /asks/1.json
  def show
    build do
      message 'Заказ покупателя детально'
      view 'consumer/asks/show'
    end
  end

  # POST /asks
  # POST /asks.json
  def create
    @ask = Ask.new(ask_params)
    @ask.consumer = current_user
    if @ask.save
      self.create_transaction(current_user, current_user, @ask.amount, @ask, order=nil, 0)
      self.create_transaction(current_user, fermastore, @ask.amount, @ask, order=nil, 1)
      render :show, status: :created, location: @ask
    else
      render json: @ask.errors, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /asks/1
  # PATCH/PUT /asks/1.json
  def update
    if @ask.update(ask_params)
      render :show, status: :ok, location: @ask
    else
      render json: @ask.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asks/1
  # DELETE /asks/1.json
  def destroy
    @ask.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask
      @ask = Ask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ask_params
      params.require(:ask).permit(:amount, :status)
    end
end
