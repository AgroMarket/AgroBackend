class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /products
  # GET /products.json
  def index
    @pagination = nil

    build do
      if params[:category_id]
        message 'Товары категории'
        products Product.by_parent_categories(params[:category_id])
        path category_products_path
        @products = paginate @products

      elsif params[:producer_id]
        message 'Товары производителя'
        products Product.by_producer(params[:producer_id])
        path producer_products_path
        @products = paginate @products

      elsif params[:search]
        message 'Поиск товаров'
        products Product.search(params[:search])
        path products_path
        url_params "search": params[:search]
        @products = paginate @products

      elsif params[:scope] && params[:scope] == 'samples'
        message 'Список случайных товаров'
        products Product.samples
      end

      view 'products/index'
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    build do
      message 'Данные товара'
      view 'products/show'
    end
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
      params.require(:product).permit(:name, :messures, :price, :image, :category_id)
    end
end
