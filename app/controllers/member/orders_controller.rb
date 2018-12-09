class Member::OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /orders
  # GET /orders.json
  def index
    @paginanation = nil

    build do
      if params[:scope] == 'pending'
        message 'Новые заказы'
        @orders = Order.where(producer: current_user, status: 0).order('created_at DESC')

      elsif params[:scope] == 'confirmed'
        message 'Заказы в процессе доставки'
        @orders = Order.where(producer: current_user, status: 1).order('created_at DESC')

      elsif params[:scope] == 'completed'
        message 'Доставленные заказы'
        @orders = Order.where(producer: current_user, status: 2).order('created_at DESC')
      elsif params[:scope] == 'declained'
        message 'Отклоненные заказы'
        @orders = Order.where(producer: current_user, status: 3).order('created_at DESC')
      else
        message 'Список продаж'
        @orders = Order.where(producer: current_user).order('created_at DESC')
      end

      @orders_count = @orders.size
      path member_orders_path
      @orders = paginate @orders
      view 'member/orders/index'
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    build do
      message 'Продажа детально'
      view 'member/orders/show'
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    if params[:order][:id]
      build do
        message 'Повторый заказ'
        order Order.create_order_from_order(params[:order][:id])
        view 'member/orders/show'
      end
    elsif Order.create_orders_from_cart(params[:cart_id], current_user)
      build do
        message 'Создание заказов'
        view 'member/orders/create'
      end
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    build do
      if params[:order][:status] == 1
        @order.update!(order_params)
        @task = @order.create_task if @order.ask_confirmed?
        message 'Редактирование заказа'
        view 'member/orders/show'
      end
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
