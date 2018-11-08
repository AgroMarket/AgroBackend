class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  include Exceptable

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # POST /items
  # POST /items.json
  def create
    if item_exist?
      @item.quantity += params[:item][:quantity]
    else
      params[:item][:cart_id] = params[:cart_id]
      @item = Item.new(item_params)
    end

    if @item.save
      @cart = @item.cart
      build do
        message 'Новый товар в корзине'
        view 'carts/show'
      end
      # render :show, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if params[:item][:quantity].to_i.zero?
      destroy
    elsif @item.update(item_params)
      @cart = @item.cart
      build do
        message 'Новый товар в корзине'
        view 'carts/show'
      end
      # render :show, status: :ok, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if @item.destroy
      if @item.cart.items.present?
        build do
          message 'Удаление товара из корзины'
          view 'items/delete'
        end
      else
        @cart = @item.cart
        @cart.destroy
        build do
          message 'Удаление корзины'
          view 'carts/delete'
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:cart_id, :user_id, :product_id, :quantity)
    end

    def item_exist?
      @item = Item.find_by(cart_id: params[:cart_id], product_id: params[:item][:product_id])
    end
end
