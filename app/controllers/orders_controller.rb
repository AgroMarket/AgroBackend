class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_cart, only: :create
  include Exceptable

  # POST /orders
  # POST /orders.json
  def create
    build do
      if current_user.enough_money? @cart
        @ask = Order.create_orders_from_cart(@cart.id, current_user)
        message 'Создание заказов'
        view 'member/orders/create'
      else
        message 'На счёте недостаточно средств'
        view 'member/transactions/message'
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find params[:cart_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:id)
  end
end
