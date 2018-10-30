class PagesController < ApplicationController
  before_action :set_page, only: [:show, :update, :destroy]

  def about
    begin
      @page = Page.where(name: 'about').first

      @status = response.status
      @message = 'Страница "О нас"'
      @result = true
      @error = nil

    rescue => ex
      @result = nil
      @error = ex.message
    end

    @view = 'pages/about'
    render 'layouts/response'
  end

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    if @page.save
      render :show, status: :created, location: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    if @page.update(page_params)
      render :show, status: :ok, location: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :title, :content)
    end
end
