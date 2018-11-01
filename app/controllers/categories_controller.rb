class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /home
  # GET /home.json
  def home
    begin
      @categories = Category.includes(:children).where(parent_id: 0).order(:rank)
      @products = Product.limit 8

      @status = response.status
      @message = 'Запрос данных для главной страницы'
      @result = true
      @error = nil

    rescue => ex
      @result = nil
      @error = ex.message
    end

    @view = 'categories/home'
    render 'layouts/response'
  end

  # GET /categories
  # GET /categories.json
  def index
    begin
      @categories = Category.includes(:children).where(parent_id: 0).order(:rank)
      # @products = Product.limit 8

      @status = response.status
      @message = 'Список категорий'
      @result = true
      @error = nil

    rescue => ex
      @result = nil
      @error = ex.message
    end

    @view = 'layouts/menu'
    render 'layouts/response'
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render :show, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if @category.update(category_params)
      render :show, status: :ok, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
