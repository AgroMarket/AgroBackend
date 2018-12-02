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
    if current_user.amount >= @ask.amount
      if @ask.save
        #create_transaction(current_user, current_user, @ask.amount, @ask, order=nil, "Пополнение")
        create_transaction(current_user, fermastore, @ask.amount, @ask, order=nil, 1)
        render :show, status: :created, json: @ask
      else
        render json: @ask.errors, status: :unprocessable_entity
      end
    else
      build do
        message "На счёте недостаточно средств"
        view 'consumer/transactions/response'
      end
    end
    
  end

  # PATCH/PUT /asks/1
  # PATCH/PUT /asks/1.json
  def update
    if params[:status] == 2 && @ask.status != 2
      @ask.orders.each do |order|
        create_transaction(fermastore, order.producer, (order.total*0.9).to_i, @ask, order, 2)
      end
      create_transaction(fermastore, money_user, (ask.amount*0.1).to_i, @ask, nil, 2)
      create_transaction(fermastore, tk_user, 500, @ask, nil, 2)    
      if @ask.update(ask_params)
        render :show, status: :ok, location: @ask
      else
        render json: @ask.errors, status: :unprocessable_entity
      end
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
