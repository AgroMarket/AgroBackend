class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    begin
      if params[:category_id]
        @products = Product.where(category_id: params[:category_id]).page(params[:page]).per(4)
        @message = 'Список товаров по категории'
      elsif params[:scope]
        @products = case params[:scope]
                    when 'samples' then Product.find(Product.pluck(:id).sample(8))
                    else Product.all
                    end
        @message = 'Список случаных товаров'
      elsif params[:search]
        @products = Product.where
        @message = 'Поиск товаров'
      end

      @status = response.status
      @result = true
      @error = nil

    rescue => ex
      @result = nil
      @error = ex.message
    end

    @view = 'products/index'
    render 'layouts/response'
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      render :show, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      render :show, status: :ok, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :messures, :price, :category_id)
    end
end
