class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]
  include Exceptable

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    build do
      message 'Корзина товаров'
      view 'carts/show'
    end
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    @cart.consumer = current_user if current_user.present?
    
    if @cart.save
      build do
        message 'Новая корзина'
        view 'carts/show'
      end
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    if @cart.update(cart_params)
      render :show, status: :ok, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    if @cart.cart_items.destroy_all
      build do
        message 'Очищение корзины'
        view 'carts/delete'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: сделать нормальный permit
    def cart_params
      params.fetch(:cart, {})
    end
end
