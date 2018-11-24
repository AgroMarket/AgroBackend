class Producer::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /orders
  # GET /orders.json
  def index
    @paginanation = nil

    build do
      if params[:scope] == "pending"
        message 'Новые заказы'
        orders Order.where(producer_id: current_user.id, status: 0).order('created_at DESC')

      elsif params[:scope] == "close"
        message 'Выполненные заказы'
        orders Order.where(producer_id: current_user.id, status: 1).order('created_at DESC')

      elsif params[:scope] == "reject"
        message 'Отклоненные заказы'
        orders Order.where(producer_id: current_user.id, status: 2).order('created_at DESC')

      else
        message 'Продажи производителя'
        orders Order.where(producer_id: current_user.id).order('created_at DESC')
      end

      path consumer_orders_path
      @orders = paginate @orders
      view 'producer/orders/index'
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    build do
      message 'Данные о покупке'
      view 'producer/orders/show'
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    if params[:order][:id]
      build do
        message 'Повторый заказ'
        order Order.create_order_from_order(params[:order][:id])
        view 'producer/orders/show'
      end
    elsif Order.create_orders_from_cart(params[:cart_id])
      build do
        message 'Создание заказов'
        view 'producer/orders/create'
      end
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.update(order_params)
      build do
        message 'Редактирование заказа'
        view 'producer/orders/show'
      end
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.destroy
      build do
        message 'Удаление заказа'
        view 'producer/orders/delete'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status)
    end
end
