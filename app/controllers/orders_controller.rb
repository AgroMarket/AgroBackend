class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  include Exceptable

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = Cart.find params[:cart_id]

    if current_user.amount >= @cart.total
      ask = Order.create_orders_from_cart(params[:cart_id], current_user)

      if ask && create_transaction(current_user, fermastore, ask.amount, ask, nil, 1)
        build do
          message 'Создание заказов'
          view 'orders/create'
        end

      else
        ask.destroy
        build do
          message 'Создание заказов'
          error @order.errors
          status :unprocessable_entity
          view 'orders/create'
        end
      end

    else
      build do
        message 'На счёте недостаточно средств'
        view 'consumer/transactions/response'
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.update(order_params)
      render :show, status: :ok, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:id)
    end
end
