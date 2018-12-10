class Producer::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /products
  # GET /products.json
  def index
    @pagination = nil

    build do
      message 'Список товаров производителя'
      products Product.where(producer_id: current_user.id).order('created_at DESC')
      path producer_products_path
      @products = paginate @products
      view 'producer/products/index'
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    build do
      message 'Данные товара'
      view 'producer/products/show'
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.producer = current_user

    if @product.save
      @product.image.attach Product.missing_png

      build do
        message 'Добавление нового товара'
        view 'producer/products/show'
      end
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
    if @product.destroy
      build do
        message 'Удаление товара'
        view 'producer/products/delete'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :measures, :price, :rank, :description, :image, :category_id)
    end
end
