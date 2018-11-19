class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :update, :destroy]

  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      render :show, status: :created, location: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    if @order_item.update(order_item_params)
      render :show, status: :ok, location: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:order_id, :product_id, :price, :quantity, :sum)
    end
end
