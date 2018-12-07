class Member::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /products
  # GET /products.json
  def index
    @pagination = nil

    build do
      message 'Товары производителя'
      products Product.where(producer: current_user).order('created_at DESC')
      path member_products_path
      @products = paginate @products
      view 'member/products/index'
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    build do
      message 'Данные товара'
      view 'member/products/show'
    end
  end

  # POST /products
  # POST /products.json
  def create
    build do
      @product = Product.new(product_params)
      @product.producer = current_user
      @product.image.attach Product.missing_png if @product.save!
      message 'Добавление нового товара'
      view 'member/products/show'
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    build do
      @product.update!(product_params)
      message 'Редактирование товара'
      view 'member/products/show'
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if @product.destroy
      build do
        message 'Удаление товара'
        view 'member/products/show'
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
