class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :update, :destroy]
  include Exceptable

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    if cart_item_exist?
      @cart_item.quantity += params[:cart_item][:quantity]
    else
      params[:cart_item][:cart_id] = params[:cart_id]
      @cart_item = CartItem.new(cart_item_params)
    end

    if @cart_item.save
      @cart = @cart_item.cart

      build do
        message 'Новый товар в корзине'
        view 'carts/show'
      end
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    # if @cart_item.update(cart_item_params)
    #   render :show, status: :ok, location: @cart_item
    # else
    #   render json: @cart_item.errors, status: :unprocessable_entity
    # end

    if params[:cart_item][:quantity].to_i.zero?
      destroy
    elsif @cart_item.update(cart_item_params)
      @cart = @cart_item.cart
      build do
        message 'Изменение количества'
        view 'carts/show'
      end
      # render :show, status: :ok, location: @item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    if @cart_item.destroy
      # if @cart_item.cart.items.present?
        build do
          message 'Удаление товара из корзины'
          view 'cart_items/delete'
        end
      # else
      #   @cart = @cart_item.cart
      #   @cart.destroy
      #   build do
      #     message 'Удаление корзины'
      #     view 'carts/delete'
      #   end
      # end
    end
  end

  private
    def cart_item_exist?
      @cart_item = CartItem.find_by(cart_id: params[:cart_id], product_id: params[:cart_item][:product_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :product_id, :quantity, :sum)
    end
end
